import 'package:chat_app/auth_provider.dart';
import 'package:chat_app/home_screen.dart';
import 'package:chat_app/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true, // Prevent overflow when the keyboard appears
      backgroundColor: Colors.white,
      appBar: AppBar(
        // Change the style of the title into a centered, Bahnschrift font
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(top: 40.0), // Add padding to the top
          child: Text(
            "Chat App",
            style: TextStyle(
              fontSize: 36,
              fontFamily: "Roboto",
              color: Colors.black, // Ensure the text color is visible on white background
            ),
          ),
        ),
        toolbarHeight: 140.0, // Increase the height of the AppBar
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextSelectionTheme(
                  data: TextSelectionThemeData(
                    cursorColor: Colors.black, // Change cursor color to black
                    selectionColor: Colors.grey, // Change selection color to grey
                    selectionHandleColor:
                    Colors.grey, // Change selection handle color to grey
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(
                        color: const Color.fromARGB(255, 113, 113, 113),
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email.';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                TextSelectionTheme(
                  data: TextSelectionThemeData(
                    cursorColor: Colors.black, // Change cursor color to black
                    selectionColor: Colors.grey, // Change selection color to grey
                    selectionHandleColor:
                    Colors.grey, // Change selection handle color to grey
                  ),
                  child: TextFormField(
                    controller: _passController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(
                        color: const Color.fromARGB(255, 113, 113, 113),
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password.';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 50),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        await authProvider.signIn(
                            _emailController.text, _passController.text);
                        Fluttertoast.showToast(msg: "Login successful");

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        );
                      } catch (e) {
                        Fluttertoast.showToast(msg: "Login failed: $e");
                        print(e);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text("OR"),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Create account",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
