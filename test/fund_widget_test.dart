import 'package:flutter_test/flutter_test.dart';
import 'package:finnomena/widget/fund_info.dart';
import 'package:http/http.dart' as http;

main() {
  test("Time Select test", () {
    //Arrange
    var testTimeSelect1 = [true, false, false, false, false, false, false];
    var testTimeSelect2 = [false, true, false, false, false, false, false];
    var testTimeSelect6 = [false, false, false, false, false, true, false];
    var testTimeSelect7 = [false, false, false, false, false, false, true];
    //Act
    //Assert
    expect(getTimeSelect(testTimeSelect1), 1);
    expect(getTimeSelect(testTimeSelect2), 2);
    expect(getTimeSelect(testTimeSelect6), 6);
    expect(getTimeSelect(testTimeSelect7), 7);
  });
  test("JSON request test", () async {
    final result = await http.get(Uri.parse(
        'https://storage.googleapis.com/finno-ex-re-v2-static-staging/recruitment-test/fund-ranking-1Y.json'));
    expect(result.statusCode, 200);
  });
}
