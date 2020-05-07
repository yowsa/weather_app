import 'package:intl/intl.dart';

class DateHelper {
  static String localFormatDate(int secondsFromUTC, int timestamp,
      {String dateFormat = 'yyyy-MM-dd'}) {
    DateTime localDateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true)
        .add(Duration(seconds: secondsFromUTC));
    String formattedDate = DateFormat(dateFormat).format(localDateTime);
    return formattedDate;
  }

  static String getToday(int timezone, {String dateFormat = 'yyyy-MM-dd'}) {
    DateTime localToday = DateTime.now().toUtc().add(Duration(seconds: timezone));
    return DateFormat(dateFormat).format(localToday);
  }
}