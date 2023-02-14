import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recordlist_sample/RecordList.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: FutureBuilder<RecordList>(
            future: _loadData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data != null) {
                  return Column(
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(color: Colors.black),
                        child: SizedBox(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Record List",
                                style: TextStyle(fontSize: 32, color: Colors.white),
                              ),
                            ),
                          ),
                          height: 50,
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data?.data.records.length,
                          itemBuilder: (context, index) {
                            return HomeCards(record: snapshot.data!.data.records[index]);
                          },
                        ),
                      ),
                    ],
                  );
                }
              }
              return const Center(child: CupertinoActivityIndicator(color: Colors.white,),);
            }),
      ),
    );
  }

  Future<RecordList> _loadData() async {
    final response = await http.get(
      Uri.parse('https://testffc.nimapinfotech.com/testdata.json'),
    );

    if (response.statusCode == 200) {
      return RecordList.fromRawJson(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }
}

class HomeCards extends StatefulWidget {
  const HomeCards({
    Key? key,
    required this.record,
  }) : super(key: key);

  final Record record;

  @override
  State<HomeCards> createState() => _HomeCardsState();
}

class _HomeCardsState extends State<HomeCards> {
  final DateFormat format = DateFormat("dd/MM/yyyy");

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.green),
        child: SizedBox.expand(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.brown),
                  child: FractionallySizedBox(
                    heightFactor: 0.6,
                    child: SizedBox.expand(
                      child: Image.network(
                        widget.record.mainImageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: FractionallySizedBox(
                  heightFactor: 0.4,
                  child: Material(
                  color: Colors.blue.shade300,
                    elevation: 0,
                    textStyle: TextStyle(
                      color: Colors.white,
                    ),
                    child: SizedBox.expand(
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: SizedBox.expand(),
                          ),
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("\u{20B9}${widget.record.collectedValue}"),
                                      Text("FUNDED"),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("\u{20B9}${widget.record.totalValue}"),
                                      Text("GOALS"),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("${format.parse(widget.record.endDate).difference(format.parse(widget.record.startDate)).inDays}"),
                                      Text("ENDS IN"),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: SizedBox(
                                        height: 35,
                                        child: Center(
                                          child: Text("PLEDGE",
                                          style: TextStyle(color: Colors.blue),),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(-0.8, 0.25),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: FractionallySizedBox(
                    heightFactor: 0.2,
                    widthFactor: 0.6,
                    child: SizedBox.expand(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      widget.record.title,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(widget.record.shortDescription),
                                  )),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.favorite,
                              color: Colors.redAccent,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0.8, 0.25),
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.blueGrey, shape: BoxShape.circle),
                  child: FractionallySizedBox(
                    heightFactor: 0.2,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: SizedBox.expand(
                        child: Center(
                          child: Text(
                            "${((widget.record.collectedValue / widget.record.totalValue) * 100) ~/1}%",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
