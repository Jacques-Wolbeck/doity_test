import 'package:doity_test/views/widgets/app_title.dart';
import 'package:doity_test/views/widgets/login_widgets/email_field.dart';
import 'package:doity_test/views/widgets/login_widgets/login_button.dart';
import 'package:doity_test/views/widgets/login_widgets/password_field.dart';
import 'package:flutter/material.dart';

// Tela de Login do App, aqui serve apenas como exemplo de tela utlizando formularios com validadores
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formkey = GlobalKey<FormState>();
  final _loginInfo = <String, String>{};
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  @override
  void dispose() {
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                const AppTitle(),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      EmailField(
                        onSavedCallback: (value) =>
                            _loginInfo['email'] = value!,
                        currentFocus: emailFocus,
                        nextFocus: passwordFocus,
                      ),
                      PasswordField(
                        onSavedCallback: (value) =>
                            _loginInfo['password'] = value!,
                        currentFocus: passwordFocus,
                      ),
                    ],
                  ),
                ),
                LoginButton(formKey: _formkey, loginInfo: _loginInfo),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
