import 'package:flutter/material.dart';
import 'package:wani_reminder/core/preferences_manager.dart';

class SettingsPage extends StatefulWidget {
  final PreferencesManager preferencesManager;

  const SettingsPage({Key? key, required this.preferencesManager})
      : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final tokenController = TextEditingController();

  @override
  void dispose() {
    tokenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Token'),
              controller: tokenController,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (tokenController.text.isNotEmpty) {
              widget.preferencesManager.saveToken(tokenController.text);
              Navigator.of(context).pop();
            }
          },
          label: Row(
            children: const [
              Icon(Icons.save),
              SizedBox(width: 8),
              Text('SAVE'),
            ],
          )),
    );
  }
}
