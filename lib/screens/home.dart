import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rasporedi/screens/raspored.dart';

import '/providers.dart';
import 'package:rasporedi/screens/profesori.dart';
import '/screens/settings.dart';
import 'razredi.dart';
import 'ucionice.dart';
import 'predmeti.dart';
import '/strings.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    // final bool showSearch = ref.watch(searchProvider);

    final NavigationItem profesori = NavigationItem(
      title: Strings.hello,
      icon: Icons.person,
      selectedIcon: Icons.person,
      builder: (_) => const HelloWorld(),
    );

    final MasterNavigationItem profesorMaster = MasterNavigationItem(
      title: Strings.hello,
      leading: const Icon(Icons.person),
      builder: (_) => const HelloWorld(),
    );

    final NavigationItem predmeti = NavigationItem(
      title: Strings.widgets,
      icon: Icons.subject,
      selectedIcon: Icons.subject,
      // headerBarLeading: ArnaButton.icon(
      //   icon: Icons.search_outlined,
      //   onPressed: () => ref.read(searchProvider.notifier).state = !showSearch,
      //   tooltipMessage: Strings.search,
      // ),
      builder: (_) => const Predmeti(),
    );

    final MasterNavigationItem predmetiMaster = MasterNavigationItem(
      title: Strings.widgets,
      leading: const Icon(Icons.subject),
      // headerBarLeading: ArnaButton.icon(
      //   icon: Icons.search_outlined,
      //   onPressed: () => ref.read(searchProvider.notifier).state = !showSearch,
      //   tooltipMessage: Strings.search,
      // ),
      builder: (_) => const Predmeti(),
    );

    final NavigationItem ucionice = NavigationItem(
      title: Strings.typography,
      icon: Icons.meeting_room,
      selectedIcon: Icons.meeting_room,
      builder: (_) => const Typography(),
    );

    final MasterNavigationItem ucioniceMaster = MasterNavigationItem(
      title: Strings.typography,
      leading: const Icon(Icons.meeting_room),
      builder: (_) => const Typography(),
    );

    final NavigationItem odjeljenja = NavigationItem(
      title: "Razredi",
      icon: Icons.format_list_numbered,
      selectedIcon: Icons.format_list_numbered,
      builder: (_) => const Tabs(),
    );

    final MasterNavigationItem odjeljenjaMaster = MasterNavigationItem(
      title: "Razredi",
      leading: const Icon(Icons.format_list_numbered),
      builder: (_) => const Tabs(),
    );

    final NavigationItem rasporedi = NavigationItem(
      title: "Rasporedi",
      icon: Icons.calendar_month,
      selectedIcon: Icons.calendar_month,
      builder: (_) => Rasporedi(),
    );

    final MasterNavigationItem rasporediMaster = MasterNavigationItem(
      title: "Rasporedi",
      leading: const Icon(Icons.calendar_month),
      builder: (_) => Rasporedi(),
    );

    final List<ArnaHeaderBarItem> actions = <ArnaHeaderBarItem>[
      ArnaHeaderBarButton(
        icon: Icons.settings_outlined,
        label: Strings.settings,
        onPressed: () => showArnaPopupDialog(
          context: context,
          title: "Postavke",
          builder: (BuildContext context) => const Settings(),
        ),
      ),
    ];

    const Widget leadingWidget = ArnaLogo(size: Styles.base * 10);

    return ref.watch(masterProvider)
        ? ArnaMasterDetailScaffold(
            title: Strings.appName,
            actions: actions,
            leading: leadingWidget,
            items: <MasterNavigationItem>[
              profesorMaster,
              predmetiMaster,
              ucioniceMaster,
              odjeljenjaMaster,
              rasporediMaster,
            ],
          )
        : ArnaSideScaffold(
            title: Strings.appName,
            actions: actions,
            leading: leadingWidget,
            items: <NavigationItem>[
              profesori,
              predmeti,
              ucionice,
              odjeljenja,
              rasporedi
            ],
          );
  }
}
