import 'package:bitvest/features/home/presentation/views/widgets/tab_bar_section.dart';
import 'package:bitvest/features/home/presentation/views/widgets/total_balance_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/components/widgets/see_all_raw.dart';
import 'advert_slider.dart';
import 'crypto_card_list.dart';
import 'crypto_ticker.dart';
import 'home_app_bar.dart';
import 'news_list.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({
    super.key,
    required this.scaffoldKey,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(58.0.h),
        child: HomeAppBar(scaffoldKey: scaffoldKey),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TotalBalanceContainer(),
            AdvertSlider(),
            CustomSeeAllRow(
              title: "most popular",
              onPressed: () {},
              isSeeAll: true,
            ),
            CryptoCardList(),
            SizedBox(
              height: 5.h,
            ),
            CryptoTicker(),
            const TabBarSection(),
            CustomSeeAllRow(
              title: "News",
              onPressed: () {},
              isSeeAll: true,
            ),
            NewsList(),
          ],
        ),
      ),
    );
  }
}
