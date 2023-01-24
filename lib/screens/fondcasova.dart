import 'package:arna/arna.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rasporedi/screens/home.dart';
import 'package:arna/arna.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rasporedi/screens/profesori.dart';
import 'package:rasporedi/screens/raspored.dart';
import '../providers.dart';
import '/strings.dart';
import 'package:arna/arna.dart';
import '/strings.dart';
import '/providers.dart';
import '/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

String? newValue;
List fondpredmeti = [];
String fondcasova = '0';

void promjenifondcasova(String? selectedValue) {
  if (selectedValue is String) {
    print(selectedValue);
    fondcasova = selectedValue;
  }
}

class Fondcasova extends ConsumerWidget {
  const Fondcasova({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _imeController = TextEditingController();
    final TextEditingController _odjeljenjaController = TextEditingController();
    final CollectionReference fond =
        FirebaseFirestore.instance.collection(_imeController.toString());

    final CollectionReference _profesori =
        FirebaseFirestore.instance.collection('odjeljenja');
    final CollectionReference _predmeti =
        FirebaseFirestore.instance.collection('predmeti');

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
                        const SizedBox(
                          height: 10,
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
                                    )),
                                    subtitle: Center(
                                        child: DropdownButton(
                                      onChanged: (changedValue) {
                                        newValue = changedValue as String?;
                                      },
                                      value: 0,
                                      items: [
                                        DropdownMenuItem(
                                          child: Text("0"),
                                          value: newValue,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("1"),
                                          value: 1,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("2"),
                                          value: 2,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("3"),
                                          value: 3,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("4"),
                                          value: 4,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("5"),
                                          value: 5,
                                        ),
                                        DropdownMenuItem(
                                          child: Text("6"),
                                          value: 6,
                                        ),
                                      ],
                                    )),
                                  ),
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
                            await _profesori.doc(Ime);
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
                            imerazreda = Ime;

                            fondpredmeti.forEach((subject) async {
                              for (int i = 0; i < 5; i++) {
                                generiranirazredi.add(subject['predmet']);
                              }

                              final DocumentReference predmetfond =
                                  FirebaseFirestore.instance
                                      .collection(Ime)
                                      .doc(subject['predmet']);
                              await predmetfond.set({'fond': 0});
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
                        fondpredmeti.add(
                            {"predmet": documentSnapshot['Naziv Predmeta']});
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Home()), // this mymainpage is your page to refresh
                          (Route<dynamic> route) => true,
                        );
                        _createRazred();
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
