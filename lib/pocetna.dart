import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:animated_login/animated_login.dart';
import 'dialog_builders.dart';
import 'login_functions.dart';
import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers.dart';
import '/screens/home.dart';
import 'package:async/async.dart';

void main() => runApp(const ProviderScope(child: Pocetna()));

class Pocetna extends ConsumerWidget {
  const Pocetna({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ArnaApp(
      debugShowCheckedModeBanner: false,
      theme: ArnaThemeData(
        accentColor: ref.watch(accentProvider),
        brightness: ref.watch(themeProvider),
      ),
      home: const Home(),
    );
  }
}
