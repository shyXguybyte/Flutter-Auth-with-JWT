import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:studyflow/screens/Main%20Screens/navBar.dart';
import 'package:studyflow/screens/User%20Auth/signin.dart';
import 'package:studyflow/services/api_service.dart';
import 'package:studyflow/services/getErrorMessage.dart';
import 'package:studyflow/services/requestState.dart';
import 'package:studyflow/utils/Colors.dart';
import 'package:studyflow/utils/custom_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  Future<void> handleSignup(BuildContext context, String username, String email,
      String password) async {
    if (_formKey.currentState!.validate()) {
      final apiService = ApiService();
      RequestState result = await apiService.signup(username, email, password);

      if (result == RequestState.ok) {
        Navigator.pushReplacement(
          context,
          PageTransition(
            child: const NavBar(),
            type: PageTransitionType.bottomToTop,
          ),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(getErrorMessage(result))));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/Sign up-cuate.png'),
                const SizedBox(height: 20),
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 30),
                CustomTextfield(
                  icon: Icons.person,
                  obscureText: false,
                  hintText: 'Enter Username',
                  controller: _userNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your username";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextfield(
                  icon: Icons.alternate_email,
                  obscureText: false,
                  hintText: 'Enter Email',
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a valid email";
                    } else if (!value.contains('@')) {
                      return "Email must contain '@'";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextfield(
                  icon: Icons.lock,
                  obscureText: true,
                  hintText: 'Enter Password',
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a password";
                    } else if (value.length < 6) {
                      return "Password must be at least 6 characters long";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    var username = _userNameController.text;
                    var email = _emailController.text;
                    var password = _passwordController.text;
                    handleSignup(context, username, email, password);
                  },
                  child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Constants.MyYellow,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: const Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  child: Center(
                    child: Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(
                            color: Constants.blackColor,
                          ),
                        ),
                        TextSpan(
                          text: 'Sign In',
                          style: TextStyle(
                            color: Constants.MyYellow,
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
