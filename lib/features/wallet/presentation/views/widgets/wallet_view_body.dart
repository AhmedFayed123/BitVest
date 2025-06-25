import 'package:bitvest/core/constant/icons.dart';
import 'package:bitvest/features/p2p/presentation/views/p2p_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/components/widgets/see_all_raw.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../future/data/models/available_coins/FuturesAvailableCoins.dart';
import '../../../../future/data/repos/future_repo_impl.dart';
import '../../../../future/presentation/controller/future_controller.dart';
import '../../controllers/wallet_controller.dart';
import '../deposit_view.dart';
import 'balance_section.dart';
import 'custom_wallet_button.dart';
import 'my_assets_list.dart';

class WalletViewBody extends StatelessWidget {
  const WalletViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final WalletController walletController = Get.put(WalletController());
    final FutureController futureController =
        Get.put(FutureController(FutureRepoImpl()));

    return RefreshIndicator(
      onRefresh: walletController.refreshData,
      color: kAmberColor,
      backgroundColor: kBlackColor,
      strokeWidth: 3,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            BalanceSection(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // CustomWalletButton(
                //   icon: Icons.sync_alt,
                //   onPressed: () {
                //     showTransferDialog(Get.context!, futureController);
                //   },
                //   title: 'Spot → Futures',
                // ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                  icon: const Icon(Icons.sync_alt, color: Colors.white),
                  label: const Text('Spot → Futures',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    showTransferDialog(Get.context!, futureController);
                  },
                ),
                CustomWalletButton(
                  icon: AppIcons.arrow_circle_upward,
                  onPressed: () {
                    Get.defaultDialog(
                      title: "Choose Deposit Method",
                      titleStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      backgroundColor: const Color(0xFF121212),
                      radius: 12,
                      content: Column(
                        children: [
                          const SizedBox(height: 10),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              backgroundColor: const Color(0xFF1F8EFA),
                              // أزرق هادي
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            icon: const Icon(
                                Icons.account_balance_wallet_outlined,
                                color: Colors.white),
                            label: const Text("Deposit Method",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                            onPressed: () {
                              Get.back();
                              Get.to(() => DepositView());
                            },
                          ),
                          const SizedBox(height: 15),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              backgroundColor: const Color(0xFF4CAF50),
                              // أخضر هادي
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            icon: const Icon(Icons.swap_horiz,
                                color: Colors.white),
                            label: const Text("P2P Method",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                            onPressed: () {
                              Get.back();
                              Get.to(() => P2pView());
                            },
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    );
                  },
                  title: 'Deposit',
                ),

                CustomWalletButton(
                  icon: AppIcons.arrow_circle_down,
                  onPressed: () {
                    Get.defaultDialog(
                      title: "Choose Withdraw Method",
                      titleStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      backgroundColor: const Color(0xFF121212),
                      radius: 12,
                      content: Column(
                        children: [
                          const SizedBox(height: 10),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              backgroundColor: const Color(0xFF4CAF50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            icon: const Icon(Icons.swap_horiz,
                                color: Colors.white),
                            label: const Text("P2P Method",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                            onPressed: () {
                              Get.back();
                              Get.to(() => P2pView());
                            },
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    );
                  },
                  title: 'Withdraw',
                ),

                // CustomWalletButton(
                //   icon: AppIcons.qrCode,
                //   onPressed: () {
                //     Get.to(QrCodeView());
                //   },
                //   title: 'QR',
                // ),
              ],
            ),
            CustomSeeAllRow(
              title: "Your Assets",
              onPressed: () {},
              isSeeAll: false,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.43,
              child: MyAssetsList(),
            ),
          ],
        ),
      ),
    );
  }
}

void showTransferDialog(BuildContext context, FutureController controller) {
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
                  "Transfer to Futures",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Select Coin
              // داخل StatefulBuilder في showTransferDialog

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
                    dropdownColor: Colors.grey[850], // درجة رمادي وسط
                    hint: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'Choose a coin',
                        style: TextStyle(color: Colors.white60, fontSize: 14),
                      ),
                    ),
                    items: controller.availableCoins.value.futuresAvailableCoins!
                        .map((coin) => DropdownMenuItem<FuturesAvailableCoins>(
                      value: coin,
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(coin.icon ?? ''),
                            radius: 14,
                            backgroundColor: Colors.white10,
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                      return controller.availableCoins.value.futuresAvailableCoins!
                          .map((coin) => Row(
                        children: [
                          const SizedBox(width: 10),
                          CircleAvatar(
                            backgroundImage: NetworkImage(coin.icon ?? ''),
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

              // Amount
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

              // Buttons
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
                      final result = await controller.transferFutures(
                        currency: selectedCoin!.id ?? '',
                        amount: parsedAmount,
                      );

                      final message = result["message"]?.toString().toLowerCase() ?? '';

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
