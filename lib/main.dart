import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/notification.dart';
import 'package:instagram/shop.dart';
import 'package:instagram/style.dart' as style;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (c) => storeData()),
      ChangeNotifierProvider(create: (c) => anotherData()),
    ],
    // create: (c) => storeData(),
    child: MaterialApp(
      theme: style.theme,
      home: MyApp(),
    ),
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

  saveData() async {
    var storage = await SharedPreferences.getInstance();
    storage.setString('name', 'Odd');
  }

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
    initNotification(context);
    saveData();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text('!'),
        onPressed: () {
          // showNotification();
          showNotification2();
        },
      ),
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
        Shop()
      ][tab],
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
              GestureDetector(
                child: Text(widget.resData[i]['user']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => Profile()),
                  );
                },
              ),
              Text('좋아요 ' + widget.resData[i]['likes'].toString()),
              Text(widget.resData[i]['date']),
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

// another Store
class anotherData extends ChangeNotifier {
  var name = 'John Kim';
}

// Store
class storeData extends ChangeNotifier {
  // var name = 'John Kim';
  var follower = 0;
  var followState = true;
  var profileImage = [];

  getData() async {
    var res = await http
        .get(Uri.parse('https://codingapple1.github.io/app/profile.json'));
    var resData = jsonDecode(res.body);
    profileImage = resData;
    notifyListeners();
  }

  changeFollower() {
    if (followState == true) {
      follower++;
      followState = false;
    } else {
      follower--;
      followState = true;
    }
    notifyListeners();
  }

  changeName() {
    // name = 'John Park';
    notifyListeners();
  }
}

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(context.watch<anotherData>().name),
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ProfileHeader(),
            ),
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                  (c, i) => Container(
                        child: Image.network(
                            context.watch<storeData>().profileImage[i]),
                      ),
                  childCount: context.watch<storeData>().profileImage.length),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            )
          ],
        )
        // 강의 해답
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //   children: [
        //     CircleAvatar(
        //       radius: 30,
        //       backgroundColor: Colors.grey,
        //     ),
        //     Text('팔로워 ${context.watch<storeData>().follower}명'),
        //     ElevatedButton(
        //       onPressed: () {
        //         context.read<storeData>().changeFollower();
        //       },
        //       child: Text('팔로우'),
        //     ),
        //     ElevatedButton(
        //       onPressed: () {
        //         context.read<storeData>().getData();
        //       },
        //       child: Text('사진 가져오기'),
        //     ),
        //   ],
        // ),

        // 내가 한 숙제
        // ListTile(
        //   leading: Icon(Icons.account_circle_outlined),
        //   title: Text(
        //       '팔로워 ' + context.watch<storeData>().follower.toString() + ' 명'),
        //   trailing: ElevatedButton(
        //     onPressed: () {
        //       context.read<storeData>().changeFollower();
        //     },
        //     child: Text('팔로잉'),
        //   ),
        // ),

        // 강의 내용
        // Column(
        //   children: [
        //     ElevatedButton(
        //         onPressed: () {
        //           context.read<storeData>().changeName();
        //         },
        //         child: Text('Name Change'))
        //   ],
        // ),
        );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // 강의 해답
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey,
        ),
        Text('팔로워 ${context.watch<storeData>().follower}명'),
        ElevatedButton(
          onPressed: () {
            context.read<storeData>().changeFollower();
          },
          child: Text('팔로우'),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<storeData>().getData();
          },
          child: Text('사진 가져오기'),
        ),
      ],
    );
  }
}
