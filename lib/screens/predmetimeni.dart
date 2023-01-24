import 'package:arna/arna.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rasporedi/screens/home.dart';
import 'package:arna/arna.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers.dart';
import '/strings.dart';
import 'package:arna/arna.dart';
import '/strings.dart';
import '/providers.dart';
import '/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Predmeti_Meni extends ConsumerWidget {
  const Predmeti_Meni({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _odjeljenjaController = TextEditingController();
    final CollectionReference _profesori =
        FirebaseFirestore.instance.collection('predmeti');

    return Stack(
      children: [
        StreamBuilder(
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
                          color: (ref.read(themeProvider.notifier).state ==
                                  Brightness.dark)
                              ? Colors.black
                              : Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      color: (ref.read(themeProvider.notifier).state ==
                              Brightness.dark)
                          ? Color.fromRGBO(45, 45, 48, 1)
                          : Colors.white,
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
            }),
      ],
    );
  }
}
