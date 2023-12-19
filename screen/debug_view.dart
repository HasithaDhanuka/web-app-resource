import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/food.dart';

class DebugView extends StatefulWidget {
  const DebugView({super.key});

  @override
  State<DebugView> createState() => _DebugViewState();
}

class _DebugViewState extends State<DebugView> {
  Stream<List<FoodItem>> DebugReadFoodItems() {
    final firestore = FirebaseFirestore.instance;
    final stream = firestore.collection("foods").snapshots();

    return stream.map((snapshot) =>
        snapshot.docs.map((doc) => FoodItem.fromMap(doc.data())).toList());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<FoodItem>>(
        stream: DebugReadFoodItems(), //DebugReadFoodItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("debug view waiting...");
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final debugItems = snapshot.data!;
          print(debugItems.length);

          print(snapshot.data!);
          if (snapshot.hasData) {
            print("read this snapsthot");
            return ListView(
              children: [
                Text("has data "),
                Text("has data01 "),
              ],
            );
          } else {
            return Center(child: Text("NO data yet"));
          }
        });
  }
}
