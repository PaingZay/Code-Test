import 'package:flutter/material.dart';
import 'package:interview_test/core/enum.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:interview_test/features/home/domain/entities/pickup_item.dart';
import 'package:interview_test/features/home/presentation/viewmodels/pickup_view_model.dart';
import 'package:interview_test/features/home/presentation/views/widgets/list_item.dart';
import 'package:provider/provider.dart';

class DeliveryListView extends StatefulWidget {
  const DeliveryListView({
    super.key,
    required List<PickupItem> pickupItems,
    required int totalRecords,
  }) : _pickupItems = pickupItems,
       _totalRecords = totalRecords;

  final List<PickupItem> _pickupItems;
  final int _totalRecords;

  @override
  State<DeliveryListView> createState() => _DeliveryListViewState();
}

class _DeliveryListViewState extends State<DeliveryListView> {
  final RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  // Track the current page for pagination
  int currentPage = 1;

  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PickupViewModel>(context);

    return SmartRefresher(
      enablePullUp: true,
      controller: refreshController,
      onRefresh: () async {
        currentPage = 0;
        await viewModel.getPickupData(page: currentPage);
        refreshController.refreshCompleted();
      },
      onLoading: () async {
        if (widget._pickupItems.length < widget._totalRecords) {
          currentPage++;
          await viewModel.getPickupData(page: currentPage);

          refreshController.loadComplete();
        } else {
          refreshController.loadNoData();
        }
      },
      child:
          viewModel.state == ViewState.busy
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: widget._pickupItems.length,
                itemBuilder: (context, index) {
                  final pickupItem = widget._pickupItems[index];
                  return PickupItemCell(
                    trackingId: pickupItem.trackingId,
                    osName: pickupItem.osName,
                    osTownshipName: pickupItem.osTownshipName,
                    pickupDate: pickupItem.pickupDate,
                    totalWays: pickupItem.totalWays,
                    osPrimaryPhone: pickupItem.osPrimaryPhone,
                    totalRecords: widget._totalRecords,
                  );
                },
              ),
    );
  }
}
