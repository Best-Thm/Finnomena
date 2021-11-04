import 'package:finnomena/json/get_fund_info.dart';
import 'package:flutter/material.dart';

class Fund extends StatefulWidget {
  final dynamic info;
  const Fund({Key? key, required this.info}) : super(key: key);

  @override
  _FundState createState() => _FundState();
}

class _FundState extends State<Fund> {
  // late Future<FundInfo> futureFundInfo = fetchFundInfo();
  List<bool> selections = [false, false, false, false, false, false, true];
  int filter = 1;
  int timeSelecter = 7;
  @override
  Widget build(BuildContext context) {
    List<Row> listFund = [];

    Container rangeSelect(List<bool> selection) {
      return Container(
        padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ToggleButtons(
                  constraints: BoxConstraints.expand(
                      width: MediaQuery.of(context).size.width / 10,
                      height: 30),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  children: const [
                    Text("1D"),
                    Text("2D"),
                    Text("3D"),
                    Text("4D"),
                    Text("5D"),
                    Text("6D"),
                    Text("7D"),
                  ],
                  isSelected: selection,
                  onPressed: (int index) {
                    setState(
                      () {
                        for (var i = 0; i < selection.length; i++) {
                          if (i == index) {
                            selection[i] = true;
                          } else {
                            selection[i] = false;
                          }
                        }
                        // for (var i = 1; i < selection.length + 1; i++) {
                        //   if (selection[i - 1]) {
                        //     timeSelecter = i;
                        //   }
                        // }
                        timeSelecter = getTimeSelect(selection);
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            rangeSelect(selections),
            const SizedBox(
              height: 10,
            ),
            const Text("Fund List : "),
            FutureBuilder<FundInfo>(
              future: widget.info,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<dynamic> listFundEachRange = [];
                  for (var i = snapshot.data!.data.length - 1; i >= 0; i--) {
                    filter = int.parse(snapshot.data!.data[i].navDate
                        .toString()
                        .split("-")[2]
                        .split(" ")[0]);
                    if (filter <= timeSelecter) {
                      listFundEachRange.add(snapshot.data!.data[i]);
                    }
                  }
                  for (var i = 0; i < listFundEachRange.length; i++) {
                      listFund.add(
                        Row(
                          children: [
                            SizedBox(
                              width: 0.4 * MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  Text(listFundEachRange[i].thailandFundCode),
                                  Text("Rank : " + (i+1).toString()),
                                ],
                              ),
                            ),
                            Flex(direction: Axis.horizontal),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Price : " +
                                    listFundEachRange[i].navReturn
                                        .toString()),
                                Text("Performane : " +
                                    listFundEachRange[i].nav.toString()),
                                Text("Updated date : " +
                                    listFundEachRange[i].navDate
                                        .toString()
                                        .split("T")[0]
                                        .substring(0, 10)),
                              ],
                            )
                          ],
                        ),
                      );
                  }
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 0.75 * MediaQuery.of(context).size.height,
                    child: ListView.separated(
                      padding: const EdgeInsets.all(8),
                      itemCount: listFund.length,
                      itemBuilder: (BuildContext context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [listFund[index]],
                        );
                      },
                      scrollDirection: Axis.vertical,
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          indent: 0,
                          thickness: 3,
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const CircularProgressIndicator();
              },
            )
          ],
        ),
      ),
    );
  }
}
//------------------------------------------------------------------------------

int getTimeSelect(List<bool> selection) {
  for (var i = 1; i < selection.length + 1; i++) {
    if (selection[i - 1]) {
      return i;
    }
  }
  return 1;
}
