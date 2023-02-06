library ble_data_converter;

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

enum BLEDataConverter {
  str,
  i8,
  i16,
  i32,
  i64,
  u8,
  u16,
  u32,
  u64;

  int get _byteSize {
    switch (this) {
      case BLEDataConverter.i8:
      case BLEDataConverter.u8:
        return 1;
      case BLEDataConverter.i16:
      case BLEDataConverter.u16:
        return 2;
      case BLEDataConverter.i32:
      case BLEDataConverter.u32:
        return 4;
      case BLEDataConverter.i64:
      case BLEDataConverter.u64:
        return 8;
      default:
        throw AssertionError();
    }
  }

  List<int> stringToUtf8(String value) {
    if (this == str) {
      return utf8.encode(value);
    } else {
      throw AssertionError();
    }
  }

  String stringFromUtf8(List<int> bytes) {
    if (this == str) {
      return utf8.decode(bytes);
    } else {
      throw AssertionError();
    }
  }

  Uint8List intToBytes(int value) {
    final u8List = Uint8List(_byteSize);
    switch (this) {
      case BLEDataConverter.i8:
        return (u8List..buffer.asInt8List()[0] = value);
      case BLEDataConverter.i16:
        return u8List..buffer.asInt16List()[0] = value;
      case BLEDataConverter.i32:
        return u8List..buffer.asInt32List()[0] = value;
      case BLEDataConverter.i64:
        return u8List..buffer.asInt64List()[0] = value;
      case BLEDataConverter.u8:
        return (u8List..buffer.asUint8List()[0] = value);
      case BLEDataConverter.u16:
        return (u8List..buffer.asUint16List()[0] = value);
      case BLEDataConverter.u32:
        return (u8List..buffer.asUint32List()[0] = value);
      case BLEDataConverter.u64:
        return (u8List..buffer.asUint64List()[0] = value);

      default:
        throw AssertionError();
    }
  }

  int bytesToInt(List<int> bytes) {
    switch (this) {
      case BLEDataConverter.str:
        throw AssertionError();
      default:
        var value = 0;

        for (var i = 0, length = bytes.length; i < length; i++) {
          value += bytes[i] * pow(256, i).toInt();
        }

        return value;
    }
  }

  DateTime byteOfMillisecondsToDatetime(List<int> bytes) {
    final intValue = bytesToInt(bytes);
    return DateTime.fromMillisecondsSinceEpoch(intValue);
  }

  DateTime byteOfMicrosecondsToDatetime(List<int> bytes) {
    final intValue = bytesToInt(bytes);
    return DateTime.fromMicrosecondsSinceEpoch(intValue);
  }
}
