import 'package:flutter/material.dart';
import 'package:interview_test/core/extensions/string_validator.dart';
import 'package:interview_test/features/manage_users/domain/entities/user.dart';
import 'package:interview_test/features/manage_users/presentation/bloc/user_bloc.dart';
import 'package:interview_test/features/manage_users/presentation/bloc/user_event.dart';
import 'package:interview_test/features/manage_users/presentation/ui/widgets/user_text_form_field.dart';

class CreateUserDialog extends StatefulWidget {
  const CreateUserDialog({super.key, required this.userBloc});

  final UserBloc userBloc;

  @override
  State<CreateUserDialog> createState() => _CreateUserDialogState();
}

class _CreateUserDialogState extends State<CreateUserDialog> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final UserBloc _userBloc;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    _userBloc = widget.userBloc;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add New Customer"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            UserTextFormField(
              controller: nameController,
              hintText: "Enter username",
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "Username is required";
                }
                if (value.trim().length < 3) {
                  return "Username must be at least 3 characters long";
                }
                if (!value.trim().isValidUsername()) {
                  return "Invalid username format";
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            UserTextFormField(
              controller: emailController,
              hintText: "Enter email",
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "Email is required";
                }
                if (!value.trim().isValidEmail()) {
                  return "Invalid email format";
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final user = User(
                id: DateTime.now().toString(),
                name: nameController.text.trim(),
                email: emailController.text.trim(),
              );
              _userBloc.add(CreateUser(user));
              Navigator.of(context).pop();
            }
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
