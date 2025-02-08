class LoginModel {
  final String email;
  final String password;

  LoginModel(
      //constructor
      {required this.email,
      required this.password});

///  converts the LoginModel instance into a map (a key-value pair structure).
/// for serializing the data into formats like JSON, which can be sent to APIs.
/// Serialization
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

// a factory constructor, used to create a LoginModel instance from a map.
// takes Map<String, dynamic> as input and extracts the email and password fields to create a new LoginModel object.
// Ensures that the values from the map are cast as String
// Deserialization
  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
        email: map['email'] as String, password: map['password'] as String);
  }
}
