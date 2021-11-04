import 'package:flutter/material.dart';
import 'package:finnomena/widget/fund_info.dart';
import 'package:finnomena/json/get_fund_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<FundInfo> futureFundInfo = fetchFundInfo();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Finnomena"),
      ),
      body: Fund(
        info: futureFundInfo,
      ),
    );
  }
}
