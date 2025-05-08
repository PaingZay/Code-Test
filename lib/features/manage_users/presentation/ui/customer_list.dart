import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_test/core/uitls/toast_utils.dart';
import 'package:interview_test/features/manage_users/presentation/bloc/user_bloc.dart';
import 'package:interview_test/features/manage_users/presentation/bloc/user_event.dart';
import 'package:interview_test/features/manage_users/presentation/bloc/user_state.dart';
import 'package:interview_test/features/manage_users/domain/entities/user.dart';
import 'package:interview_test/features/manage_users/presentation/ui/widgets/create_user_dialog.dart';
import 'package:interview_test/features/manage_users/presentation/ui/widgets/edit_user_dialog.dart';
import 'package:interview_test/features/manage_users/presentation/ui/widgets/keyboard_dismisser.dart';

class CustomerListScreen extends StatelessWidget {
  const CustomerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case const (UsersLoaded):
            ToastUtils.showSuccess((state as UsersLoaded).message);
          case const (UserCreated):
            ToastUtils.showSuccess((state as UserCreated).message);
          case const (UserUpdated):
            ToastUtils.showSuccess((state as UserUpdated).message);
          case const (UserDeleted):
            ToastUtils.showSuccess((state as UserDeleted).message);
          case const (UserError):
            ToastUtils.showError((state as UserError).message);
        }
      },
      builder: (context, state) {
        return KeyboardDismisser(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(title: const Text("Customers")),
            body: _buildBody(context, state),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _showCreateUserDialog(context),
              child: const Icon(Icons.add),
            ),
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
              const Text("No users found"),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _showCreateUserDialog(context),
                child: const Text("Add new user"),
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
                  onPressed: () => _showEditDialog(context, user),
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
    if (state is UserLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return const SizedBox.shrink();
  }

  void _showCreateUserDialog(BuildContext context) {
    final userBloc = context.read<UserBloc>();

    showDialog(
      context: context,
      builder: (context) => CreateUserDialog(userBloc: userBloc),
    );
  }

  void _showEditDialog(BuildContext context, User user) {
    final userBloc = context.read<UserBloc>();

    showDialog(
      context: context,
      builder: (context) => EditUserDialog(user: user, userBloc: userBloc),
    );
  }
}
