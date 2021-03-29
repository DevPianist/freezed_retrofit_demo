import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/request/user/user_request.dart';
import '../../../dialogs/custom_dialog.dart';

class UserRegisterDialog extends StatelessWidget {
  UserRegisterDialog({
    Key? key,
    required this.onSubmitted,
    required this.invalid,
  }) : super(key: key);
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final void Function(UserRequest request) onSubmitted;
  final VoidCallback invalid;

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Register',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                validator: (value) => value!.isEmpty ? 'Name required' : null,
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                validator: (value) =>
                    value!.isEmpty ? 'Username required' : null,
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              const SizedBox(height: 20.0),
              MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context);
                    onSubmitted.call(
                      UserRequest.fromJson({
                        'name': _nameController.text,
                        'username': _usernameController.text,
                      }),
                    );
                  } else {
                    invalid.call();
                  }
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<T?> show<T>(
    BuildContext context, {
    required void Function(UserRequest request) onSubmitted,
    required VoidCallback invalid,
  }) {
    return showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: false,
      builder: (_) => UserRegisterDialog(
        onSubmitted: onSubmitted,
        invalid: invalid,
      ),
    );
  }
}
