import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/services/services.dart';
import 'package:provider/provider.dart';
import 'package:radio_grouped_buttons/custom_buttons/custom_radio_buttons_group.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Statistics(),
    );
  }
}

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  List<String> buttonList = [
    "Houses Sold",
    "Chalets Rented",
    "Lands Sold",
    "Apartments Rented",
  ];
  Map<String, Map<String, int>> cityCount = {};
  int flag = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<Services>(context, listen: false).getCount();
    // cityCount = Provider.of<Services>(context).cityCounts;
  }

  @override
  Widget build(BuildContext context) {
    cityCount = Provider.of<Services>(context).cityCounts;
    return Scaffold(
      appBar: AppBar(
        title: Text("Statistics"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Explore these captivating statistics to guide you in choosing the perfect property for your dreams.",
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: 180,
                child: CustomRadioButton(
                  buttonWidth: MediaQuery.of(context).size.width * 0.4,
                  buttonHeight: MediaQuery.of(context).size.height * 0.06,
                  buttonLables: buttonList,
                  buttonValues: buttonList,
                  radioButtonValue: (value, index) {
                    print("Button value " + value.toString());
                    print("Integer value " + index.toString());
                    setState(() {
                      flag = index;
                    });
                  },
                  horizontal: true,
                  enableShape: true,
                  buttonSpace: 5,
                  buttonColor: Colors.white,
                  selectedColor: kPrimaryColor,
                ),
              ),
              _buildPieChart(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPieChart() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: SfCircularChart(
        series: <CircularSeries>[
          PieSeries<ChartData, String>(
            dataSource: _getChartData(),
            xValueMapper: (ChartData data, _) => data.category,
            yValueMapper: (ChartData data, _) => data.value,
            dataLabelMapper: (ChartData data, _) =>
                '${data.category} ${data.value}%',
            dataLabelSettings: DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    );
  }

  List<ChartData> _getChartData() {
    if (flag == 1) {
      List<ChartData> chartDataList = [];
      cityCount.forEach((propType, cityCounts) {
        if (propType == "1") {
          cityCounts.entries.forEach((entry) {
            chartDataList
                .add(ChartData(entry.key, int.parse(entry.value.toString())));
          });
        }
      });

      return chartDataList;
    } else if (flag == 2) {
      List<ChartData> chartDataList = [];
      cityCount.forEach((propType, cityCounts) {
        if (propType == "2") {
          cityCounts.entries.forEach((entry) {
            chartDataList
                .add(ChartData(entry.key, int.parse(entry.value.toString())));
          });
        }
      });

      return chartDataList;
    } else if (flag == 3) {
      List<ChartData> chartDataList = [];
      cityCount.forEach((propType, cityCounts) {
        if (propType == "3") {
          cityCounts.entries.forEach((entry) {
            chartDataList
                .add(ChartData(entry.key, int.parse(entry.value.toString())));
          });
        }
      });

      return chartDataList;
    } else {
      // Default data if flag is not 1, 2, or 3
      List<ChartData> chartDataList = [];
      cityCount.forEach((propType, cityCounts) {
        if (propType == "0") {
          cityCounts.entries.forEach((entry) {
            chartDataList
                .add(ChartData(entry.key, int.parse(entry.value.toString())));
          });
        }
      });

      return chartDataList;
    }
  }
}

class ChartData {
  ChartData(this.category, this.value);

  final String category;
  final int value;
}
