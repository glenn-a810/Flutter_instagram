import 'package:flutter/material.dart';
// import 'package:instagram/contents.dart';
import 'package:instagram/style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    theme: style.theme,
    home: MyApp(),
  ));
}

// var textColor = TextTheme();

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int tab = 0;
  var resData = [];

  getData() async {
    var result = await http
        .get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    var res = jsonDecode(result.body);
    setState(() {
      resData = res;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Instragram',
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_box_outlined),
            onPressed: () {
              print(resData);
            },
            iconSize: 30,
          ),
        ],
      ),
      body: [
        Home(
          resData: resData,
        ),
        Text('SHOP')
      ][tab],
      // body: [FutureBuilder(future: resData, builder: () { 데이터 한번 가져오는 경우에 사용 }), Text('SHOP')][tab],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (i) {
          setState(() {
            tab = i;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'SHOP',
          ),
        ],
      ),
      // BottomAppBar(
      //   child: SizedBox(
      //     height: 50,
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //       children: [
      //         Icon(
      //           Icons.home_outlined,
      //         ),
      //         Icon(
      //           Icons.shopping_bag_outlined,
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}

class Home extends StatelessWidget {
  Home({this.resData, Key? key}) : super(key: key);
  final resData;

  @override
  Widget build(BuildContext context) {
    if (resData.isNotEmpty) {
      return ListView.builder(
        itemCount: 3,
        itemBuilder: (context, i) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(resData[i]['image']),
              Text('좋아요 ' + resData[i]['likes'].toString()),
              Text(resData[i]['user']),
              Text(resData[i]['content']),
            ],
          );
        },
      );
    } else {
      return Text('Loding...');
    }
  }
}
