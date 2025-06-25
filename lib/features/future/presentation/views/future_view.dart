import 'package:bitvest/features/future/presentation/views/position_item.dart';
import 'package:bitvest/features/future/presentation/views/position_screen.dart';
import 'package:bitvest/features/trade/presentation/views/coin_details_view.dart'; // تأكد من استيراده
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/components/widgets/circle_loading.dart';
import '../../../../core/constant/colors.dart';
import '../../data/models/available_coins/FuturesAvailableCoins.dart';
import '../../data/models/futures_position_response/futures_position.dart';
import '../../data/repos/future_repo_impl.dart';
import '../controller/future_controller.dart';

class FutureView extends StatelessWidget {
  const FutureView({super.key});

  @override
  Widget build(BuildContext context) {
    final FutureController controller =
        Get.put(FutureController(FutureRepoImpl()));
    final RxBool _showAllClosed = false.obs;

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Futures Market', style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      body: RefreshIndicator(
        color: kAmberColor,
        backgroundColor: kBlackColor,
        strokeWidth: 3,
        onRefresh: controller.refreshData,
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircleLoading());
          }

          if (controller.error.isNotEmpty) {
            return Center(
              child: Text(controller.error.value,
                  style: const TextStyle(color: Colors.red)),
            );
          }

          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r)),
                      ),
                      icon: const Icon(Icons.sync_alt, color: Colors.white),
                      label: const Text('Futures → Spot',
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        showTransferBackDialog(context, controller);
                      },
                    ),
                  ),
                  SizedBox(height: 12.h),
                  if (controller.wallet.value.futuresWallets != null &&
                      controller.wallet.value.futuresWallets!.isNotEmpty) ...[
                    Text(
                      'Futures Wallets',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: kAmberColor,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    SizedBox(
                      height: 120.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            controller.wallet.value.futuresWallets!.length,
                        separatorBuilder: (_, __) => SizedBox(width: 12.w),
                        itemBuilder: (context, index) {
                          final wallet =
                              controller.wallet.value.futuresWallets![index];
                          return GestureDetector(
                            onTap: () {
                              Get.to(PositionScreen(
                                currency: wallet.currency ?? '',
                              ));
                            },
                            child: Container(
                              width: 180.w,
                              padding: EdgeInsets.all(12.r),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.deepPurple.shade800,
                                    Colors.black
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(16.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.deepPurple.withOpacity(0.3),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(wallet.currency ?? '',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                  const SizedBox(height: 6),
                                  Text('Balance: ${wallet.balance}',
                                      style: const TextStyle(
                                          color: Colors.white70)),
                                  Text('Margin: ${wallet.margin}',
                                      style: const TextStyle(
                                          color: Colors.white70)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                  Obx(() {
                    if (controller.openPositions.isEmpty)
                      return const SizedBox();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.verticalSpace,
                        Text(
                          '📂 Open Positions',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        8.verticalSpace,
                        ListView.builder(
                          itemCount: controller.openPositions.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final position = controller.openPositions[index];
                            return PositionItem(
                                position: position, controller: controller);
                          },
                        ),
                      ],
                    );
                  }),
                  Obx(() {
                    if (controller.closedPositions.isEmpty)
                      return const SizedBox();

                    // كم صفقة نعرض؟
                    final countToShow = _showAllClosed.value
                        ? controller.closedPositions.length // عرض الكل
                        : controller.closedPositions.length
                            .clamp(0, 2); // أوّل 2 فقط

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.verticalSpace,
                        Text(
                          '📁 Closed Positions',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.orangeAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        8.verticalSpace,
                        ListView.builder(
                          itemCount: countToShow,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final position = controller.closedPositions[index];
                            return _closedItem(position);
                          },
                        ),
                        if (controller.closedPositions.length > 2)
                          Align(
                            alignment: Alignment.center,
                            child: TextButton.icon(
                              onPressed: () => _showAllClosed.toggle(),
                              icon: Icon(
                                _showAllClosed.value
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: kAmberColor,
                              ),
                              label: Text(
                                _showAllClosed.value ? 'Less' : 'More',
                                style: TextStyle(
                                  color: kAmberColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                              ),
                            )

                          ),
                      ],
                    );
                  }),
                  SizedBox(height: 12.h),
                  if ((controller.availableCoins.value.userFuturesWalletCoins !=
                              null &&
                          controller.availableCoins.value
                              .userFuturesWalletCoins!.isNotEmpty) ||
                      (controller.availableCoins.value
                                  .userAvailableToTradeFutures !=
                              null &&
                          controller.availableCoins.value
                              .userAvailableToTradeFutures!.isNotEmpty))
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (controller.availableCoins.value
                                    .userFuturesWalletCoins !=
                                null &&
                            controller.availableCoins.value
                                .userFuturesWalletCoins!.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('💰 Futures Wallet Coins:',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.amberAccent)),
                              SizedBox(height: 6.h),
                              Wrap(
                                spacing: 8,
                                children: controller.availableCoins.value
                                    .userFuturesWalletCoins!
                                    .map((coin) => Chip(
                                          label: Text(coin,
                                              style: const TextStyle(
                                                  color: Colors.white)),
                                          backgroundColor: Colors.amber,
                                        ))
                                    .toList(),
                              ),
                              SizedBox(height: 12.h),
                            ],
                          ),
                        if (controller.availableCoins.value
                                    .userAvailableToTradeFutures !=
                                null &&
                            controller.availableCoins.value
                                .userAvailableToTradeFutures!.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('📈 Tradable Futures Coins:',
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.greenAccent)),
                              SizedBox(height: 6.h),
                              Wrap(
                                spacing: 8,
                                children: controller.availableCoins.value
                                    .userAvailableToTradeFutures!
                                    .map((coin) => Chip(
                                          label: Text(coin,
                                              style: const TextStyle(
                                                  color: Colors.white)),
                                          backgroundColor: Colors.green,
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                      ],
                    ),
                  SizedBox(height: 12.h),
                  Text(
                    'Available Futures Coins',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: kAmberColor,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  ListView.builder(
                    itemCount: controller.availableCoins.value
                            .futuresAvailableCoins?.length ??
                        0,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final coin = controller
                          .availableCoins.value.futuresAvailableCoins![index];
                      final bool isNegative =
                          (coin.changeRatePercentage ?? 0) < 0;

                      return GestureDetector(
                        onTap: () {
                          if (coin.symbol != null) {
                            Get.to(() => CoinDetailsView(coinId: coin.id!));
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 12.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade900,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                                color: Colors.grey.shade800, width: 0.7),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 22.r,
                                backgroundColor: Colors.black,
                                backgroundImage: NetworkImage(coin.icon ?? ''),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${coin.name} (${coin.symbol})',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      'Price: \$${coin.price}',
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          color: Colors.white70),
                                    ),
                                    Text(
                                      'Change: ${coin.changeRatePercentage?.toStringAsFixed(2)}%',
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          color: isNegative
                                              ? Colors.red
                                              : Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('Vol: ${coin.volume}',
                                      style: const TextStyle(
                                          color: Colors.white70, fontSize: 12)),
                                  Text('Cap: ${coin.marketCap}',
                                      style: const TextStyle(
                                          color: Colors.white70, fontSize: 12)),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

void showTransferBackDialog(BuildContext context, FutureController controller) {
  FuturesAvailableCoins? selectedCoin;
  final amountController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.grey[900],
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: StatefulBuilder(
        builder: (context, setState) => SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Transfer to Spot",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Select Coin",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white24),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<FuturesAvailableCoins>(
                    value: selectedCoin,
                    isExpanded: true,
                    iconEnabledColor: Colors.white,
                    dropdownColor: Colors.grey[850],
                    // درجة رمادي وسط
                    hint: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'Choose a coin',
                        style: TextStyle(color: Colors.white60, fontSize: 14),
                      ),
                    ),
                    items: controller
                        .availableCoins.value.futuresAvailableCoins!
                        .map((coin) => DropdownMenuItem<FuturesAvailableCoins>(
                              value: coin,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(coin.icon ?? ''),
                                    radius: 14,
                                    backgroundColor: Colors.white10,
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        coin.name ?? "",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        coin.symbol ?? "",
                                        style: const TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                    onChanged: (val) {
                      setState(() => selectedCoin = val);
                    },
                    selectedItemBuilder: (context) {
                      return controller
                          .availableCoins.value.futuresAvailableCoins!
                          .map((coin) => Row(
                                children: [
                                  const SizedBox(width: 10),
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(coin.icon ?? ''),
                                    radius: 12,
                                    backgroundColor: Colors.white10,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "${coin.name} (${coin.symbol})",
                                    style: const TextStyle(color: Colors.white),
                                  )
                                ],
                              ))
                          .toList();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Amount",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                style: const TextStyle(color: Colors.white),
                decoration: _darkInputDecoration(hintText: "e.g. 0.1"),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel",
                        style:
                            TextStyle(color: Colors.redAccent, fontSize: 16)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () async {
                      final rawAmount = amountController.text.trim();
                      final parsedAmount = double.tryParse(rawAmount);

                      if (selectedCoin == null) {
                        Get.snackbar(
                          "Invalid Input",
                          "Please select a coin.",
                          backgroundColor: Colors.orange,
                          colorText: Colors.white,
                        );
                        return;
                      }

                      if (rawAmount.isEmpty ||
                          parsedAmount == null ||
                          parsedAmount <= 0) {
                        Get.snackbar(
                          "Invalid Amount",
                          "Please enter a valid amount greater than 0",
                          backgroundColor: Colors.orange,
                          colorText: Colors.white,
                        );
                        return;
                      }

                      Navigator.pop(context);

                      final result = await controller.transferFuturesSpot(
                        currency: selectedCoin!.id ?? '',
                        amount: parsedAmount,
                      );

                      final message =
                          result["message"]?.toString().toLowerCase() ?? '';

                      if (message.contains("success")) {
                        Get.snackbar(
                          "Success",
                          result["message"] ?? "Transfer completed",
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                      } else {
                        Get.snackbar(
                          "Failed",
                          result["message"] ?? "Something went wrong",
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }
                    },
                    child: const Text("Transfer",
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _closedItem(FuturesPosition position) {
  return Container(
    margin: EdgeInsets.only(bottom: 12.h),
    padding: EdgeInsets.all(12.r),
    decoration: BoxDecoration(
      color: Colors.grey.shade800,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: Colors.grey.shade600),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${position.currency} (${position.direction.toUpperCase()})',
            style: TextStyle(color: Colors.white, fontSize: 16.sp)),
        4.verticalSpace,
        Text('Entry Price: ${position.entryPrice}',
            style: const TextStyle(color: Colors.white70)),
        Text('Size: ${position.size}',
            style: const TextStyle(color: Colors.white70)),
        Text('Leverage: x${position.leverage}',
            style: const TextStyle(color: Colors.white70)),
        Text(
          'Closed At: ${position.updatedAt?.toString().split('T').first}',
          style: const TextStyle(color: Colors.white54),
        ),
      ],
    ),
  );
}

InputDecoration _darkInputDecoration({String? hintText}) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.grey[850],
    hintText: hintText,
    hintStyle: const TextStyle(color: Colors.white30),
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.white24),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.blueAccent),
    ),
  );
}
