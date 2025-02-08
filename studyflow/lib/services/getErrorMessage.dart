import 'requestState.dart';


String getErrorMessage(RequestState state) {
  switch (state) {
    case RequestState.ok:
      return "Signup successful!";
    case RequestState.badRequest:
      return "Invalid request. Please check your inputs.";
    case RequestState.unauthorized:
      return "Unauthorized access. Please log in again.";
    case RequestState.emailAlreadyExist:
      return "Email already exists. Try another one.";
    case RequestState.serverFailure:
      return "Server error. Please try again later.";
    case RequestState.internetFailure:
      return "No internet connection. Please check your network.";
    case RequestState.unexpectedError:
      return "An unexpected error occurred. Please try again.";
    default:
      return "Something went wrong. Error: $state"; // Debugging info
  }
}
