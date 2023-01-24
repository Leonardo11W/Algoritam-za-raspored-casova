import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rasporedi/pocetna.dart';
import 'firebase_options.dart';
import 'package:animated_login/animated_login.dart';
import 'dialog_builders.dart';
import 'login_functions.dart';

import 'package:async/async.dart';

final user = FirebaseAuth.instance.currentUser!;

abstract class Strings {
  static String appName = user.email!;

  static const String settings = 'Settings';
  static const String hello = 'Profesori';
  static const String add = 'Add';
  static const String search = 'Search';
  static const String widgets = 'Predmeti';
  static const String typography = 'Učionice';
  static const String tabs = 'Odjeljenja';
  static const String tab = 'Tab';
  static const String closedTab = 'Tab is closed.';
  static const String buttonPushed =
      'You have pushed the button this many times:';
  static const String theme = 'Tema';
  static const String system = 'Sistem';
  static const String dark = 'Taman';
  static const String light = 'Svjetli';
  static const String options = 'Postavke';
  static const String masterMode = 'Use Master-Detail';
  static const String accent = 'Accent';
  static const String lorem = 'Lorem ipsum dolor';
  static const String bannerTitle = 'This is a banner.';
  static const String buttons = 'Buttons';
  static const String first = 'First Item';
  static const String second = 'Second Item';
  static const String third = 'Third Item';
  static const String selected = 'Selected:';
  static const String linkedButtons = 'Linked Buttons';
  static const String segmentedControl = 'Segmented Control';
  static const String checkBox = 'CheckBox';
  static const String subtitle = 'Subtitle';
  static const String radio = 'Radio';
  static const String switchText = 'Switch';
  static const String listTile = 'List Tile';
  static const String title = 'Title';
  static const String slider = 'Slider';
  static const String indicator = 'Indicator';
  static const String textField = 'Text Field';
  static const String banners = 'Banner and SnackBar';
  static const String showBanner = 'Show Banner';
  static const String showSnackBar = 'Show SnackBar';
  static const String pickers = 'Pickers';
  static const String datePicker = 'Date Picker';
}
