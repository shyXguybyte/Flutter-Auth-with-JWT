import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:studyflow/screens/User%20Auth/signup.dart';
import 'package:studyflow/services/api_service.dart';
import 'package:studyflow/services/getErrorMessage.dart';
import 'package:studyflow/services/requestState.dart';
import 'package:studyflow/utils/Colors.dart';
import 'package:studyflow/utils/custom_text_field.dart';
import '../Main Screens/navBar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> handleLogin(
      BuildContext context, String email, String password) async {
    if (_formKey.currentState!.validate()) {
      final apiService = ApiService();

      RequestState result = await apiService.login(email, password);

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
                Image.asset('assets/images/Login-cuate.png'),
                const Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 30),
                CustomTextfield(
                  icon: Icons.alternate_email,
                  obscureText: false,
                  hintText: 'Enter Email',
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                CustomTextfield(
                  icon: Icons.lock,
                  obscureText: true,
                  hintText: 'Enter Password',
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a password";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    var email = _emailController.text.trim();
                    var password = _passwordController.text.trim();
                    handleLogin(context, email, password);
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
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        child: const SignupScreen(),
                        type: PageTransitionType.bottomToTop,
                      ),
                    );
                  },
                  child: Center(
                    child: Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                            color: Constants.blackColor,
                          ),
                        ),
                        TextSpan(
                          text: 'Sign Up',
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
