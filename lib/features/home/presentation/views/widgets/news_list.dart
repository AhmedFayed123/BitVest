import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/components/widgets/circle_loading.dart';
import '../../controllers/home_controller/home_controller.dart';
import 'news_card.dart';


class NewsList extends StatelessWidget {
  const NewsList({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController newsController = Get.put(HomeController());

    return Obx(() {
      if (newsController.isLoading.value) {
        return const CircleLoading();
      }


      final newsData = newsController.news.value?.news?.data ?? [];

      if (newsData.isEmpty) {
        return const Center(
          child: Text("No News Available", style: TextStyle(color: Colors.white)),
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: newsData.length,
        itemBuilder: (context, index) {
          final newsItem = newsData[index];
          return NewsCard(
            imageUrl: newsItem.imageurl ?? '',
            title: newsItem.title ?? 'No Title',
            description: newsItem.body ?? 'No description available',
            url: newsItem.url ?? '',
          );
        },
      );
    });
  }
}










