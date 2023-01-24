import 'package:arna/arna.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../providers.dart';
import '/strings.dart';

class CheckBoxs extends StatefulWidget {
  const CheckBoxs({super.key});

  @override
  State<CheckBoxs> createState() => _CheckBoxsState();
}

class _CheckBoxsState extends State<CheckBoxs> {
  bool? _checkBox1 = false;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _odjeljenjaController = TextEditingController();
    final CollectionReference _profesori =
        FirebaseFirestore.instance.collection('predmeti');
    return StreamBuilder(
        stream: _profesori.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  color: Colors.white,
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Center(
                      child: Text(
                        documentSnapshot['Naziv Predmeta'],
                        style: ArnaTheme.of(context).textTheme.headline,
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
