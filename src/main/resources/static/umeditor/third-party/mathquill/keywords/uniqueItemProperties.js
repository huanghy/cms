# ASN1.js

ASN.1 DER Encoder/Decoder and DSL.

## Example

Define model:

```javascript
var asn = require('asn1.js');

var Human = asn.define('Human', function() {
  this.seq().obj(
    this.key('firstName').octstr(),
    this.key('lastName').octstr(),
    this.key('age').int(),
    this.key('gender').enum({ 0: 'male', 1: 'female' }),
    this.key('bio').seqof(Bio)
  );
});

var Bio = asn.define('Bio', function() {
  this.seq().obj(
    this.key('time').gentime(),
    this.key('description').octstr()
  );
});
```

Encode data:

```javascript
var output = Human.encode({
  firstName: 'Thomas',
  lastName: 'Anderson',
  age: 28,
  gender: 'male',
  bio: [
    {
      time: +new Date('31 March 1999'),
      description: 'freedom of mind'
    }
  ]
}, 'der');
```

Decode data:

```javascript
var human = Human.decode(outp