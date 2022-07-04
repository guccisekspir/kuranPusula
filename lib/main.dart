import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kuranpusula/data/favoritesApiClient.dart';
import 'package:kuranpusula/landPage.dart';
import 'package:kuranpusula/locator.dart';
import 'package:kuranpusula/model/beads.dart';
import 'package:kuranpusula/pages/beadsPage/beadsPage.dart';
import 'package:kuranpusula/pages/errorScreen/errorScreen.dart';
import 'package:kuranpusula/pages/fridayImagesPage/fridayImagePage.dart';
import 'package:kuranpusula/pages/qiblahPage/qiblahPage.dart';
import 'package:kuranpusula/pages/quranPage/quranPage.dart';
import 'package:kuranpusula/pages/requestPrayPage/requestPrayPage.dart';
import 'package:kuranpusula/pages/shareVersePage/shareVersePage.dart';

void main() async {
  runApp(MyApp());
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await MobileAds.instance.initialize();

  MobileAds.instance
      .updateRequestConfiguration(RequestConfiguration(testDeviceIds: ['84E809EDF0BEF25961F6196A69B56CF0']));

  Hive.registerAdapter(BeadsAdapter());

  await getIt<FavoritesApiClient>().getFavorites();
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  final GoRouter _router = GoRouter(
    errorBuilder: (context, state) => ErrorScreen(
      error: state.error,
    ),
    initialLocation: "/",
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LandPage(),
      ),
      GoRoute(
        path: '/beads',
        name: 'beads',
        builder: (context, state) => const BeadsPage(),
      ),
      GoRoute(
        path: '/quran',
        name: 'quran',
        builder: (context, state) => const QuranPage(),
      ),
      GoRoute(
        path: '/shareVerse',
        name: 'shareVerse',
        builder: (context, state) => const ShareVersePage(),
      ),
      GoRoute(
        path: '/fridayImage',
        name: 'fridayImage',
        builder: (context, state) => const FridayImagePage(),
      ),
      GoRoute(
        path: '/requestPray',
        name: 'requestPray',
        builder: (context, state) => const RequestPray(),
      ),
      GoRoute(
        path: '/qiblah',
        name: 'qiblah',
        builder: (context, state) => QiblahCompass(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      title: 'Kuran Pusula',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      builder: EasyLoading.init(),
    );
  }
}
