import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram/repositories/auth/auth_repository.dart';
import 'package:flutter_instagram/screens/login/cubit/login_cubit.dart';
import 'package:flutter_instagram/screens/screens.dart';
import 'package:flutter_instagram/widgets/error_dialog.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  static Route route() {
    return PageRouteBuilder(
      pageBuilder: (context, _, __) => BlocProvider<LoginCubit>(
          create: (_) =>
              LoginCubit(authRepository: context.read<AuthRepository>()),
          child: LoginScreen()),
      settings: RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitForm(BuildContext context, bool isSubmitting) {
    if (_formKey.currentState.validate() && !isSubmitting) {
      context.read<LoginCubit>().logInWithCredentials();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.error) {
              showDialog(
                context: context,
                builder: (context) =>
                    ErrorDialog(content: state.failure.message),
              );
            }
          },
          builder: (context, state) => Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Instagram',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          TextFormField(
                            decoration: InputDecoration(hintText: 'Email'),
                            onChanged: (value) =>
                                context.read<LoginCubit>().emailChanged(value),
                            validator: (value) => !value.contains('@')
                                ? 'Please enter a valid email'
                                : null,
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          TextFormField(
                            decoration: InputDecoration(hintText: 'Password'),
                            obscureText: true,
                            onChanged: (value) => context
                                .read<LoginCubit>()
                                .passwordChanged(value),
                            validator: (value) => value.length < 6
                                ? 'Must be at tleast 6 characters.'
                                : null,
                          ),
                          const SizedBox(
                            height: 28.0,
                          ),
                          RaisedButton(
                            onPressed: () => _submitForm(context,
                                state.status == LoginStatus.submitting),
                            elevation: 1.0,
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            child: Text('Login'),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          RaisedButton(
                            onPressed: () => Navigator.of(context).pushNamed(
                              SignupScreen.routeName,
                            ),
                            elevation: 1.0,
                            color: Colors.grey[200],
                            textColor: Colors.black,
                            child: Text('No account? Sign up'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
