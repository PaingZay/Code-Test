import 'package:flutter/material.dart';
import 'package:interview_test/dependency_container.dart';
import 'package:interview_test/features/auth/presentation/viewmodels/base_view_model.dart';
import 'package:provider/provider.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  const BaseView({super.key, required this.builder, this.onModelReady});

  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final Function(T)? onModelReady;

  @override
  BaseViewState<T> createState() => BaseViewState<T>();
}

class BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  T model = locator<T>();

  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady!(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (BuildContext context) => model,
      child: Consumer<T>(builder: widget.builder),
    );
  }
}
