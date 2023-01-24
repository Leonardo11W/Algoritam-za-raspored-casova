import 'package:arna/arna.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rasporedi/screens/UreditePredmete.dart';
import 'package:rasporedi/screens/dodajtePredmetProfi.dart';
import 'package:rasporedi/screens/predmetimeni.dart';
import 'package:rasporedi/widgets/checkbox.dart';
import 'package:rasporedi/widgets/list_tile.dart';
import 'package:rasporedi/widgets/pickers.dart';
import '../providers.dart';
import '/strings.dart';
import 'package:arna/arna.dart';
import '/strings.dart';

class HelloWorld extends ConsumerWidget {
  const HelloWorld({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _imeController = TextEditingController();
    final CollectionReference _profesori =
        FirebaseFirestore.instance.collection('profesori');

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
                          style: TextStyle(
                              color: (ref.read(themeProvider.notifier).state ==
                                      Brightness.dark)
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 20),
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
                                    const DodajtePredmetProfi(),
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
                            await _profesori.doc(Ime);
                            FirebaseFirestore.instance
                                .collection('profesori')
                                .doc(Ime)
                                .set({
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

    Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
      if (documentSnapshot != null) {
        _imeController.text = documentSnapshot['Ime i Prezime'];
      }

      if (predmeti.isEmpty) {
        predmeti.add({'predmet': documentSnapshot?['predmet'].toString()});
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
                            children: predmeti.map((subject) {
                              return Container(
                                  child: Column(
                                children: [
                                  ListTile(
                                    title: Center(
                                        child: Text(
                                      subject['predmet'],
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
                          'Uredite Predmete',
                        ),
                        onPressed: () => showArnaPopupDialog(
                          context: context,
                          title: "Predmeti",
                          builder: (BuildContext context) =>
                              const UreditePredmete(),
                        ),
                      )),
                    ),
                    const SizedBox(
                      height: 10,
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
                          'Spremi',
                        ),
                        onPressed: () async {
                          final String Ime = _imeController.text;

                          if (Ime != null) {
                            await _profesori.doc(documentSnapshot!.id).update({
                              "Ime i Prezime": Ime,
                            });
                            _imeController.text = '';

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
      await _profesori.doc(productId).delete();

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Uspješno ste izbrisali profesora')));
    }

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
                        subtitle: Text(
                          documentSnapshot['predmet'].toString(),
                          style: ArnaTheme.of(context).textTheme.subtitle,
                        ),
                        title: Text(
                          documentSnapshot['Ime i Prezime'],
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
                                  onPressed: () =>
                                      _delete(documentSnapshot.id)),
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
                predmeti.clear();
                _create();
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
