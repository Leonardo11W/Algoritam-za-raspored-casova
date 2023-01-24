import 'package:arna/arna.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/strings.dart';

class ListTiles extends ConsumerWidget {
  const ListTiles({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _odjeljenjaController = TextEditingController();
    final CollectionReference _profesori =
        FirebaseFirestore.instance.collection('predmeti');

    return ArnaExpansionPanel(
      leading: Icon(Icons.view_list_outlined),
      title: Strings.listTile,
      child: ArnaList(
        showBackground: true,
        showDividers: true,
        children: <Widget>[
          ArnaListTile(
            title: '${Strings.title} 1',
            trailing: ArnaBadge(label: '1'),
            showBackground: false,
          ),
          ArnaListTile(
            title: '${Strings.title} 2',
            subtitle: Strings.subtitle,
            trailing: ArnaBadge(label: '2'),
          ),
        ],
      ),
    );
  }
}
