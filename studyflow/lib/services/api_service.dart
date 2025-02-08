import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:studyflow/services/internet_connection.dart';
import 'package:studyflow/services/requestState.dart';
import 'endpoints.dart';

class ApiService {
  final storage = const FlutterSecureStorage();

  /// Retrieve JWT token
  Future<String?> getToken() async {
    return await storage.read(key: "jwt_token");
  }

  /// Save JWT token securely
  Future<void> saveToken(String token) async {
    await storage.write(key: "jwt_token", value: token);
  }

  /// Delete JWT token (for logout)
  Future<void> logout() async {
    // await http.post(Uri.parse(ApiEndpoints.logout));
    await storage.delete(key: "jwt_token");
    print("Token deleted successfully"); // Debugging if token is deleted
    String? token = await getToken();
    print(
        "this is the latest debug the shows that the token is deleted $token");
  }

  /// Get default headers (with JWT if available)
  Future<Map<String, String>> getHeaders() async {
    String? token = await getToken();
    print("token value from the getHeaders function $token"); //debugging
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  /// Signup function with improved error handling
  Future<RequestState> signup(
      String username, String email, String password) async {
    if (await isInternetConnected()) {
      try {
        final response = await http.post(
          Uri.parse(ApiEndpoints.signupURL),
          headers: await getHeaders(),
          body: jsonEncode(
              {"username": username, "email": email, "password": password}),
        );

        switch (response.statusCode) {
          case 200:
            return RequestState.ok; // Signup successful
          case 400:
            return RequestState.badRequest; // Invalid input data
          case 401:
            return RequestState.unauthorized; // Unauthorized access
          case 409:
            return RequestState.emailAlreadyExist; // Email already exists
          case 500:
            return RequestState.serverFailure; // Internal server error
          default:
            return RequestState.unexpectedError; // Any unhandled errors
        }
      } catch (e) {
        return RequestState
            .unexpectedError; // Catches any JSON or request failure issues
      }
    } else {
      return RequestState.internetFailure; // No internet connection
    }
  }

  /// Login function with improved error handling
  Future<RequestState> login(String email, String password) async {
    if (!await isInternetConnected()) {
      return RequestState.internetFailure;
    }

    try {
      final response = await http.post(
        Uri.parse(ApiEndpoints.loginURL),
        headers: await getHeaders(),
        body: jsonEncode({"email": email, "password": password}),
      );

      switch (response.statusCode) {
        case 200:
          final data = jsonDecode(response.body);
          if (data.containsKey("jwt")) {
            await saveToken(data["jwt"]); // Store JWT Token
            print("Token Saved: ${data["jwt"]}"); //debugging
          } else {
            print("No Token");
          }
          return RequestState.ok;
        case 400:
          return RequestState.badRequest;
        case 401:
          return RequestState.unauthorized;
        case 500:
          return RequestState.serverFailure;
        default:
          return RequestState.unexpectedError;
      }
    } catch (e) {
      return RequestState.unexpectedError;
    }
  }
}
