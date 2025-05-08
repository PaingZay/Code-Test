import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:interview_test/dependency_container.dart';
import 'package:interview_test/features/manage_users/domain/usecases/create_users.dart';
import 'package:interview_test/features/manage_users/domain/usecases/delete_users.dart';
import 'package:interview_test/features/manage_users/domain/usecases/get_users.dart';
import 'package:interview_test/features/manage_users/domain/usecases/update_user.dart';
import 'package:interview_test/features/manage_users/presentation/bloc/user_bloc.dart';
import 'package:interview_test/features/manage_users/presentation/bloc/user_event.dart';
import 'package:interview_test/features/manage_users/presentation/ui/customer_list.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
      title: 'Interview Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider(
        create:
            (context) => UserBloc(
              getUsers: locator<GetUsers>(),
              createUser: locator<CreateUsers>(),
              updateUser: locator<UpdateUsers>(),
              deleteUser: locator<DeleteUsers>(),
            )..add(LoadUsers()),
        child: CustomerListScreen(),
      ),
    );
  }
}
