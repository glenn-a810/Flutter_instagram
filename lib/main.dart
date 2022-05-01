import 'package:flutter/material.dart';
// import 'package:instagram/contents.dart';
import 'package:instagram/style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(MaterialApp(
    theme: style.theme,
    // initialRoute: '/',
    // routes: {
    //   '/': (c) => Text('HOME'),
    //   '/detail': (c) => Text('SHOP'),
    // },
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
  List resData = [];
  var userImage;
  var userContent;

  addUserData() {
    var userData = {
      'id': resData.length,
      'image': userImage,
      'like': 5,
      'date': 'July 25',
      'content': userContent,
      'liked': false,
      'user': '루이',
    };
    setState(() {
      resData.insert(0, userData);
    });
  }

  setUserContent(a) {
    userContent = a;
  }

  addData(more) {
    setState(() {
      resData.add(more);
    });
  }

  getData() async {
    var result = await http
        .get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    List res = jsonDecode(result.body);
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
          'Instagram',
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_box_outlined),
            onPressed: () async {
              var picker = ImagePicker();
              var image = await picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                setState(() {
                  userImage = File(image.path);
                });
              }

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Upload(
                            userImage: userImage,
                            setUserContent: setUserContent,
                            addUserData: addUserData,
                          )));
            },
            iconSize: 30,
          ),
        ],
      ),
      body: [
        Home(
          resData: resData,
          addData: addData,
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

class Upload extends StatelessWidget {
  const Upload(
      {Key? key, this.userImage, this.setUserContent, this.addUserData})
      : super(key: key);
  final userImage;
  final setUserContent;
  final addUserData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload'),
        actions: [
          IconButton(
            onPressed: () {
              addUserData();
            },
            icon: Icon(Icons.send),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.file(userImage),
          // Text('Upload'),
          TextField(
            onChanged: (text) {
              setUserContent(text);
            },
          ),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close)),
        ],
      ),
    );
  }
}

class Home extends StatefulWidget {
  Home({this.resData, this.addData, Key? key}) : super(key: key);
  final resData;
  final addData;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var scroll = ScrollController();

  getMore() async {
    var moreResult = await http
        .get(Uri.parse('https://codingapple1.github.io/app/more1.json'));
    var moreRes = jsonDecode(moreResult.body);
    widget.addData(moreRes);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scroll.addListener(() async {
      // print(scroll.position.pixels);
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        getMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.resData.isNotEmpty) {
      return ListView.builder(
        itemCount: widget.resData.length,
        controller: scroll,
        itemBuilder: (context, i) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.resData[i]['image'].runtimeType == String
                  ? Image.network(widget.resData[i]['image'])
                  : Image.file(widget.resData[i]['image']),
              // Image.network(widget.resData[i]['image']),
              Text('좋아요 ' + widget.resData[i]['likes'].toString()),
              Text(widget.resData[i]['user']),
              Text(widget.resData[i]['content']),
            ],
          );
        },
      );
    } else {
      return Text('Loding...');
    }
  }
}
