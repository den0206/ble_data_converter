import 'package:ble_data_converter/ble_data_converter.dart';

void main() {
  tryConverter();
}

void tryConverter() {
  List<int> body = [];

  // id(i16)
  const functionId = 0x0200;
  final functionData =
      BLEDataConverter.i16.intToBytes(functionId).reversed.toList();

  body.addAll(functionData);

  // id(i8)
  const requestId = 255;
  final requestData = BLEDataConverter.i8.intToBytes(requestId);
  body.addAll(requestData);

  // random str(utf8)
  const randomStr = "adf";
  final tokenData = BLEDataConverter.str.stringToUtf8(randomStr);

  body.addAll(tokenData);

  // timestamp(i64)
  final milSecounds = DateTime.now().millisecondsSinceEpoch;
  final timestampData =
      BLEDataConverter.i64.intToBytes(milSecounds).reversed.toList();

  print(BLEDataConverter.i64
      .byteOfMillisecondsToDatetime(timestampData.reversed.toList()));

  body.addAll(timestampData);

  // random num(i16)
  const commandType = 32769;
  final commandData =
      BLEDataConverter.i16.intToBytes(commandType).reversed.toList();

  body.addAll(commandData);

  print(
      body); //[2, 0, 255, 97, 100, 102, 0, 0, 1, 134, 33, 13, 184, 13, 128, 1]

  print(body.length); // 16
}
