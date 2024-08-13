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

  List<int> stringToUtf8(String value, {Endian endian = Endian.big}) {
    if (this == str) {
      final encode = utf8.encode(value);
      if (endian == Endian.little) {
        return encode.reversed.toList();
      }
      return encode;
    } else {
      throw AssertionError();
    }
  }

  String stringFromUtf8(List<int> bytes, {Endian endian = Endian.big}) {
    if (this == str) {
      if (endian == Endian.little) {
        return utf8.decode(bytes.reversed.toList());
      }
      return utf8.decode(bytes);
    } else {
      throw AssertionError();
    }
  }

  Uint8List intToBytes(int value, {Endian endian = Endian.big}) {
    final u8List = Uint8List(_byteSize);
    switch (this) {
      case BLEDataConverter.i8:
        u8List.buffer.asInt8List()[0] = value;
        break;
      case BLEDataConverter.i16:
        u8List.buffer.asInt16List()[0] = value;
        break;
      case BLEDataConverter.i32:
        u8List.buffer.asInt32List()[0] = value;
        break;
      case BLEDataConverter.i64:
        u8List.buffer.asInt64List()[0] = value;
        break;
      case BLEDataConverter.u8:
        u8List.buffer.asUint8List()[0] = value;
        break;
      case BLEDataConverter.u16:
        u8List.buffer.asUint16List()[0] = value;
        break;
      case BLEDataConverter.u32:
        u8List.buffer.asUint32List()[0] = value;
        break;
      case BLEDataConverter.u64:
        u8List.buffer.asUint64List()[0] = value;
        break;

      default:
        throw AssertionError();
    }

    if (endian == Endian.little) {
      return Uint8List.fromList(u8List.reversed.toList());
    }

    return u8List;
  }

  int bytesToInt(List<int> bytes, {Endian endian = Endian.big}) {
    switch (this) {
      case BLEDataConverter.str:
        throw AssertionError();
      default:
        var value = 0;

        if (endian == Endian.little) {
          bytes = bytes.reversed.toList(); // リトルエンディアンの場合、バイトを反転
        }

        for (var i = 0, length = bytes.length; i < length; i++) {
          value += bytes[i] * pow(256, i).toInt();
        }

        return value;
    }
  }

  DateTime byteOfMillisecondsToDatetime(List<int> bytes,
      {Endian endian = Endian.big}) {
    final intValue = bytesToInt(bytes, endian: endian);
    return DateTime.fromMillisecondsSinceEpoch(intValue);
  }

  DateTime byteOfMicrosecondsToDatetime(List<int> bytes,
      {Endian endian = Endian.big}) {
    final intValue = bytesToInt(bytes, endian: endian);
    return DateTime.fromMicrosecondsSinceEpoch(intValue);
  }
}
