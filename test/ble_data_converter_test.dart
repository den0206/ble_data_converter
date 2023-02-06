import 'package:ble_data_converter/ble_data_converter/src/ble_data_converter.dart';
import 'package:ble_data_converter/random_generator/src/random_generator.dart';
import 'package:date_utils/date_utils.dart';
import 'package:test/test.dart';

void main() {
  group('string test', () {
    final converter = BLEDataConverter.str;

    test('string test', () {
      final String value = 'test string';

      final encode = converter.stringToUtf8(value);
      final decode = converter.stringFromUtf8(encode);
      expect(value, decode);
    });

    test('string test AssertionError', () {
      final int value = 10;

      expect(() => converter.intToBytes(value), throwsA(isA<AssertionError>()));
    });
  });

  group('i8 test', () {
    final converter = BLEDataConverter.i8;
    test('i8 test', () {
      final int value = randomGenerator(converter);

      final encode = converter.intToBytes(value);
      final decode = converter.bytesToInt(encode);
      expect(value, decode);
    });

    test(
      'i8 test AssertionError',
      () {
        final String value = "1111";

        expect(() => converter.stringToUtf8(value),
            throwsA(isA<AssertionError>()));
      },
    );
  });

  group('i16 test', () {
    final converter = BLEDataConverter.i16;
    test('i16 test', () {
      final int value = 0x0200;

      final encode = converter.intToBytes(value);
      final decode = converter.bytesToInt(encode);
      expect(value, decode);
    });

    test('random i16 test', () {
      final int value = randomGenerator(converter);

      final encode = converter.intToBytes(value);
      final decode = converter.bytesToInt(encode);
      expect(value, decode);
    });
  });

  group('i32 test', () {
    final converter = BLEDataConverter.i32;
    test('string test', () {
      final int value = randomGenerator(converter);

      final encode = converter.intToBytes(value);
      final decode = converter.bytesToInt(encode);
      expect(value, decode);
    });
  });

  group('i64 test', () {
    final converter = BLEDataConverter.i64;
    test('i64 test', () {
      final int value = randomGenerator(converter);

      final encode = converter.intToBytes(value);
      final decode = converter.bytesToInt(encode);
      expect(value, decode);
    });

    test('millisecond test', () {
      final now = DateTime.now();
      final millDate = now.millisecondsSinceEpoch;

      final encode = converter.intToBytes(millDate);
      final decodeDate = converter.byteOfMillisecondsToDatetime(encode);

      expect(DateUtils.isSameDay(now, decodeDate), true);
      expect(now.hour, decodeDate.hour);
      expect(now.second, decodeDate.second);
    });

    test('microsecond test', () {
      final now = DateTime.now();
      final millDate = now.microsecondsSinceEpoch;

      final encode = converter.intToBytes(millDate);
      final decodeDate = converter.byteOfMicrosecondsToDatetime(encode);

      expect(DateUtils.isSameDay(now, decodeDate), true);
      expect(now.minute, decodeDate.minute);
      expect(now.second, decodeDate.second);
    });
  });

  group('random', () {
    BLEDataConverter converter;

    test('intToBytes for BLEDataConverter.i8', () {
      converter = BLEDataConverter.i8;
      final value = 255;
      final result = converter.intToBytes(value);
      expect(result.length, 1);
      expect(result[0], value);
    });

    test('intToBytes for BLEDataConverter.i16', () {
      converter = BLEDataConverter.i16;
      final value = 6551;
      final result = converter.intToBytes(value);
      expect(result.length, 2);
      expect(result.buffer.asInt16List()[0], value);
    });

    test('intToBytes for BLEDataConverter.i32', () {
      converter = BLEDataConverter.i32;
      final value = 42949672;
      final result = converter.intToBytes(value);
      expect(result.length, 4);
      expect(result.buffer.asInt32List()[0], value);
    });

    test('intToBytes for BLEDataConverter.i64', () {
      converter = BLEDataConverter.i64;
      final value = 9223372036854775807;
      final result = converter.intToBytes(value);
      expect(result.length, 8);
      expect(result.buffer.asInt64List()[0], value);
    });
  });
}
