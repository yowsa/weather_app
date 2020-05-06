import 'package:intl/intl.dart';

class DateHelper {
  static String localFormatDate(int timezone, int timestamp,
      {String dateFormat = 'yyyy-MM-dd'}) {
    DateTime localDate = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000)
        .add(Duration(seconds: timezone));
    String formattedDate = DateFormat(dateFormat).format(localDate);
    return formattedDate;
  }

  static String getToday(int timezone) {
    DateTime localToday = DateTime.now().add(Duration(seconds: timezone));
    return DateFormat('yyyy-MM-dd').format(localToday);
  }
}