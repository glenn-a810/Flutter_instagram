import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final firestore = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  getData() async {
    try {
      await firestore.collection('product').get();
      // await firestore
      //     .collection('product')
      //     .add({'name': '허라취', 'price': 138000});
      // await firestore.collection('product').where(field).get();
      // await firestore.collection('product').doc().delete();
      // await firestore
      //     .collection('product')
      //     .doc('5mGhsI4Qp79hi81GSVUe')
      //     .update({'price': 236000});

      // user 등록
      // var res = await auth.createUserWithEmailAndPassword(
      //     email: 'test@test.com', password: 'test1234');
      // res.user?.updateDisplayName('루이'); // ?.은 없으면 null, 있으면 사용하는 삼항연산자 축약어, !.은 null check 무시

      // user 로그인
      // await auth.signInWithEmailAndPassword(
      //     email: 'test@test.com', password: 'test1234');

      // user 로그아웃
      // await auth.signOut();
    } catch (e) {
      print(e);
    }

    // 로그인 상태 확인
    if (auth.currentUser?.uid == null) {
      print('Not logged in');
    } else {
      print('Logged in');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('SHOP Page'),
    );
  }
}
