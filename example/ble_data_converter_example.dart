import 'package:ble_data_converter/ble_data_converter.dart';

void main() {
  tryConverter();
}

void tryConverter() {
  List<int> body = [];

  // id(i16)
  const sampleID = 0x0200;
  final sampleData =
      BLEDataConverter.i16.intToBytes(sampleID).reversed.toList();

  body.addAll(sampleData);

  // id(i8)
  const requestId = 255;
  final requestData = BLEDataConverter.i8.intToBytes(requestId);
  body.addAll(requestData);

  // random str(utf8)
  const randomStr = "sample";
  final strData = BLEDataConverter.str.stringToUtf8(randomStr);

  body.addAll(strData);

  // timestamp(i64)
  final milSecounds = DateTime.now().millisecondsSinceEpoch;
  // convert milliseconds to secounds;
  final secounds = milSecounds ~/ (1000);

  final timestampData =
      BLEDataConverter.i64.intToBytes(secounds).reversed.toList();

  // Datetime type
  print(_byteOdSecoundsToDatetime(timestampData.reversed.toList()));

  body.addAll(timestampData);

  // random num(i16)
  const fizzType = 32769;
  final fizzData = BLEDataConverter.i16.intToBytes(fizzType).reversed.toList();

  body.addAll(fizzData);

  print(
      body); //[2, 0, 255, 97, 100, 102, 0, 0, 1, 134, 33, 13, 184, 13, 128, 1]

  print(body.length); // 16
}

// seconds(timestamp) to Datetime
// this methods not include package.
DateTime _byteOdSecoundsToDatetime(List<int> bytes) {
  final intValue = BLEDataConverter.i64.bytesToInt(bytes);
  return DateTime.fromMillisecondsSinceEpoch(intValue * 1000);
}
