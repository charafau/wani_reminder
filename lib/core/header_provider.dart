import 'package:wani_reminder/constants.dart';

class HeaderProvider {
  Map<String, dynamic> get headers => {'Authorization': 'Bearer $apiKey'};
}
