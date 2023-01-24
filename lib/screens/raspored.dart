import 'package:arna/arna.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rasporedi/widgets/buttons.dart';
import 'package:rasporedi/widgets/izaberi_predmete.dart';
import 'package:rasporedi/widgets/izaberi_razred.dart';
import '../providers.dart';
import '/strings.dart';
import 'package:arna/arna.dart';
import '/strings.dart';

bool nesto = false;
List generiranirazredi = [];

String imerazreda = '';

class Rasporedi extends ConsumerWidget {
  const Rasporedi({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _imeController = TextEditingController();
    final CollectionReference _profesori =
        FirebaseFirestore.instance.collection('profesori');
    final CollectionReference _odjeljenja =
        FirebaseFirestore.instance.collection('odjeljenja');
    Future<void> getData() async {
      // Get docs from collection reference
      QuerySnapshot querySnapshot = await _odjeljenja.get();

      // Get data from docs and convert map to List
      final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

      print(generiranirazredi);
      print(imerazreda);
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
                    generiranirazredi.shuffle();
                    for (int i = 0; i < 35; i++) {
                      final DocumentReference predmetfond = FirebaseFirestore
                          .instance
                          .collection(imerazreda + ' Raspored')
                          .doc(generiranirazredi[i] + [i].toString());
                      predmetfond.set({'fond': 5});
                    }
                    final _fireStore = FirebaseFirestore.instance;
                    Future<void> allData() async {
                      QuerySnapshot querySnapshot = await _fireStore
                          .collection(imerazreda + ' Raspored')
                          .get();
                      ;
                      final allData =
                          querySnapshot.docs.map((doc) => doc.data()).toList();
                      nesto = true;
                    }

                    return Column(
                      children: [
                        Center(
                          child: ArnaButton(
                            label: imerazreda,
                            onPressed: () {
                              getData();
                              allData();
                            },
                          ),
                        ),
                        Container(
                            child: DataTable(columns: [
                          DataColumn(label: Text('Čas')),
                          DataColumn(label: Text('Ponedjeljak')),
                          DataColumn(label: Text('Utorak')),
                          DataColumn(label: Text('Srijeda')),
                          DataColumn(label: Text('Četvrtak')),
                          DataColumn(label: Text('Petak')),
                          DataColumn(label: Text('Vrijeme')),
                        ], rows: [
                          DataRow(cells: [
                            DataCell(Text('1.')),
                            DataCell(Text(generiranirazredi[0])),
                            DataCell(Text(generiranirazredi[1])),
                            DataCell(Text(generiranirazredi[2])),
                            DataCell(Text(generiranirazredi[3])),
                            DataCell(Text(generiranirazredi[4])),
                            DataCell(Text('7:20 - 7:55'))
                          ]),
                          DataRow(cells: [
                            DataCell(Text('2.')),
                            DataCell(Text(generiranirazredi[5])),
                            DataCell(Text(generiranirazredi[6])),
                            DataCell(Text(generiranirazredi[7])),
                            DataCell(Text(generiranirazredi[8])),
                            DataCell(Text(generiranirazredi[9])),
                            DataCell(Text('8:00 - 8:45'))
                          ]),
                          DataRow(cells: [
                            DataCell(Text('3.')),
                            DataCell(Text(generiranirazredi[10])),
                            DataCell(Text(generiranirazredi[11])),
                            DataCell(Text(generiranirazredi[12])),
                            DataCell(Text(generiranirazredi[13])),
                            DataCell(Text(generiranirazredi[14])),
                            DataCell(Text('8:50 - 9:30'))
                          ]),
                          DataRow(cells: [
                            DataCell(Text('4.')),
                            DataCell(Text(generiranirazredi[15])),
                            DataCell(Text(generiranirazredi[16])),
                            DataCell(Text(generiranirazredi[17])),
                            DataCell(Text(generiranirazredi[18])),
                            DataCell(Text(generiranirazredi[19])),
                            DataCell(Text('9:50 - 10:35'))
                          ]),
                          DataRow(cells: [
                            DataCell(Text('6.')),
                            DataCell(Text(generiranirazredi[20])),
                            DataCell(Text(generiranirazredi[21])),
                            DataCell(Text(generiranirazredi[22])),
                            DataCell(Text(generiranirazredi[23])),
                            DataCell(Text(generiranirazredi[24])),
                            DataCell(Text('10:40 - 11:25'))
                          ]),
                          DataRow(cells: [
                            DataCell(Text('6.')),
                            DataCell(Text(generiranirazredi[25])),
                            DataCell(Text(generiranirazredi[26])),
                            DataCell(Text(generiranirazredi[27])),
                            DataCell(Text(generiranirazredi[28])),
                            DataCell(Text(generiranirazredi[29])),
                            DataCell(Text('11:30 - 12:15'))
                          ]),
                          DataRow(cells: [
                            DataCell(Text('7.')),
                            DataCell(Text(generiranirazredi[30])),
                            DataCell(Text(generiranirazredi[31])),
                            DataCell(Text(generiranirazredi[32])),
                            DataCell(Text(generiranirazredi[33])),
                            DataCell(Text(generiranirazredi[34])),
                            DataCell(Text('12:20 - 13:00'))
                          ]),
                        ]))
                      ],
                    );
                  },
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

List random = [
  0,
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24,
  25,
  26,
  27,
  28,
  29,
  30,
  31,
  32,
  33,
  34
];
