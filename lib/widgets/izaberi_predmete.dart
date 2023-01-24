import 'package:arna/arna.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rasporedi/screens/predmetimeni.dart';
import 'package:rasporedi/screens/razredmeni.dart';

import '../providers.dart';
import '../screens/settings.dart';
import '/strings.dart';

class Izaberi_Predmete extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String naslov = "Izaberite predmete";

    return InkWell(
      child: Container(
          child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: (ref.read(themeProvider.notifier).state == Brightness.dark)
                ? Colors.black
                : Colors.white,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: (ref.read(themeProvider.notifier).state == Brightness.dark)
            ? Color.fromRGBO(45, 45, 48, 1)
            : Colors.white,
        margin: const EdgeInsets.all(10),
        child: ListTile(
          title: Text(
            naslov,
            style: ArnaTheme.of(context).textTheme.headline,
          ),
          trailing: SizedBox(
            width: 100,
            child: Row(
              children: [],
            ),
          ),
        ),
      )),
      onTap: () => showArnaPopupDialog(
        context: context,
        title: "Predmeti",
        builder: (BuildContext context) => const Predmeti_Meni(),
      ),
    );
  }
}
