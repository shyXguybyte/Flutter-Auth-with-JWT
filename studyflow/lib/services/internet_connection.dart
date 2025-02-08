import 'package:http/http.dart' as http;

Future<bool> isInternetConnected() async {
  try {
    final response = await http
        .get(Uri.parse('https://clients3.google.com/generate_204'))
        .timeout(const Duration(seconds: 10));

    return response.statusCode == 204; // No content means success
  } catch (e) {
    return false;
  }
}
