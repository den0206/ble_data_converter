<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# Purpose

This package is for easy conversion to rawdata(`List<int>`) to be sent to BLE devices, etc.  
The types supported by this package are `utf8`, `int8/16/32/64`, `uint8/16/32/64`.  
it is based on Swift(iOS) int type.

## How to Use

- **String to utf-8**

``` dart

  // encode
  const String sampleStr = "sample";
  final List<int> strData = BLEDataConverter.str.stringToUtf8(randomStr);

  print(strData) // [115, 97, 109, 112, 108, 101]
  
  // decode
  final String decodeStr = BLEDataConverter.str.stringFromUtf8(strData)

  print(decodeStr) // "sample"

```

- **int to int64 byte data**

``` dart

  // encode
  final int i64Max = 9223372036854775807;
  final List<int> value = BLEDataConverter.i64.intToBytes(i64Max);

  print(value); // [255, 255, 255, 255, 255, 255, 255, 127]

  // decode
  final int decode = BLEDataConverter.i64.bytesToInt(value);

  print(decode); // 9223372036854775807

```


## Compatible Type

|Type|byte length| max | min |
| - | - | - | - |
|Int8|1|127|-128|
|Int16|2|32767|-32768|
|Int32|4|2147483647|-2147483648|
|Int64|8|9223372036854775807|-9223372036854775808|
|UInt8|1|255|0|
|UInt16|2|65535|0|
|UInt32|4|4294967295|0|
|UInt64|8|18446744073709551615|0|

|Type|byte Length|
| - | - |
|utf8|[reference](https://mothereff.in/byte-counter)|

