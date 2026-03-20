import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign Up",
          style: TextStyle(color: theme.colorScheme.onBackground),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: theme.iconTheme.color),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // 🔥 Title
            Text(
              "Create Account 🚀",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onBackground,
              ),
            ),

            SizedBox(height: 30),

            // 📧 Email
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "Enter your email",
                prefixIcon: Icon(Icons.email),
              ),
            ),

            SizedBox(height: 15),

            // 🔒 Password
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Enter your password",
                prefixIcon: Icon(Icons.lock),
              ),
            ),

            SizedBox(height: 25),

            // 🔘 Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 2,
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                try {
                  await auth.signUp(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Signup successful!")),
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                  );

                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString())),
                  );
                }
              },
              child: Text("Sign Up"),
            ),

            SizedBox(height: 10),

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Already have an account? Login"),
            )
          ],
        ),
      ),
    );
  }
}