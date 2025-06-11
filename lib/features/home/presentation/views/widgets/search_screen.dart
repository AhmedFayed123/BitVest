import 'package:bitvest/core/constant/colors.dart';
import 'package:bitvest/features/home/presentation/controllers/home_controller/home_controller.dart';
import 'package:bitvest/features/trade/presentation/views/coin_details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController searchController = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search'.tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => searchController.search(value),
              decoration: InputDecoration(
                hintText: "Search...".tr,
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                filled: true,
                fillColor: Colors.white12,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                if (searchController.isLoading.value) {
                  return Skeletonizer(
                    enabled: true,
                    child: ListView.separated(
                      itemCount: 10,
                      separatorBuilder: (context, index) =>
                      const Divider(color: Colors.white24),
                      itemBuilder: (context, index) => ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        title: Container(
                          height: 16,
                          width: double.infinity,
                          color: Colors.grey[700],
                        ),
                        subtitle: Container(
                          height: 14,
                          width: 100,
                          color: Colors.grey[600],
                        ),
                        trailing: Container(
                          height: 16,
                          width: 50,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  );
                }

                if (searchController.searchResults.isEmpty) {
                  return Center(
                    child: Text(
                      "No results found".tr,
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: searchController.searchResults.length,
                  separatorBuilder: (context, index) =>
                  const Divider(color: Colors.white24),
                  itemBuilder: (context, index) {
                    final result = searchController.searchResults[index];

                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          result.icon ?? '',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.image_not_supported,
                                color: Colors.white70);
                          },
                        ),
                      ),
                      title: Text(
                        result.name ?? "No Name",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        result.symbol ?? "No Symbol",
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 14),
                      ),
                      trailing: Text(
                        "\$${result.price?.toStringAsFixed(2) ?? '0.00'}",
                        style: const TextStyle(
                            color: kPositiveTrendColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Get.to(CoinDetailsView(coinId: result.id ?? ''));
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
