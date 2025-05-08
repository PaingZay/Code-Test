import 'package:flutter/material.dart';
import 'package:interview_test/core/extensions/string_validator.dart';
import 'package:interview_test/features/manage_users/domain/entities/user.dart';
import 'package:interview_test/features/manage_users/presentation/bloc/user_bloc.dart';
import 'package:interview_test/features/manage_users/presentation/bloc/user_event.dart';
import 'package:interview_test/features/manage_users/presentation/ui/widgets/user_text_form_field.dart';

class EditUserDialog extends StatefulWidget {
  const EditUserDialog({super.key, required this.user, required this.userBloc});

  final User user;
  final UserBloc userBloc;

  @override
  State<EditUserDialog> createState() => _EditUserDialogState();
}

class _EditUserDialogState extends State<EditUserDialog> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final UserBloc _userBloc;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    emailController = TextEditingController(text: widget.user.email);
    _userBloc = widget.userBloc; // 👈 Store bloc locally
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
      title: const Text("Edit Customer"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            UserTextFormField(
              controller: nameController,
              hintText: "Enter username",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Username is required";
                }
                if (value.length < 3) {
                  return "Username must be at least 3 characters long";
                }
                if (!value.isValidUsername()) {
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
                if (value == null || value.isEmpty) {
                  return "Email is required";
                }
                if (!value.isValidEmail()) {
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
          onPressed: Navigator.of(context).pop,
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final updatedUser = User(
                id: widget.user.id,
                name: nameController.text,
                email: emailController.text,
              );
              _userBloc.add(UpdateUser(updatedUser));
              Navigator.of(context).pop();
            }
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
