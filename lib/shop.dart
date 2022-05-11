import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = FirebaseFirestore.instance;

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  getData() async {
    try {
      // var res = await firestore.collection('product').get();
      // await firestore
      //     .collection('product')
      //     .add({'name': '허라취', 'price': 138000});
      // await firestore.collection('product').where(field).get();
      // await firestore.collection('product').doc().delete();
      await firestore
          .collection('product')
          .doc('5mGhsI4Qp79hi81GSVUe')
          .update({'price': 236000});
    } catch (e) {
      print(e);
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
