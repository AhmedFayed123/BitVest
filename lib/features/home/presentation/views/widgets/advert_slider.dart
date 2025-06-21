import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller/home_controller.dart';
import 'advert_slider_item.dart';

class AdvertSlider extends StatelessWidget {
  const AdvertSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    return Obx(() {
      final ads = homeController.adsList.value ?? [];

      if (homeController.isLoading.value) {
        return SizedBox(
          height: 110.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            separatorBuilder: (_, __) => SizedBox(width: 8.w),
            itemBuilder: (_, __) => Container(
              width: 280.w,
              height: 110.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        );
      }

      if (ads.isEmpty) {
        return Center(
          child: Text(
            "No ads available",
            style: TextStyle(color: Colors.white60, fontSize: 13.sp),
          ),
        );
      }

      return CarouselSlider.builder(
        itemCount: ads.length,
        itemBuilder: (context, index, _) {
          return AdvertSliderItem(
            imageUrl: ads[index].imageUrl ?? '',
            text: ads[index].text ?? '',
          );
        },
        options: CarouselOptions(
          height: 110.h,
          viewportFraction: 0.8,
          enlargeCenterPage: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 4),
        ),
      );
    });
  }
}
