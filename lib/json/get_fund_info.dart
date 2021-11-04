import 'dart:convert';
import 'package:http/http.dart' as http;

FundInfo fundInfoFromJson(String str) => FundInfo.fromJson(json.decode(str));

String fundInfoToJson(FundInfo data) => json.encode(data.toJson());

class FundInfo {
  FundInfo({
    required this.status,
    required this.error,
    required this.data,
  });

  bool status;
  String error;
  List<Datum> data;

  factory FundInfo.fromJson(Map<String, dynamic> json) => FundInfo(
        status: json["status"],
        error: json["error"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "error": error,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.mstarId,
    required this.thailandFundCode,
    required this.navReturn,
    required this.nav,
    required this.navDate,
    required this.avgReturn,
  });

  String mstarId;
  String thailandFundCode;
  double navReturn;
  double nav;
  DateTime navDate;
  double avgReturn;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        mstarId: json["mstar_id"],
        thailandFundCode: json["thailand_fund_code"],
        navReturn: json["nav_return"].toDouble(),
        nav: json["nav"].toDouble(),
        navDate: DateTime.parse(json["nav_date"]),
        avgReturn: json["avg_return"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "mstar_id": mstarId,
        "thailand_fund_code": thailandFundCode,
        "nav_return": navReturn,
        "nav": nav,
        "nav_date": navDate.toIso8601String(),
        "avg_return": avgReturn,
      };
}

Future<FundInfo> fetchFundInfo() async {
  final response = await http.get(Uri.parse(
      'https://storage.googleapis.com/finno-ex-re-v2-static-staging/recruitment-test/fund-ranking-1Y.json'));

  if (response.statusCode == 200) {
    return fundInfoFromJson(response.body);
  } else {
    throw Exception('Failed to load album');
  }
}