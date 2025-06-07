import 'package:aplikasi/Homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi/Components/signupbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aplikasi/services/firestore_service.dart';
import 'package:aplikasi/models/user_model.dart';

class SignUp extends StatefulWidget {
  static const routeName = '/signup';
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _agreeToTerms = false;

  String? _emailError;
  String? _phoneError;
  String? _passwordError;

  bool _isEmailValid(String email) {
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
    return regex.hasMatch(email);
  }

  bool _isPhoneValid(String phone) {
    final regex = RegExp(r'^[0-9]{9,15}$');
    return regex.hasMatch(phone);
  }

  bool _isPasswordValid(String password) {
    final regex = RegExp(r'^(?=.*\d).{8,}$');
    return regex.hasMatch(password);
  }

  void _validateAndSubmit() async {
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final password = _passwordController.text.trim();
    final username = _usernameController.text.trim();

    setState(() {
      _emailError = _isEmailValid(email) ? null : 'Invalid email format';
      _phoneError = _isPhoneValid(phone) ? null : 'Invalid phone number';
      _passwordError =
          _isPasswordValid(password) ? null : 'Min 8 char with number';
    });

    if (!_agreeToTerms) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("You must agree to the terms.")));
      return;
    }

    if (_emailError == null && _phoneError == null && _passwordError == null) {
      try {
        final userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        if (userCredential.user != null) {
          final uid = userCredential.user!.uid;

          final newUser = UserModel(
            name: username,
            email: email,
            phoneNumber: phone,
            isProvider: false,
            emailVerified: userCredential.user!.emailVerified,
            phoneVerified: false,
            isVerified: false,
            ktmUrl: '',
            ktpUrl: '',
            selfieKtpUrl: '',
            authMethod: 'email',
            createdAt: DateTime.now(),
          );

          await FirestoreService().addUser(uid, newUser);

          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(Homepage.routeName, (route) => false);
        }
      } on FirebaseAuthException catch (e) {
        String message = 'Registration failed';
        if (e.code == 'email-already-in-use') {
          message = 'Email is already registered';
        } else if (e.code == 'weak-password') {
          message = 'Password is too weak';
        } else {
          message = e.message ?? message;
        }

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unexpected error: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return; // User cancelled

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      if (userCredential.user != null) {
        final user = userCredential.user!;

        // Simpan ke Firestore (optional)
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'username': user.displayName,
          'email': user.email,
          'photoURL': user.photoURL,
          'provider': 'google',
        }, SetOptions(merge: true));

        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(Homepage.routeName, (route) => false);
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Google Sign-In failed: $e')));
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
              "Sign Up",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF9110DC),
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "Enter your details below & free sign up",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Username Field
            const Text("Username"),
            const SizedBox(height: 5),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: "Enter your username",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Email Field
            const Text("Email"),
            const SizedBox(height: 5),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Enter your email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                errorText: _emailError,
              ),
            ),

            const SizedBox(height: 15),

            // Phone Number Field
            const Text("Phone Number"),
            const SizedBox(height: 5),
            Row(
              children: [
                SizedBox(
                  width: 60,
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: "+62",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "Enter your phone number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorText: _phoneError,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),

            // Password Field
            const Text("Password"),
            const SizedBox(height: 5),
            TextField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                hintText: "Enter your password",
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
                errorText: _passwordError,
              ),
            ),
            const SizedBox(height: 20),

            // Sign Up with Google
            Row(
              children: [
                const Expanded(child: Divider(thickness: 1)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text("or Sign Up with"),
                ),
                const Expanded(child: Divider(thickness: 1)),
              ],
            ),
            const SizedBox(height: 15),
            Center(
              child: IconButton(
                icon: Image.asset('images/googlelogo.png', width: 40),
                onPressed: _signInWithGoogle,
              ),
            ),
            const SizedBox(height: 15),

            Row(
              children: [
                Checkbox(
                  value: _agreeToTerms,
                  onChanged: (bool? value) {
                    setState(() {
                      _agreeToTerms = value ?? false;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                const Expanded(
                  child: Text(
                    "By creating an account you have to agree with our terms & condition.",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            SignUpButton(enabled: _agreeToTerms, onTap: _validateAndSubmit),
            const SizedBox(height: 20),

            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Log in",
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
