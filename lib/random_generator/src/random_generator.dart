import 'dart:math';

import 'package:ble_data_converter/ble_data_converter.dart';

int randomGenerator(BLEDataConverter converter) {
  final i8max = 127;
  final i16max = 32767;
  final i32max = 2147483647;
  final i64max = 9223372036854775807;
  final u8max = 255;
  final u16max = 65535;
  final u32max = 4294967295;

  switch (converter) {
    case BLEDataConverter.i8:
      return Random().nextInt(i8max);
    case BLEDataConverter.i16:
      return Random().nextInt(i16max);
    case BLEDataConverter.i32:
      return Random().nextInt(i32max);
    case BLEDataConverter.i64:
    case BLEDataConverter.u64:
      return i64max - Random().nextInt(1000000);
    case BLEDataConverter.u8:
      return Random().nextInt(u8max);
    case BLEDataConverter.u16:
      return Random().nextInt(u16max);
    case BLEDataConverter.u32:
      return Random().nextInt(u32max);

    default:
      throw AssertionError();
  }
}
