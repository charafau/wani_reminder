import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:wani_reminder/core/constants.dart';
import 'package:wani_reminder/core/header_provider.dart';
import 'package:wani_reminder/core/preferences_manager.dart';
import 'package:wani_reminder/core/rest_client.dart';
import 'package:wani_reminder/main.dart';
import 'package:wani_reminder/pages/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.preferencesManager})
      : super(key: key);

  final PreferencesManager preferencesManager;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  int currentReviewCount = 0;
  int currentLessonCount = 0;

  int pendingNotifications = 0;

  @override
  void initState() {
    super.initState();
    _fetchSummary();
    _initNotificationPlugin();
    _checkPendingNotificationRequests();
  }

  Future<void> _checkPendingNotificationRequests() async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    setState(() {
      pendingNotifications = pendingNotificationRequests.length;
    });
  }

  Future<void> _cancelPendingNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    await _checkPendingNotificationRequests();
  }

  Future<void> _showNotification(int? reviewCount, int? lessonCount) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(notificationChannelId,
            notificationChannelName, notificationChannelDesc,
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false);
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      notificationId,
      'WaniKani Reviews',
      'Current Lessons: ${lessonCount ?? 0}, Reviews: ${reviewCount ?? 0}',
      platformChannelSpecifics,
    );
  }

  Future<void> _scheduleNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(notificationChannelId,
            notificationChannelName, notificationChannelDesc,
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false);
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    if (await widget.preferencesManager.hasToken()) {
      final rc = RestClient(HeaderProvider(widget.preferencesManager), Dio());

      final summary = await rc.summary();

      final lessons = summary?.lessonsCount() ?? 0;
      final reviews = summary?.reviewCount() ?? 0;

      await flutterLocalNotificationsPlugin.periodicallyShow(
        notificationId,
        'WaniKani Reviews',
        'Current Lessons: $lessons, Reviews: $reviews',
        RepeatInterval.hourly,
        platformChannelSpecifics,
      );
    }
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
    if (await widget.preferencesManager.hasToken()) {
      final rc = RestClient(HeaderProvider(widget.preferencesManager), Dio());

      final summary = await rc.summary();

      currentLessonCount = summary?.lessonsCount() ?? 0;
      currentReviewCount = summary?.reviewCount() ?? 0;

      setState(() {});
    } else {
      final snackBar = SnackBar(
        content: const Text('No token found, set token in settings.'),
        action: SnackBarAction(
          label: 'Go to settings',
          onPressed: () async {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            await _navigateToSettings(context);
            _fetchSummary();
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WaniKani Reminder'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () async {
                await _navigateToSettings(context);
                _fetchSummary();
              },
            ),
          ),
        ],
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: pendingNotifications == 0
                  ? const Text(
                      'Reminders are OFF',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const Text(
                      'Reminders are ON',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (pendingNotifications == 0) {
            await _fetchSummary();
            await _showNotification(currentReviewCount, currentLessonCount);
            await _scheduleNotification();
            _checkPendingNotificationRequests();
          } else {
            _cancelPendingNotifications();
          }
        },
        tooltip: 'Increment',
        label: pendingNotifications == 0
            ? const Text('Schedule reminders')
            : const Text('Cancel reminders'),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> _navigateToSettings(BuildContext context) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) =>
              SettingsPage(preferencesManager: widget.preferencesManager)));
}
