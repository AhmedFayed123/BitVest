import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'advert_slider_item.dart';

class AdvertSlider extends StatelessWidget {
  const AdvertSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0.h,bottom: 10.h),
      child: CarouselSlider.builder(
                itemCount: 10,
                itemBuilder: (context, index, realIndex) {
                  return AdvertSliderItem(
                    imageUrl: 'https://cdn.i.haymarketmedia.asia/?n=campaign-asia%2fcontent%2fBitcoin.jpg&h=570&w=855&q=100&v=20170226&c=1',
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
              ),
    );
  }

}
