import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:wani_reminder/core/header_provider.dart';
import 'package:wani_reminder/core/rest_client.dart';

void main() {
  runApp(const MyApp());
}

const colorPink = Color(0xfff100a1);
const colorBlue = Color(0xff0093dd);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  int currentReviewCount = 0;
  int currentLessonCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchSummary();
    _initNotificationPlugin();
  }

  void _showNotification(int? reviewCount, int? lessonCount) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'your channel id', 'your channel name', 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false);
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'WaniKani Reviews',
      'Current Lessons: ${lessonCount ?? 0}, Reviews: ${reviewCount ?? 0}',
      platformChannelSpecifics,
    );
  }

  void _initNotificationPlugin() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('wk');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (payload) async {},
    );
  }

  Future<void> _fetchSummary() async {
    final rc = RestClient(HeaderProvider(), Dio());

    final summary = await rc.summary();
    // print('summary $summary');
    // final user = await rc.user();
    // print('summary $user');

    currentLessonCount = summary?.lessonsCount() ?? 0;
    currentReviewCount = summary?.reviewCount() ?? 0;

    print('got reviews $currentReviewCount and lessons $currentLessonCount');
    setState(() {});

    // _showNotification(summary?.reviewCount(), summary?.lessonsCount());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WaniKani Reminder'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 36),
            Container(
              decoration: BoxDecoration(
                color: colorPink,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Current Lessons: $currentLessonCount',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: colorBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Current Reviews: $currentReviewCount',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await _fetchSummary();
          _showNotification(currentReviewCount, currentLessonCount);
        },
        tooltip: 'Increment',
        label: const Text('Schedule alerts'),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
