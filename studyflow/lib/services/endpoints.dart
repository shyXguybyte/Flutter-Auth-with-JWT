class ApiEndpoints {
  // Base URL for the API
  static const String baseURL = "https://studyoverflow.runasp.net/api/Account";

  // Authentication Endpoints
  static const String loginURL = "$baseURL/login";
  static const String signupURL = "$baseURL/register";
  static const String refreshUserToken = "$baseURL/refresh-user-token";

  // User Information and Account Management
  static const String info = "$baseURL/Info";
  static const String confirmEmail = "$baseURL/confirm-email";
  static const String resetPassword = "$baseURL/reset-password";
  static const String logout = "$baseURL/logout";

  // Dynamic Endpoints
  static String resendEmailConfirmationLink(String email) {
    return "$baseURL/resend-email-confirmation-link/$email";
  }

  static String forgetPasswordUrl(String email) {
    return "$baseURL/forgot-username-or-password/$email";
  }
}
