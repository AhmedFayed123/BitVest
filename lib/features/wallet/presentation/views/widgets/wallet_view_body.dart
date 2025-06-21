import 'package:bitvest/core/constant/icons.dart';
import 'package:bitvest/features/p2p/presentation/views/p2p_view.dart';
import 'package:bitvest/features/wallet/presentation/views/swap_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/components/widgets/see_all_raw.dart';
import '../../../../../core/constant/colors.dart';
import '../../controllers/wallet_controller.dart';
import '../deposit_view.dart';
import '../qr_code_view.dart';
import 'balance_section.dart';
import 'custom_wallet_button.dart';
import 'my_assets_list.dart';

class WalletViewBody extends StatelessWidget {
  const WalletViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final WalletController walletController = Get.put(WalletController());

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
                      backgroundColor: const Color(0xFF121212), // خلفية داكنة جداً
                      radius: 12,
                      content: Column(
                        children: [
                          const SizedBox(height: 10),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              backgroundColor: const Color(0xFF1F8EFA), // أزرق هادي
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            icon: const Icon(Icons.account_balance_wallet_outlined, color: Colors.white),
                            label: const Text("Deposit Method", style: TextStyle(fontSize: 16, color: Colors.white)),
                            onPressed: () {
                              Get.back();
                              Get.to(() => DepositView());
                            },
                          ),
                          const SizedBox(height: 15),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              backgroundColor: const Color(0xFF4CAF50), // أخضر هادي
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            icon: const Icon(Icons.swap_horiz, color: Colors.white),
                            label: const Text("P2P Method", style: TextStyle(fontSize: 16, color: Colors.white)),
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
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            icon: const Icon(Icons.swap_horiz, color: Colors.white),
                            label: const Text("P2P Method", style: TextStyle(fontSize: 16, color: Colors.white)),
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

                CustomWalletButton(
                  icon: AppIcons.swap_horiz,
                  onPressed: () {
                    Get.to(SwapView());
                  },
                  title: 'Swap',
                ),
                CustomWalletButton(
                  icon: AppIcons.qrCode,
                  onPressed: () {
                    Get.to(QrCodeView());
                  },
                  title: 'QR',
                ),
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
