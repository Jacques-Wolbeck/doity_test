import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Map<String, String> loginInfo;

  const LoginButton({
    super.key,
    required this.formKey,
    required this.loginInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            Navigator.pushReplacementNamed(context, '/home_view');
          }
        },
        style: ElevatedButton.styleFrom(
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            minimumSize: Size(MediaQuery.of(context).size.width * .4, 45.0)),
        child: const Text(
          "Entrar",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
