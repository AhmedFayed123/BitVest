import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/components/widgets/circle_loading.dart';
import '../../controllers/home_controller/home_controller.dart';
import 'advert_slider_item.dart';

class AdvertSlider extends StatelessWidget {
  const AdvertSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: Obx(() {
        if (homeController.isLoading.value) {
          return const CircleLoading();
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
            height: 91.h,
            viewportFraction: .9,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
        );
      }),
    );
  }
}
