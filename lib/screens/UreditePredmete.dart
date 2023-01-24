import 'package:arna/arna.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rasporedi/screens/home.dart';
import 'package:arna/arna.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rasporedi/screens/profesori.dart';
import '../providers.dart';
import '/strings.dart';
import 'package:arna/arna.dart';
import '/strings.dart';
import '/providers.dart';
import '/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

List predmeti = [];

class UreditePredmete extends ConsumerWidget {
  const UreditePredmete({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _imeController = TextEditingController();
    final TextEditingController _odjeljenjaController = TextEditingController();
    final CollectionReference _profesori =
        FirebaseFirestore.instance.collection('profesori');
    final CollectionReference _predmeti =
        FirebaseFirestore.instance.collection('predmeti');

    Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
      await showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext ctx) {
            return Container(
              color: (ref.read(themeProvider.notifier).state == Brightness.dark)
                  ? Color.fromRGBO(45, 45, 48, 1)
                  : Colors.white,
              child: Padding(
                padding: Styles.normal,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      style: TextStyle(
                          color: (ref.read(themeProvider.notifier).state ==
                                  Brightness.dark)
                              ? Colors.white
                              : Colors.black),
                      cursorColor: (ref.read(accentProvider.notifier).state ==
                              ArnaColors.blue)
                          ? ArnaColors.blue
                          : (ref.read(accentProvider.notifier).state ==
                                  ArnaColors.green)
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
                                  color: (ref
                                              .read(accentProvider.notifier)
                                              .state ==
                                          ArnaColors.blue)
                                      ? ArnaColors.blue
                                      : (ref
                                                  .read(accentProvider.notifier)
                                                  .state ==
                                              ArnaColors.green)
                                          ? ArnaColors.green
                                          : (ref
                                                      .read(accentProvider
                                                          .notifier)
                                                      .state ==
                                                  ArnaColors.red)
                                              ? ArnaColors.red
                                              : ArnaColors.orange)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: (ref
                                              .read(accentProvider.notifier)
                                              .state ==
                                          ArnaColors.blue)
                                      ? ArnaColors.blue
                                      : (ref
                                                  .read(accentProvider.notifier)
                                                  .state ==
                                              ArnaColors.green)
                                          ? ArnaColors.green
                                          : (ref
                                                      .read(accentProvider
                                                          .notifier)
                                                      .state ==
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
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Text(
                          "Lista predmeta:",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        ListView(
                            shrinkWrap: true,
                            children: predmeti.map((e) {
                              return Container(
                                  child: Column(
                                children: [
                                  ListTile(
                                    title: Center(
                                        child: Text(
                                      e['predmet'],
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    )),
                                  )
                                ],
                              ));
                            }).toList()),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        child: Center(
                      child: ElevatedButton(
                          child: Text(
                            'Dodajte Predmete',
                          ),
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(200, 50),
                              maximumSize: const Size(200, 50),
                              backgroundColor: (ref
                                          .read(accentProvider.notifier)
                                          .state ==
                                      ArnaColors.blue)
                                  ? ArnaColors.blue
                                  : (ref.read(accentProvider.notifier).state ==
                                          ArnaColors.green)
                                      ? ArnaColors.green
                                      : (ref
                                                  .read(accentProvider.notifier)
                                                  .state ==
                                              ArnaColors.red)
                                          ? ArnaColors.red
                                          : ArnaColors.orange),
                          onPressed: () => showArnaPopupDialog(
                                context: context,
                                title: "Predmeti",
                                builder: (BuildContext context) =>
                                    const UreditePredmete(),
                              )),
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        child: Center(
                      child: ElevatedButton(
                        child: Text(
                          'Napravi',
                        ),
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(200, 50),
                            maximumSize: const Size(200, 50),
                            backgroundColor: (ref
                                        .read(accentProvider.notifier)
                                        .state ==
                                    ArnaColors.blue)
                                ? ArnaColors.blue
                                : (ref.read(accentProvider.notifier).state ==
                                        ArnaColors.green)
                                    ? ArnaColors.green
                                    : (ref
                                                .read(accentProvider.notifier)
                                                .state ==
                                            ArnaColors.red)
                                        ? ArnaColors.red
                                        : ArnaColors.orange),
                        onPressed: () async {
                          final String Ime = _imeController.text;

                          print(predmeti.map((e) {
                            return e['predmet'];
                          }));

                          if (Ime != null) {
                            await _profesori.add({
                              "Ime i Prezime": Ime,
                              "predmet": predmeti.map((e) {
                                return e['predmet'];
                              })
                            });

                            _imeController.text = '';

                            Navigator.of(context).pop();
                            predmeti.clear();
                          }
                        },
                      ),
                    )),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            );
          });
    }

    return StreamBuilder(
        stream: _predmeti.snapshots(),
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
                    child: InkWell(
                      onTap: () {
                        predmeti.add(
                            {"predmet": documentSnapshot['Naziv Predmeta']});
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Home()), // this mymainpage is your page to refresh
                          (Route<dynamic> route) => true,
                        );
                        _create();
                      },
                      child: ListTile(
                        title: Center(
                          child: Text(
                            documentSnapshot['Naziv Predmeta'],
                            style: ArnaTheme.of(context).textTheme.headline,
                          ),
                        ),
                      ),
                    ));
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
