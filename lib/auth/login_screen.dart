import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'signup_screen.dart';
import '../dashboard/dashboard_screen.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // 🔥 Branding
            Text(
              "TaskHub",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "Welcome back 👋",
              style: TextStyle(
                fontSize: 18,
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

            // 🔘 Login Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                elevation: 2,
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                try {
                  await auth.signIn(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => DashboardScreen()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Login failed")),
                  );
                }
              },
              child: Text("Login"),
            ),

            SizedBox(height: 10),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SignupScreen()),
                );
              },
              child: Text("Create account 🚀"),
            )
          ],
        ),
      ),
    );
  }
}