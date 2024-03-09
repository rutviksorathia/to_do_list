import 'dart:math';

const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));

String timeConverter(int number) {
  String time = '';
  int min = (number % 3600) ~/ 60;
  int sec = number % 60;

  time = "${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}";

  return time;
}
