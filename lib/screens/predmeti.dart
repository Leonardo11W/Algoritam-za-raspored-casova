import 'package:arna/arna.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers.dart';
import '/strings.dart';
import 'package:arna/arna.dart';
import '/strings.dart';

class Predmeti extends ConsumerWidget {
  const Predmeti({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _predmetController = TextEditingController();
    final CollectionReference _profesori =
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
                      controller: _predmetController,
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
                          labelText: 'Naziv Predmeta',
                          labelStyle: TextStyle(
                              color: (ref.read(themeProvider.notifier).state ==
                                      Brightness.dark)
                                  ? Colors.white
                                  : Colors.black)),
                    ),
                    const SizedBox(
                      height: 20,
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
                          final String Ime = _predmetController.text;

                          if (Ime != null) {
                            await _profesori.doc(Ime);
                            FirebaseFirestore.instance
                                .collection('predmeti')
                                .doc(Ime)
                                .set({
                              "Naziv Predmeta": Ime,
                            });

                            _predmetController.text = '';

                            Navigator.of(context).pop();
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
        _predmetController.text = documentSnapshot['Naziv Predmeta'];
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
                      controller: _predmetController,
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
                          labelText: 'Naziv Predmeta',
                          labelStyle: TextStyle(
                              color: (ref.read(themeProvider.notifier).state ==
                                      Brightness.dark)
                                  ? Colors.white
                                  : Colors.black)),
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
                          'Uredi',
                        ),
                        onPressed: () async {
                          final String Ime = _predmetController.text;

                          if (Ime != null) {
                            await _profesori.doc(documentSnapshot!.id).update({
                              "Naziv Predmeta": Ime,
                            });
                            _predmetController.text = '';

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
          const SnackBar(content: Text('Uspješno ste izbrisali predmet')));
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
                        title: Text(
                          documentSnapshot['Naziv Predmeta'],
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
              onPressed: () => _create(),
              child: const Icon(Icons.add),
            ),
            alignment: Alignment.bottomRight,
          ),
        )
      ],
    );
  }
}
