import 'package:flutter/material.dart';
import 'package:interview_test/features/auth/presentation/views/base_view.dart';
import 'package:interview_test/features/auth/presentation/views/widgets/keyboard_dismisser.dart';
import 'package:interview_test/features/home/presentation/viewmodels/pickup_view_model.dart';
import 'package:interview_test/features/home/presentation/views/widgets/tab_bar_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<PickupViewModel>(
      onModelReady: (model) {
        if (mounted) {
          model.getPickupData();
        }
      },
      builder: (context, model, child) => HomeView(),
    );
  }
}

logout(BuildContext context, bool mounted) {
  final viewModel = Provider.of<PickupViewModel>(context, listen: false);
  viewModel.logout().then((isLoggedOut) {
    if (!mounted) return;
    if (isLoggedOut) {
      Navigator.pushReplacementNamed(context, '/');
    }
  });
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: DefaultTabController(
        length: 3, // Number of tabs
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(52, 107, 209, 1),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () => logout(context, true),
                  child: Text(
                    "Logout",
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
            bottom: TabBar(
              labelColor: Colors.white,
              indicatorColor: Colors.red,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(text: 'Pickup on way'),
                Tab(text: 'Pickup Completed'),
                Tab(text: 'Pickup Cancel'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Consumer<PickupViewModel>(
                builder: (context, viewModel, child) {
                  return DeliveryListView(
                    pickupItems:
                        viewModel.pickupItems?.map((item) => item).toList() ??
                        [],
                    totalRecords: viewModel.totalRecord ?? 0,
                  );
                },
              ),
              Consumer<PickupViewModel>(
                builder: (context, viewModel, child) {
                  return DeliveryListView(
                    pickupItems:
                        viewModel.pickupItems?.map((item) => item).toList() ??
                        [],
                    totalRecords: viewModel.totalRecord ?? 0,
                  );
                },
              ),
              Consumer<PickupViewModel>(
                builder: (context, viewModel, child) {
                  return DeliveryListView(
                    pickupItems:
                        viewModel.pickupItems?.map((item) => item).toList() ??
                        [],
                    totalRecords: viewModel.totalRecord ?? 0,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
