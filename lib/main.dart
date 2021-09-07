import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wani_reminder/core/preferences_manager.dart';
import 'package:wani_reminder/pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final PreferencesManager preferencesManager =
      PreferencesManager(const FlutterSecureStorage());

  runApp(MyApp(preferencesManager: preferencesManager));
}

const colorPink = Color(0xfff100a1);
const colorBlue = Color(0xff0093dd);

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.preferencesManager}) : super(key: key);

  final PreferencesManager preferencesManager;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WaniKani Reminder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(
        preferencesManager: preferencesManager,
      ),
    );
  }
}
