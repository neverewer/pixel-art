import 'dart:convert';

sealed class JsonUtils {
  static String formatJsonString(String jsonString) {
    final jsonObject = json.decode(jsonString);
    final formattedString = const JsonEncoder.withIndent('   ').convert(jsonObject);
    return formattedString;
  }

  static String formatJson(Map<String, dynamic> map) {
    final jsonString = jsonEncode(map);
    final formattedString = const JsonEncoder.withIndent('  ').convert(jsonDecode(jsonString));
    return formattedString;
  }
}
