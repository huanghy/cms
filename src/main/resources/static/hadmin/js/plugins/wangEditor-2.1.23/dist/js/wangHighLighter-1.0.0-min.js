﻿(function(g,m,q){function d(a,b,c,p,d,e){this.rkeywords=a||f.rkeyword;this.rstr=b||f.rstr;this.rreg=e||f.rreg;this.rlineComment=c||f.rlineComment;this.rblockComment=p||f.rblockComment;this.rLabel=f.rLabel;this.wrapLabel="<br/>";this.fontSize=d&&d.fontSize||h.fontSize;this.lineHeight=d&&d.lineHeight||h.lineHeight;this.fontFamily=d&&d.fontFamily||h.fontFamily;a=h.keywordBold;d&&void 0!==d.keywordBold&&(a=d.keywordBold);this.keywordLabel=a?"b":"span"}function e(a){if("string"!==typeof a)return/^\s$/;
a=a.replace(/^\s+/g,"").replace(/\s+$/g,"");return new RegExp(a.replace(/\s+/g,function(){return"\\b|\\b"}),"igm")}if(!m)throw Error("\u8bf7\u68c0\u67e5\u662f\u5426\u5f15\u7528\u4e86jQuery...");if(!g.wangHighLighter){var f={rkeyword:/^\s$/,rstr:/(['"])(\1|(.*?[^\\]\1))/g,rreg:/^\s$/,rlineComment:/\/\/.*?(?=(<br\/>)|$)/gm,rblockComment:/\/\*.*?\*\//gm,rLabel:/<.*?>/gm},h={fontSize:"14px",lineHeight:"20px",fontFamily:"Consolas,Courier New,Inconsolata-g,DejaVu Sans Mono,\u5fae\u8f6f\u96c5\u9ed1,\u5b8b\u4f53",
keywordBold:!0};d.prototype={constructor:d,keywordsDictionary:[],keywordsHL:function(a){var b=this,c=0;b.rkeywords.test(a)&&(a=a.replace(b.rkeywords,function(a){b.keywordsDictionary[c]=a;a="$keywordIndex{"+c+"}";c++;return"<"+b.keywordLabel+" style=$keywordStyle$>"+a+"</"+b.keywordLabel+">"}));return a},strDictionary:[],strHL:function(a){var b=this,c=0;b.rstr.test(a)&&(a=a.replace(b.rstr,function(a){b.rLabel.test(a)&&(a=a.replace(b.rLabel,function(a){return a===b.wrapLabel?(b.strDictionary[c]=a,a=
"$strIndx{"+c+"}",c++,"</span>"+a+"<span style=$strStyle$>"):""}));b.strDictionary[c]=a;a="$strIndex{"+c+"}";c++;return"<span style=$strStyle$>"+a+"</span>"}));return a},regDictionary:[],regHL:function(a){var b=this,c=0;b.rreg.test(a)&&(a=a.replace(b.rreg,function(a){b.rLabel.test(a)&&(a=a.replace(b.rLabel,""));b.regDictionary[c]=a;a="$regIndex{"+c+"}";c++;return"<span style=$regStyle$>"+a+"</span>"}));return a},lineCommentDictionary:[],lineCommentHL:function(a){var b=this,c=0;b.rlineComment.test(a)&&
(a=a.replace(b.rlineComment,function(a){b.rLabel.test(a)&&(a=a.replace(b.rLabel,""));b.lineCommentDictionary[c]=a;a="$lineCommentIndex{"+c+"}";c++;return"<span style=$commentStyle$>"+a+"</span>"}));return a},blockCommentHL:function(a){var b=this;b.rblockComment.test(a)&&(a=a.replace(b.rblockComment,function(a){b.rLabel.test(a)&&(a=a.replace(b.rLabel,function(a){return a===b.wrapLabel?"</span>"+a+"<span style=$commentStyle$>":""}));return"<span style=$commentStyle$>"+a+"</span>"}));return a},codeHL:function(a,
b){var c,d;a=a.replace(/&/gm,"&amp;").replace(/</gm,"&lt;").replace(/>/gm,"&gt;").replace(/\n/gm,this.wrapLabel).replace(/\s{1}/gm,"&nbsp;");a=this.keywordsHL(a);a=this.strHL(a);a=this.regHL(a);a=this.lineCommentHL(a);a=this.blockCommentHL(a);a=a.replace(/\$keywordStyle\$/gm,'"color:'+b.keywordColor+'"').replace(/\$strStyle\$/gm,'"color:'+b.strColor+'"').replace(/\$regStyle\$/gm,'"color:'+b.regColor+'"').replace(/\$commentStyle\$/gm,'"color:'+b.commentColor+'"');c=0;for(d=this.keywordsDictionary.length;c<
d;c++)a=a.replace("$keywordIndex{"+c+"}",this.keywordsDictionary[c]);c=0;for(d=this.strDictionary.length;c<d;c++)a=a.replace("$strIndex{"+c+"}",this.strDictionary[c]);c=0;for(d=this.regDictionary.length;c<d;c++)a=a.replace("$regIndex{"+c+"}",this.regDictionary[c]);c=0;for(d=this.lineCommentDictionary.length;c<d;c++)a=a.replace("$lineCommentIndex{"+c+"}",this.lineCommentDictionary[c]);this.keywordsDictionary=this.strDictionary=this.regDictionary=this.lineCommentDictionary=[];this.otherHL&&"function"===
typeof this.otherHL&&(a=this.otherHL(a));d='<table border="0" cellpadding="0" cellspacing="0" width="100%" style="line-height:${0}; font-size:${1};font-family:${2};color:${3};"> ${tbody} </table>'.replace("${0}",this.lineHeight).replace("${1}",this.fontSize).replace("${2}",this.fontFamily).replace("${3}",b.color);var e;e='<tr valign="top" style="background-color:${0};"> ${content} </tr>'.replace("${0}",b.oddBgColor);var f;f='<tr valign="top" style="background-color:${0};"> ${content} </tr>'.replace("${0}",
b.evenBgColor);var k="",g=[],h;h='<td style="border:0px; border-right-color:${0}; border-right-width:${1}; color:${2}; border-right-style:solid; text-align:right; padding-right:5px; width:40px;"> ${content} </td>'.replace("${0}",b.numBorderColor).replace("${1}",b.numBorderWidth).replace("${2}",b.numColor);var l=k="",n=a.split(this.wrapLabel),m=n.length;for(c=0;c<m;c++)l=n[c],k=h.replace("${content}",c+1),l='<td style="border:0px; padding-left:10px; text-align:left;">${content}</td>'.replace("${content}",
l),k=0===c%2?e.replace("${content}",k+l):f.replace("${content}",k+l),g[c]=k;return d.replace("${tbody}",g.join(""))}};g.wangHighLighter={langs:{actionScript:function(a,b){var c=e("-Infinity rest Array as AS3 Boolean break case catch const continue Date decodeURI decodeURIComponent default delete do dynamic each else encodeURI encodeURIComponent escape extends false final finally flash_proxy for get if implements import in include Infinity instanceof int internal is isFinite isNaN isXMLName label namespace NaN native new null Null Number Object object_proxy override parseFloat parseInt private protected public return set static String super switch this throw true try typeof uint undefined unescape use void while with");
return(new d(c)).codeHL(a,b)},C:function(a,b){var c=e("auto double int struct break else long switch case enum register typedef char extern return union const float short unsigned continue for signed void default goto sizeof volatile do if while static");return(new d(c)).codeHL(a,b)},"C#":function(a,b){var c=e("var abstract as base bool break byte case catch char checked class const continue decimal default delegate do double else enum event explicit extern false finally fixed float for foreach get goto if implicit in int interface internal is lock long namespace new null object operator out override params private protected public readonly ref return sbyte sealed set short sizeof stackalloc static string struct switch this throw true try typeof uint ulong unchecked unsafe ushort using virtual void while");
return(new d(c)).codeHL(a,b)},"C++":function(a,b){var c=e("break case catch class const __finally __exception __try const_cast continue private public protected __declspec default delete deprecated dllexport dllimport do dynamic_cast else enum explicit extern if for friend goto inline mutable naked namespace new noinline noreturn nothrow register reinterpret_cast return selectany sizeof static static_cast struct switch template this thread throw true false try typedef typeid typename union using uuid virtual void volatile whcar_t while");
return(new d(c)).codeHL(a,b)},css:function(a,b){var c=e("ascent azimuth background-attachment background-color background-image background-position background-repeat background baseline bbox border-collapse border-color border-spacing border-style border-top border-right border-bottom border-left border-top-color border-right-color border-bottom-color border-left-color border-top-style border-right-style border-bottom-style border-left-style border-top-width border-right-width border-bottom-width border-left-width border-width border bottom cap-height caption-side centerline clear clip color content counter-increment counter-reset cue-after cue-before cue cursor definition-src descent direction display elevation empty-cells float font-size-adjust font-family font-size font-stretch font-style font-variant font-weight font height left letter-spacing line-height list-style-image list-style-position list-style-type list-style margin-top margin-right margin-bottom margin-left margin marker-offset marks mathline max-height max-width min-height min-width orphans outline-color outline-style outline-width outline overflow padding-top padding-right padding-bottom padding-left padding page page-break-after page-break-before page-break-inside pause pause-after pause-before pitch pitch-range play-during position quotes right richness size slope src speak-header speak-numeral speak-punctuation speak speech-rate stemh stemv stress table-layout text-align top text-decoration text-indent text-shadow text-transform unicode-bidi unicode-range units-per-em vertical-align visibility voice-family volume white-space widows width widths word-spacing x-height z-index");
hl=new d(c,/^\s$/,/^\s$/,void 0,{keywordBold:!1});return hl.codeHL(a,b)},delphi:function(a,b){var c=e("abs addr and ansichar ansistring array as asm begin boolean byte cardinal case char class comp const constructor currency destructor div do double downto else end except exports extended false file finalization finally for function goto if implementation in inherited int64 initialization integer interface is label library longint longword mod nil not object of on or packed pansichar pansistring pchar pcurrency pdatetime pextended pint64 pointer private procedure program property pshortstring pstring pvariant pwidechar pwidestring protected public published raise real real48 record repeat set shl shortint shortstring shr single smallint string then threadvar to true try type unit until uses val var varirnt while widechar widestring with word write writeln xor");
hl=new d(c,void 0,void 0,/(\(\*.*?\*\))|({.*?})/gm);return hl.codeHL(a,b)},"F#":function(a,b){var c=e("abstract lsl and lsr as lxor assert match member asr modbegin module class mutable namespace default new delegate nulldo of done open downcast or downto overrideelse rec end sig exception static false  structfinally then for to fun true function tryif type in val inherit when inline upcastinterface while land  with lor async method atomic mixin break namespace checked object component process const property constraint  protected constructor public continue pure decimal readonly eager return enum sealed event switch external virtual fixed void functor volatile include where");
return(new d(c)).codeHL(a,b)},Go:function(a,b){var c=e("break default func interface select case defer go map struct chan else goto package switch const fallthrough if range type continue for import return var");return(new d(c)).codeHL(a,b)},html:function(a,b){rlineComment=/^\s$/;rblockComment=/&lt;!--.*?--&gt;/gm;hl=new d(/&lt;(?!!--)\/?((html)|(head)|(body)|(style)|(script)).*?&gt;/igm,/^\s$/,rlineComment,rblockComment,{keywordBold:!1});return hl.codeHL(a,b)},java:function(a,b){var c=e("abstract assert boolean break byte case catch char class const continue default do double else enum extends false final finally float for goto if implements import instanceof int interface long native new null package private protected public return short static strictfp super switch synchronized this throw throws true transient try void volatile while");
return(new d(c)).codeHL(a,b)},javascript:function(a,b){var c=e("break case catch  continue default delete do else false  for function if in instanceof new null return super switch this throw true try typeof var while with regexp");return(new d(c,void 0,void 0,void 0,void 0,/^\s$/)).codeHL(a,b)},"objective-C":function(a,b){var c=e("int long float double char void bool  NSNumber NSString NSMutableString NSMutableArray NSArray NSMutableSet NSSet NSMutableDictionary NSDictionary for in return while do break continue if else NSObject NSInteger");
return(new d(c)).codeHL(a,b)},pascal:function(a,b){var c=e("absolute abstract and array as asm assembler at automated  begin case  cdecl class const constructor contains default destructor dispid dispinterface div  do downto dynamic else end except export exports external far file finalization finally for forward function goto if implementation implements in index inherited initialization  inline interface  is label  library message  mod name near nil nodefault not object of on or out overload override package packed  pascal private  procedure program property protected public  published raise  read   readonly record   register   reintroduce repeat   requires resident   resourcestring  safecall set   shl    shr  stdcall    stored  string  then  threadvar to  try    type  unit  until  uses  var    virtual   while  with  write   writeonly");
return(new d(c,void 0,void 0,/(\(\*.*?\*\))|({.*?})/gm)).codeHL(a,b)},perl:function(a,b){var c=e("bless caller continue dbmclose dbmopen die do dump else elsif eval exit for foreach goto if import last local my next no our package redo ref require return sub tie tied unless untie until use wantarray while");return(new d(c,void 0,/#.*?(?=(<br\/>)|$)/gm,/=.+?=cut/gm)).codeHL(a,b)},php:function(a,b){var c=e("and or xor array as break case cfunction class const continue declare default die do else elseif enddeclare endfor endforeach endif endswitch endwhile extends for foreach function include include_once global if new old_function return static switch use require require_once var while abstract interface public implements extends private protected throw");
return(new d(c)).codeHL(a,b)},powershell:function(a,b){var c=e("Add-Content Add-History Add-Member Add-PSSnapin Clear Clear-Item Clear-ItemProperty Clear-Variable Compare-Object ConvertFrom-SecureString Convert-Path ConvertTo-Html ConvertTo-SecureString Copy Copy-ItemProperty Export-Alias Export-Clixml Export-Console Export-Csv ForEach Format-Custom Format-List Format-Table Format-Wide Get-Acl Get-Alias Get-AuthenticodeSignature Get-ChildItem Get-Command Get-Content Get-Credential Get-Culture Get-Date Get-EventLog Get-ExecutionPolicy Get-Help Get-History Get-Host Get-Item Get-ItemProperty Get-Location Get-Member Get-PfxCertificate Get-Process Get-PSDrive Get-PSProvider Get-PSSnapin Get-Service Get-TraceSource Get-UICulture Get-Unique Get-Variable Get-WmiObject Group-Object Import-Alias Import-Clixml Import-Csv Invoke-Expression Invoke-History Invoke-Item Join-Path Measure-Command Measure-Object Move Move-ItemProperty New-Alias New-Item New-ItemProperty New-Object New-PSDrive New-Service New-TimeSpan New-Variable Out-Default Out-File Out-Host Out-Null Out-Printer Out-String Pop-Location Push-Location Read-Host Remove-Item Remove-ItemProperty Remove-PSDrive Remove-PSSnapin Remove-Variable Rename-Item Rename-ItemProperty Resolve-Path Restart-Service Resume-Service Select-Object Select-String Set-Acl Set-Alias Set-AuthenticodeSignature Set-Content Set-Date Set-ExecutionPolicy Set-Item Set-ItemProperty Set-Location Set-PSDebug Set-Service Set-TraceSource Set Sort-Object Split-Path Start-Service Start-Sleep Start-Transcript Stop-Process Stop-Service Stop-Transcript Suspend-Service Tee-Object Test-Path Trace-Command Update-FormatData Update-TypeData Where Write-Debug Write-Error Write Write-Output Write-Progress Write-Verbose Write-Warning");
hl=new d(c,void 0,/#.*?(?=(<br\/>)|$)/gm,/&lt;(<.+>)?#.*?#&gt;/gm);return hl.codeHL(a,b)},python:function(a,b){var c=e("and assert break class continue def del elif else except exec finally for from global if import in is lambda not or pass print raise return try yield while");return(new d(c,/(['"(''')(""")])(\1|(.*?[^\\]\1))/gm,/#.*?(?=(<br\/>)|$)/gm,/^\s$/)).codeHL(a,b)},ruby:function(a,b){var c=e("alias and BEGIN begin break case class def define_method defined do each else elsif END end ensure false for if in module new next nil not or raise redo rescue retry return self super then throw true undef unless until when while yield");
return(new d(c,void 0,/#.*?(?=(<br\/>)|$)/gm,/=(<.+?>)?begin(<\/.+?>)?(&nbsp;)+?.*?=(<.+?>)?end(<\/.+?>)?/gm)).codeHL(a,b)},SQL:function(a,b){var c=e("absolute action add after alter as asc at authorization begin bigint binary bit by cascade char character check checkpoint close collate column commit committed connect connection constraint contains continue create cube current current_date current_time cursor database date deallocate dec decimal declare default delete desc distinct double drop dynamic else end end-exec escape except exec execute false fetch first float for force foreign forward free from full function global goto grant group grouping having hour ignore index inner insensitive insert instead int integer intersect into is isolation key last level load local max min minute modify move name national nchar next no numeric of off on only open option order out output partial password precision prepare primary prior privileges procedure public read real references relative repeatable restrict return returns revoke rollback rollup rows rule schema scroll second section select sequence serializable set size smallint static statistics table temp temporary then time timestamp to top transaction translation trigger true truncate uncommitted union unique update values varchar varying view when where with work");
return(new d(c,void 0,/-.*?(?=(<br\/>)|$)/gm)).codeHL(a,b)},swift:function(a,b){var c=e("class deinit enum extension func import init let protocol static struct subscript typealias var  break case continue default do else fallthrough if in for return switch where while  as dynamicType is new super self Self Type __COLUMN__ __FILE__ __FUNCTION__ __LINE__  associativity didSet get infix inout left mutating none nonmutating operator override postfix precedence prefix rightset unowned unowned unowned weak willSet");
return(new d(c)).codeHL(a,b)},vb:function(a,b){var c=e("AddHandler AddressOf AndAlso Alias And Ansi As Assembly Auto Boolean ByRef Byte ByVal Call Case Catch CBool CByte CChar CDate CDec CDbl Char CInt Class CLng CObj Const CShort CSng CStr CType Date Decimal Declare Default Delegate Dim DirectCast Do Double Each Else ElseIf End Enum Erase Error Event Exit False Finally For Friend Function Get GetType GoSub GoTo Handles If Implements Imports In Inherits Integer Interface Is Let Lib Like Long Loop Me Mod Module MustInherit MustOverride MyBase MyClass Namespace New Next Not Nothing NotInheritable NotOverridable Object On Option Optional Or OrElse Overloads Overridable Overrides ParamArray Preserve Private Property Protected Public RaiseEvent ReadOnly ReDim REM RemoveHandler Resume Return Select Set Shadows Shared Short Single Static Step Stop String Structure Sub SyncLock Then Throw To True Try TypeOf Unicode Until Variant When While With WithEvents WriteOnly Xor");
return(new d(c,null,/'.*?(?=(<br\/>)|$)/gm,/^\s$/)).codeHL(a,b)},xml:function(a,b){return(new d(/^\s$/,void 0,/^\s$/,/&lt;!--.*?--&gt;/gm)).codeHL(a,b)}},themes:{simple:{evenBgColor:"#ffffff",oddBgColor:"#f1f1f1",numColor:"#c7c7c7",numBorderColor:"#6ce26c",numBorderWidth:"3px",color:"#000000",keywordColor:"#1a76a3",strColor:"#0000ff",regColor:"#0000ff",commentColor:"#008200"},"visual Studio":{evenBgColor:"#ffffff",oddBgColor:"#ffffff",numColor:"#2b91af",numBorderColor:"#a5a5a5",numBorderWidth:"1px",
color:"#000000",keywordColor:"#0000ff",strColor:"#a31515",regColor:"#a31515",commentColor:"#008000"},eclipse:{evenBgColor:"#ffffff",oddBgColor:"#ffffff",numColor:"#848484",numBorderColor:"#d4d0c8",numBorderWidth:"1px",color:"#000000",keywordColor:"#7f0055",strColor:"#2a00ff",regColor:"#2a00ff",commentColor:"#647ecb"},sublime:{evenBgColor:"#272822",oddBgColor:"#272822",numColor:"#8f908a",numBorderColor:"#464741",numBorderWidth:"1px",color:"#f8f8f2",keywordColor:"#e92744",strColor:"#ae81ff",regColor:"#ae81ff",
commentColor:"#75715e"},django:{evenBgColor:"#0a2b1d",oddBgColor:"#0b2f20",numColor:"#437252",numBorderColor:"#41a83e",numBorderWidth:"3px",color:"#f8f8f8",keywordColor:"#96dd3b",strColor:"#9df39f",regColor:"#9df39f",commentColor:"#336442"},emacs:{evenBgColor:"#0f0f0f",oddBgColor:"#000000",numColor:"#bdbdbd",numBorderColor:"#990000",numBorderWidth:"3px",color:"#d3d3d3",keywordColor:"#01e7e7",strColor:"#ff9e7b",regColor:"#ff9e7b",commentColor:"#ff7d27"},fadeToGrey:{evenBgColor:"#000000",oddBgColor:"#121212",
numColor:"#c3c3c3",numBorderColor:"#3185b9",numBorderWidth:"3px",color:"#dddddd",keywordColor:"#d01d33",strColor:"#e3e658",regColor:"#e3e658",commentColor:"#696854"},midNight:{evenBgColor:"#0f192a",oddBgColor:"#0f192a",numColor:"#345067",numBorderColor:"#435a5f",numBorderWidth:"3px",color:"#d1edff",keywordColor:"#b43d3d",strColor:"#1dc116",regColor:"#1dc116",commentColor:"#428bdd"},rDark:{evenBgColor:"#1b2426",oddBgColor:"#1b2426",numColor:"#b9bdb6",numBorderColor:"#435a5f",numBorderWidth:"3px",color:"#b9bdb6",
keywordColor:"#5ba1cf",strColor:"#5ce638",regColor:"#5ce638",commentColor:"#878a85"}},highLight:function(a,b,c){if(a="string"===typeof a?g.wangHighLighter.langs[a]:void 0)if(b="string"===typeof b?g.wangHighLighter.themes[b]:void 0)return a(c,b)},getLangArray:function(){var a=[],b;for(b in wangHighLighter.langs)a.push(b);return a},getThemeArray:function(){var a=[],b;for(b in wangHighLighter.themes)a.push(b);return a}}}})(window,window.jQuery);