import 'package:wani_reminder/core/preferences_manager.dart';

class HeaderProvider {
  final PreferencesManager preferencesManager;

  HeaderProvider(this.preferencesManager);

  Future<Map<String, dynamic>?> get headers async {
    final token = await preferencesManager.loadToken();
    return {'Authorization': 'Bearer $token'};
  }
}
