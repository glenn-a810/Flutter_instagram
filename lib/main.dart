import 'package:flutter/material.dart';
import 'package:instagram/style.dart' as style;

void main() {
  runApp(
      MaterialApp(
        theme: style.theme,
        home: MyApp(),
      )
  );
}

// var textColor = TextTheme();

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  List<int> like = [100,200,300];
  List<String> userName = ['루이','오드','하루'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instragram',),
        actions: [
          IconButton(
            icon: Icon(Icons.add_box_outlined),
            onPressed: () {},
            iconSize: 30,
          ),
        ],
      ),
      body: Text('Test', style: Theme.of(context).textTheme.bodyText2,),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.home_outlined,),
              Icon(Icons.shopping_bag_outlined,),
            ],
          ),
        ),
      ),
    );
  }
}


