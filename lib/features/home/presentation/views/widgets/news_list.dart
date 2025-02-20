import 'package:flutter/material.dart';

import 'news_card.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> news = [
      {
        "image": "https://www.openaccessgovernment.org/wp-content/uploads/2018/02/what-is-bitcoin-cryptocurrency-001.jpg",
        "title": "Bitcoin Hits New High",
        "description": "Bitcoin price surged to an all-time high, reaching \$75,000."
      },
      {
        "image": "https://www.investopedia.com/thmb/YJBXk5A8fN78NMdeCk0IJKGNRuw=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/GettyImages-453930217-42848c04ff58410d952e1a5b65a00929.jpg",
        "title": "Ethereum Upgrade Complete",
        "description": "The Ethereum 2.0 update has been successfully deployed."
      },
      {
        "image": "https://www.bankrate.com/2022/07/07151503/Cryptocurrency-statistics.jpeg?auto=webp&optimize=high&crop=16:9&width=912",
        "title": "Crypto Market Volatility",
        "description": "Cryptocurrency market sees significant ups and downs this week."
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: news.length,
      itemBuilder: (context, index) {
        return NewsCard(
          imageUrl: news[index]["image"]!,
          title: news[index]["title"]!,
          description: news[index]["description"]!,
        );
      },
    );
  }
}
// class NewsList extends StatelessWidget {
//   const NewsList({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final HomeController newsController = Get.put(HomeController());
//
//     return Obx(() {
//       if (newsController.isLoading.value) {
//         return CircleLoading();
//       }
//
//       if (newsController.errorMessage.value.isNotEmpty) {
//         return Center(
//           child: Text(
//             newsController.errorMessage.value,
//             style: TextStyle(color: Colors.red, fontSize: 16),
//           ),
//         );
//       }
//
//       // في حال كانت البيانات موجودة
//       final news = newsController.news.value?.data ?? [];
//
//       return ListView.builder(
//         shrinkWrap: true,
//         physics: NeverScrollableScrollPhysics(),
//         itemCount: news.length,
//         itemBuilder: (context, index) {
//           final newsItem = news[index];
//           return NewsCard(
//             imageUrl: newsItem.imageurl ?? '',
//             title: newsItem.title ?? 'No Title',
//             description: newsItem.body ?? 'No description available',
//             url: newsItem.url ?? '',
//           );
//         },
//       );
//     });
//   }
// }
