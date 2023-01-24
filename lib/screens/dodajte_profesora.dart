import 'package:arna/arna.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rasporedi/screens/home.dart';
import 'package:arna/arna.dart';
import 'package:flutter/material.dart';
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

class Dodajte_Profesora extends ConsumerWidget {
  const Dodajte_Profesora({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _imeController = TextEditingController();
    final TextEditingController _odjeljenjaController = TextEditingController();
    final CollectionReference _profesori =
        FirebaseFirestore.instance.collection('predmeti');

    return SingleChildScrollView(
        child: Container(
      child: Column(
        children: <Widget>[
          TextField(
            style: TextStyle(
                color:
                    (ref.read(themeProvider.notifier).state == Brightness.dark)
                        ? Colors.white
                        : Colors.black),
            cursorColor: (ref.read(accentProvider.notifier).state ==
                    ArnaColors.blue)
                ? ArnaColors.blue
                : (ref.read(accentProvider.notifier).state == ArnaColors.green)
                    ? ArnaColors.green
                    : (ref.read(accentProvider.notifier).state ==
                            ArnaColors.red)
                        ? ArnaColors.red
                        : ArnaColors.orange,
            textAlign: TextAlign.center,
            controller: _imeController,
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: (ref.read(accentProvider.notifier).state ==
                                ArnaColors.blue)
                            ? ArnaColors.blue
                            : (ref.read(accentProvider.notifier).state ==
                                    ArnaColors.green)
                                ? ArnaColors.green
                                : (ref.read(accentProvider.notifier).state ==
                                        ArnaColors.red)
                                    ? ArnaColors.red
                                    : ArnaColors.orange)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: (ref.read(accentProvider.notifier).state ==
                                ArnaColors.blue)
                            ? ArnaColors.blue
                            : (ref.read(accentProvider.notifier).state ==
                                    ArnaColors.green)
                                ? ArnaColors.green
                                : (ref.read(accentProvider.notifier).state ==
                                        ArnaColors.red)
                                    ? ArnaColors.red
                                    : ArnaColors.orange)),
                labelText: 'Ime i Prezime Profesora',
                labelStyle: TextStyle(
                    color: (ref.read(themeProvider.notifier).state ==
                            Brightness.dark)
                        ? Colors.white
                        : Colors.black)),
          ),
        ],
      ),
    ));
  }
}
