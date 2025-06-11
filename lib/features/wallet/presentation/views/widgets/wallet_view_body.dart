import 'package:bitvest/core/constant/icons.dart';
import 'package:bitvest/features/p2p/presentation/views/p2p_view.dart';
import 'package:bitvest/features/wallet/presentation/views/swap_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                    Get.to(DepositView());
                  },
                  title: 'Deposit',
                ),
                CustomWalletButton(
                  icon: AppIcons.arrow_circle_down,
                  onPressed: () {
                    Get.to(P2pView());
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
            SizedBox(height: 16.h),
            CustomSeeAllRow(
              title: "Your Assets",
              onPressed: () {},
              isSeeAll: false,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.48,
              child: MyAssetsList(),
            ),
          ],
        ),
      ),
    );
  }
}
