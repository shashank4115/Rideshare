import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridesharev2/Components/my_button.dart';
import 'package:ridesharev2/Components/my_text_field.dart';
import 'package:ridesharev2/Services/Auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //textcontroller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signIn() async {
    //get auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailandPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25.0,
            vertical: 16.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50.0),
              //logo
              Center(
                child: Container(
                  height: 100.0,
                  child: Image.asset(
                    'Image/RideShare.png',
                  ),
                ),
              ),
              const SizedBox(height: 25.0),
              //welcome back message
              const Text(
                "Welcome back",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 25.0),
              //email text field
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),
              const SizedBox(height: 16.0),
              //password text field
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 16.0),
              //sign-in button
              MyButton(onTap: signIn, text: 'Sign-in'),
              const SizedBox(height: 25.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Not a member?"),
                  const SizedBox(width: 4.0),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Register now',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              //not a member?? register
            ],
          ),
        ),
      ),
    );
  }
}
