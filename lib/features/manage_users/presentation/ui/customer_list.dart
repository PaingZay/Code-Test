import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_test/features/manage_users/presentation/bloc/user_bloc.dart';
import 'package:interview_test/features/manage_users/presentation/bloc/user_event.dart';
import 'package:interview_test/features/manage_users/presentation/bloc/user_state.dart';
import 'package:interview_test/features/manage_users/domain/entities/user.dart';

class CustomerListScreen extends StatelessWidget {
  const CustomerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text("Customers")),
          body: _buildBody(context, state),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showCreateUserDialog(context),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, UserState state) {
    if (state is UsersLoaded) {
      final users = state.users;
      if (users.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("No customers found"),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _showCreateUserDialog(context),
                child: const Text("Add First Customer"),
              ),
            ],
          ),
        );
      }
      return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text(user.name),
            subtitle: Text(user.email),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _showEditUserDialog(context, user),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    context.read<UserBloc>().add(DeleteUser(user.id));
                  },
                ),
              ],
            ),
          );
        },
      );
    } else if (state is UserError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(state.message),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.read<UserBloc>().add(LoadUsers()),
              child: const Text("Try Again"),
            ),
          ],
        ),
      );
    }

    return const Center(child: Text("No customers to display"));
  }

  void _showCreateUserDialog(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Add New Customer"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                final user = User(
                  id: DateTime.now().toString(),
                  name: nameController.text,
                  email: emailController.text,
                );
                context.read<UserBloc>().add(CreateUser(user));
                Navigator.of(dialogContext).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _showEditUserDialog(BuildContext context, User user) {
    final nameController = TextEditingController(text: user.name);
    final emailController = TextEditingController(text: user.email);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Edit Customer"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                final updatedUser = User(
                  id: user.id,
                  name: nameController.text,
                  email: emailController.text,
                );
                context.read<UserBloc>().add(UpdateUser(updatedUser));
                Navigator.of(dialogContext).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
