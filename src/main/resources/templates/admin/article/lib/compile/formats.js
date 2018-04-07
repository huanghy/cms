 time.
  #
  def root?(name)
    in_transaction
    @table.key? name
  end
  # Returns the path to the data store file.
  def path
    @filename
  end

  #
  # Ends the current PStore#transaction, committing any changes to the data
  # store immediately.
  #
  # == Example:
  #
  #  require "pstore"
  #
  #  store = PStore.new("data_file.pstore")
  #  store.transaction do  # begin transaction
  #    # load some data into the store...
  #    store[:one] = 1
  #    store[:two] = 2
  #
  #    store.commit        # end transaction here, committing changes
  #
  #    store[:three] = 3   # this change is never reached
  #  end
  #
  # *WARNING*:  This method is only valid in a PStore#transaction.  It will
  # raise PStore::Error if called at any other time.
  #
  def commit
    in_transaction
    @abort = false
    throw :pstore_abort_transaction
  end
  #
  # Ends the current PStore#transaction, discarding any changes to the data
  # store.
  #
  # == Example:
  #
  #  require "pstore"
  #
  #  store = PStore.new("data_file.pstore")
  #  store.transaction do  # begin transaction
  #    store[:one] = 1     # this change is not applied, see below...
  #    store[:two] = 2     # this change is not applied, see below...
  #
  #    store.abort         # end transaction here, discard all changes
  #
  #    store[:three] = 3   # this change is never reached
  #  end
  #
  # *WARNING*:  This method is only valid in a PStore#transaction.  It will
  # raise PStore::Error if called at any other time.
  #
  def abort
    in_transaction
    @abort = true
    throw :pstore_abort_transaction
  end

  #
  # Opens a new transaction for the data store.  Code executed inside a block
  # passed to this method may read and write data to and from the data store
  # file.
  #
  # At the end of the block, changes are committed to the data store
  # automatically.  You may exit the transaction early with a call to either
  # PStore#commit or PStore#abort.  See those methods for details about how
  # changes are handled.  Raising an uncaught Exception in the block is
  # equivalent to calling PStore#abort.
  #
  # If _read_only_ is set to +true+, you will only be allowed to read from the
  # data store during the transaction and any attempts to change the data will
  # raise a PStore::Error.
  #
  # Note that PStore does not support nested transactions.
  #
  def transaction(read_only = false, &block)  # :yields:  pstore
    value = nil
    raise PStore::Error, "nested transaction" if @transaction
    @lock.synchronize do
      @rdonly = read_only
      @transaction = true
      @abort = false
      file = open_and_lock_file(@filename, read_only)
      if file
        begin
          @table, checksum, original_data_size = load_data(file, read_only)

          catch(:pstore_abort_transaction) do
            value = yield(self)
          end

          if !@abort && !read_only
            save_data(checksum, original_data_size, file)
          end
        ensure
          file.close if !file.closed?
        end
      else
        # This can only occur if read_only == true.
        @table = {}
        catch(:pstore_abort_transaction) do
          value = yield(self)
        end
      end
    end
    value
  ensure
    @transaction = false
  end

  private
  # Constant for relieving Ruby's garbage collector.
  EMPTY_STRING = ""
  EMPTY_MARSHAL_DATA = Marshal.dump({})
  EMPTY_MARSHAL_CHECKSUM = Digest::MD5.digest(EMPTY_MARSHAL_DATA)

  class DummyMutex
    def synchronize
      yield
    end
  end

  #
  # Open the specified filename (either in read-only mode or in
  # read-write mode) and lock it for reading or writing.
  #
  # The opened File object will be returned. If _read_only_ is true,
  # and the file does not exist, then nil will be returned.
  #
  # All exceptions are propagated.
  #
  def open_and_lock_file(filename, read_only)
    if read_only
      begin
        file = File.new(filename, RD_ACCESS)
        begin
          file.flock(File::LOCK_SH)
          return file
        rescue
          file.close
          raise
        end
      rescue Errno::ENOENT
        return nil
      end
    else
      file = File.new(filename, RDWR_ACCESS)
      file.flock(File::LOCK_EX)
      return file
    end
  end

  # Load the given PStore file.
  # If +read_only+ is true, the unmarshalled Hash will be returned.
  # If +read_only+ is false, a 3-tuple will be returned: the unmarshalled
  # Hash, an MD5 checksum of the data, and the size of the data.
  def load_data(file, read_only)
    if read_only
      begin
        table = load(file)
        if !table.is_a?(Hash)
          raise Error, "PStore file seems to be corrupted."
        end
      rescue EOFError
        # This seems to be a newly-created file.
        table = {}
      end
      table
    else
      data = file.read
      if data.empty?
        # This seems to be a newly-created file.
        table = {}
        checksum = empty_marshal_checksum
        size = empty_marshal_data.size
      else
        table = load(data)
        checksum = Digest::MD5.digest(data)
        size = data.size
        if !table.is_a?(Hash)
          raise Error, "PStore file seems to be corrupted."
        end
      end
      data.replace(EMPTY_STRING)
      [table, checksum, size]
    end
  end

  def on_windows?
    is_windows = RUBY_PLATFORM =~ /mswin/  ||
                 RUBY_PLATFORM =~ /mingw/  ||
                 RUBY_PLATFORM =~ /bccwin/ ||
                 RUBY_PLATFORM =~ /wince/
    self.class.__send__(:define_method, :on_windows?) do
      is_windows
    end
    is_windows
  end

  # Check whether Marshal.dump supports the 'canonical' option. This option
  # makes sure that Marshal.dump always dumps data structures in the same order.
  # This is important because otherwise, the checksums that we generate may differ.
  def marshal_dump_supports_canonical_option?
    begin
      Marshal.dump(nil, -1, true)
      result = true
    rescue
      result = false
    end
    self.class.__send__(:define_method, :marshal_dump_supports_canonical_option?) do
      result
    end
    result
  end

  def save_data(original_checksum, original_file_size, file)
    # We only want to save the new data if the size or checksum has changed.
    # This results in less filesystem calls, which is good for performance.
    if marshal_dump_supports_canonical_option?
      new_data = Marshal.dump(@table, -1, true)
    else
      new_data = dump(@table)
    end
    new_checksum = Digest::MD5.digest(new_data)

    if new_data.size != original_file_size || new_checksum != original_checksum
      if @ultra_safe && !on_windows?
        # Windows doesn't support atomic file renames.
        save_data_with_atomic_file_rename_strategy(new_data, file)
      else
        save_data_with_fast_strategy(new_data, file)
      end
    end

    new_data.replace(EMPTY_STRING)
  end

  def save_data_with_atomic_file_rename_strategy(data, file)
    temp_filename = "#{@filename}.tmp.#{Process.pid}.#{rand 1000000}"
    temp_file = File.new(temp_filename, WR_ACCESS)
    begin
      temp_file.flock(File::LOCK_EX)
      temp_file.write(data)
      temp_file.flush
      File.rename(temp_filename, @filename)
    rescue
      File.unlink(temp_file) rescue nil
      raise
    ensure
      temp_file.close
    end
  end

  def save_data_with_fast_strategy(data, file)
    file.rewind
    file.truncate(0)
    file.write(data)
  end


  # This method is just a wrapped around Marshal.dump
  # to allow subclass overriding used in YAML::Store.
  def dump(table)  # :nodoc:
    Marshal::dump(table)
  end

  # This method is just a wrapped around Marshal.load.
  # to allow subclass overriding used in YAML::Store.
  def load(content)  # :nodoc:
    Marshal::load(content)
  end

  def empty_marshal_data
    EMPTY_MARSHAL_DATA
  end
  def empty_marshal_checksum
    EMPTY_MARSHAL_CHECKSUM
  end
end

# :enddoc:

if __FILE__ == $0
  db = PStore.new("/tmp/foo")
  db.transaction do
    p db.roots
    ary = db["root"] = [1,2,3,4]
    ary[1] = [1,1.5]
  end

  1000.times do
    db.transaction do
      db["root"][0] += 1
      p db["root"][0]
    end
  end

  db.transaction(true) do
    p db["root"]
  end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  