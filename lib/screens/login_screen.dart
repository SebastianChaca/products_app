import 'package:flutter/material.dart';
import 'package:productos_app/provider/login_form_provider.dart';
import 'package:productos_app/validators/input_form_validator.dart';

import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 130),
            CardContainer(
              child: Column(children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Login',
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(
                  height: 30,
                ),
                ChangeNotifierProvider(
                    create: (_) => LoginFormProvider(),
                    child: const _LoginForm()),
              ]),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text('Crear una nueva cuenta')
          ],
        ),
      ),
    ));
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
          key: loginForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) => loginForm.email = value,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration('Email'),
                validator: (value) {
                  return InputValidator.emailValidator(value ?? '');
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                onChanged: (value) => loginForm.password = value,
                autocorrect: false,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecorations.authInputDecoration('Password'),
                validator: (value) {
                  if (value != null && value.length >= 6) return null;
                  return 'La contra debe ser de 6 caracteres';
                },
              ),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: loginForm.isLoading
                    ? null
                    : () {
                        FocusScope.of(context).unfocus();
                        loginForm.isValidForm();

                        Navigator.pushReplacementNamed(context, 'home');
                      },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.deepPurple,
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    child: const Text(
                      'Ingresar',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    )),
              ),
            ],
          )),
    );
  }
}
