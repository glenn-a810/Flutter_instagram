import 'package:flutter/material.dart';
// import 'package:instagram/contents.dart';
import 'package:instagram/style.dart' as style;

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
            onPressed: () {},
            iconSize: 30,
          ),
        ],
      ),
      body: [Home(), Text('SHOP')][tab],
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
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, i) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network('https://codingapple1.github.io/app/car0.png'),
            Text('좋아요 100'),
            Text('글쓴이'),
            Text('글내용'),
          ],
        );
      },
    );
  }
}
