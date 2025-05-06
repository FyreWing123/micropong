import 'package:aplikasi/Components/loginbutton.dart';
import 'package:aplikasi/Homepage/homepage.dart';
import 'package:aplikasi/LoginScreen/forgotpassword.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi/LoginScreen/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  String? _emailError;
  String? _passwordError;

  void _handleLogin() async {
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        if (email.isEmpty) _emailError = 'Email tidak boleh kosong';
        if (password.isEmpty) _passwordError = 'Password tidak boleh kosong';
      });
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.of(context).pushNamed(Homepage.routeName);
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'invalid-credential') {
          _emailError = 'Email atau password salah';
          _passwordError = 'Email atau password salah';
        }
        return;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(leading: Container()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Log In",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF9110DC),
              ),
            ),
            const SizedBox(height: 5),
            const Text("Welcome back!", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),

            const Text("Your Email"),
            const SizedBox(height: 5),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Enter your email",
                errorText: _emailError,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),

            const Text("Password"),
            const SizedBox(height: 5),
            TextField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                hintText: "Enter your password",
                errorText: _passwordError,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed:
                    () => Navigator.of(
                      context,
                    ).pushNamed(Forgotpassword.routeName),
                child: const Text(
                  "Forgot your password?",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Row(
              children: const [
                Expanded(child: Divider(thickness: 1)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text("or Log In with"),
                ),
                Expanded(child: Divider(thickness: 1)),
              ],
            ),
            const SizedBox(height: 15),
            Center(
              child: IconButton(
                icon: Image.asset('images/googlelogo.png', width: 40),
                onPressed: () {
                  // Add Google login logic
                },
              ),
            ),
            const SizedBox(height: 15),

            LoginButton(onTap: _handleLogin),
            const SizedBox(height: 20),

            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap:
                        () => Navigator.of(context).pushNamed(SignUp.routeName),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
