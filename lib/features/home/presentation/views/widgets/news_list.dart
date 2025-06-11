import 'package:bitvest/core/constant/colors.dart';
import 'package:bitvest/core/constant/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller/home_controller.dart';
import 'news_card.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController newsController = Get.put(HomeController());
    final RxBool isExpanded = false.obs;

    return Obx(() {
      if (newsController.isLoading.value) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) => const NewsCard.skeleton(),
        );
      }

      final newsData = newsController.news.value?.news?.data ?? [];

      if (newsData.isEmpty) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) => const NewsCard.skeleton(),
        );
      }

      int displayedItemCount = isExpanded.value ? newsData.length : 3;

      return Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: displayedItemCount,
            itemBuilder: (context, index) {
              final newsItem = newsData[index];
              return NewsCard(
                imageUrl: newsItem.imageurl ?? '',
                title: newsItem.title ?? 'No Title',
                description: newsItem.body ?? 'No description available',
                url: newsItem.url ?? '',
              );
            },
          ),
          if (newsData.length > 3)
            TextButton(
              onPressed: () => isExpanded.value = !isExpanded.value,
              child: Text(
                isExpanded.value ? 'showLess'.tr : 'showMore'.tr,
                style:
                    AppStyles.textStyle14semiBold.copyWith(color: kAmberColor),
              ),
            ),
        ],
      );
    });
  }
}
