import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../controllers/home_controller/home_controller.dart';
import 'advert_slider_item.dart';

class AdvertSlider extends StatelessWidget {
  const AdvertSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    return Obx(() {
      if (homeController.isLoading.value) {
        return Skeletonizer(
          enabled: true,
          child: SizedBox(
            height: 150.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  width: 300.w,
                  height: 150.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                );
              },
            ),
          ),
        );
      }

      final ads = homeController.adsList.value ?? [];

      if (ads.isEmpty) {
        return const Center(
          child: Text("No ads available",
              style: TextStyle(color: Colors.white)),
        );
      }

      return CarouselSlider.builder(
        itemCount: ads.length,
        itemBuilder: (context, index, realIndex) {
          return AdvertSliderItem(
            imageUrl: ads[index].imageUrl ?? '',
            text: ads[index].text ?? '',
          );
        },
        options: CarouselOptions(
          height: 150.h,
          viewportFraction: .9,
          enableInfiniteScroll: true,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
      );
    });
  }
}
