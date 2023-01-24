import 'dart:math';

import 'package:arna/arna.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rasporedi/screens/fondcasova.dart';
import 'package:rasporedi/screens/raspored.dart';
import '../providers.dart';
import '/strings.dart';
import 'package:arna/arna.dart';
import '/strings.dart';

class Tabs extends ConsumerWidget {
  const Tabs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _odjeljenjaController = TextEditingController();
    final CollectionReference _odjeljenja =
        FirebaseFirestore.instance.collection('odjeljenja');
    final CollectionReference fond =
        FirebaseFirestore.instance.collection(_odjeljenjaController.toString());
    Future<void> _createRazred([DocumentSnapshot? documentSnapshot]) async {
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
                      controller: _odjeljenjaController,
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
                          labelText: 'Naziv Razreda',
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
                          "Lista predmeta i fond časova:",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        ListView(
                            shrinkWrap: true,
                            children: fondpredmeti.map((e) {
                              return Container(
                                  child: Column(
                                children: [
                                  ListTile(
                                      title: Center(
                                    child: Text(
                                      e['predmet'],
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    ),
                                  )),
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
                            'Dodajte Predmet',
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
                                    const Fondcasova(),
                              )),
                    )),
                    SizedBox(
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
                          final String Ime = _odjeljenjaController.text;

                          if (Ime != null) {
                            await _odjeljenja.doc(Ime);
                            FirebaseFirestore.instance
                                .collection('odjeljenja')
                                .doc(Ime)
                                .set({
                              "Naziv Odjeljenja": Ime,
                              "predmet": fondpredmeti.map(
                                (e) {
                                  return e['predmet'];
                                },
                              )
                            });

                            generiranirazredi.add(Ime);

                            fondpredmeti.forEach((subject) async {
                              generiranirazredi.add(subject['predmet']);

                              final DocumentReference predmetfond =
                                  FirebaseFirestore.instance
                                      .collection(Ime)
                                      .doc(subject['predmet']);
                              await predmetfond.set({'fond': 1});
                            });

                            _odjeljenjaController.text = '';

                            Navigator.of(context).pop();
                          }
                          fondpredmeti.clear();
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

    Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
      if (documentSnapshot != null) {
        _odjeljenjaController.text = documentSnapshot['Naziv Odjeljenja'];
      }

      if (fondpredmeti.isEmpty) {
        fondpredmeti.add({'predmet': documentSnapshot?['predmet'].toString()});
      }

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
                      controller: _odjeljenjaController,
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
                          labelText: 'Naziv Razreda',
                          labelStyle: TextStyle(
                              color: (ref.read(themeProvider.notifier).state ==
                                      Brightness.dark)
                                  ? Colors.white
                                  : Colors.black)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        "Lista predmeta i fond časova:",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView(
                        shrinkWrap: true,
                        children: fondpredmeti.map((e) {
                          final String Ime = _odjeljenjaController.text;
                          final DocumentReference predmetfond =
                              FirebaseFirestore.instance
                                  .collection(Ime)
                                  .doc(e['predmet']);
                          predmetfond.set({'fond': 7});
                          return Container(
                              child: Column(
                            children: [
                              ListTile(
                                  title: Center(
                                child: Text(
                                  e['predmet'] + 'fond: ' + Ime,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              )),
                            ],
                          ));
                        }).toList()),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Center(
                          child: ElevatedButton(
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
                        child: Text(
                          'Uredi',
                        ),
                        onPressed: () async {
                          final String Ime = _odjeljenjaController.text;

                          if (Ime != null) {
                            await _odjeljenja.doc(documentSnapshot!.id).update({
                              "Naziv Odjeljenja": Ime,
                            });
                            _odjeljenjaController.text = '';

                            Navigator.of(context).pop();
                          }
                        },
                      )),
                    )
                  ],
                ),
              ),
            );
          });
    }

    Future<void> _delete(String productId) async {
      final String Ime = _odjeljenjaController.text;
      await _odjeljenja.doc(productId).delete();
      final DocumentReference _obrisi =
          FirebaseFirestore.instance.collection(productId).doc("hehe");

      print(_obrisi);

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Uspješno ste izbrisali razred')));
    }

    return Stack(
      children: [
        StreamBuilder(
            stream: _odjeljenja.snapshots(),
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
                        subtitle: Text(
                          documentSnapshot['predmet'].toString(),
                          style: ArnaTheme.of(context).textTheme.subtitle,
                        ),
                        title: Text(
                          documentSnapshot['Naziv Odjeljenja'],
                          style: ArnaTheme.of(context).textTheme.headline,
                        ),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                  color:
                                      (ref.read(themeProvider.notifier).state ==
                                              Brightness.dark)
                                          ? Colors.white
                                          : Colors.grey,
                                  icon: const Icon(Icons.edit),
                                  onPressed: () => _update(documentSnapshot)),
                              IconButton(
                                  color:
                                      (ref.read(themeProvider.notifier).state ==
                                              Brightness.dark)
                                          ? Colors.white
                                          : Colors.grey,
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    _delete(documentSnapshot.id);
                                  }),
                            ],
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
        Padding(
          padding: EdgeInsets.only(right: 20.0, bottom: 20.0),
          child: Container(
            child: FloatingActionButton(
              backgroundColor:
                  (ref.read(accentProvider.notifier).state == ArnaColors.blue)
                      ? ArnaColors.blue
                      : (ref.read(accentProvider.notifier).state ==
                              ArnaColors.green)
                          ? ArnaColors.green
                          : (ref.read(accentProvider.notifier).state ==
                                  ArnaColors.red)
                              ? ArnaColors.red
                              : ArnaColors.orange,
              onPressed: () {
                fondpredmeti.clear();
                _createRazred();
              },
              child: const Icon(Icons.add),
            ),
            alignment: Alignment.bottomRight,
          ),
        )
      ],
    );
  }
}
