import 'package:flutter/material.dart';
import 'package:flutter_app/features/authentication/view_models/authentication_view_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberTextController = TextEditingController();

  LoginScreen({super.key});

  void _handleSubmit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthenticationViewModel>().handleLogin(_phoneNumberTextController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16,
                children: [
                  TextFormField(
                    controller: _phoneNumberTextController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: "Phone number"),
                  ),
                  FilledButton(onPressed: () => _handleSubmit(context), child: Text("Login")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
