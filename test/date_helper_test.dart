import 'package:flutter_test/flutter_test.dart';
import 'package:weatherapp/viewmodel/date_helper.dart';

void main() {
  test('Get formatted date in local time according to supplied format if applicable', () {
    String formattedDate1 = DateHelper.localFormatDate(3600, 1588843635);
    String formattedDate2 = DateHelper.localFormatDate(3600, 1588843635, dateFormat: 'E');
    String formattedDate3 = DateHelper.localFormatDate(3600, 1588843635, dateFormat: 'H:m EEEE, d MMM');

    expect(formattedDate1, '2020-05-07');
    expect(formattedDate2, 'Thu');
    expect(formattedDate3, '10:27 Thursday, 7 May');
  });
}