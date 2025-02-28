import 'package:bitvest/core/components/widgets/circle_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdvertSliderItem extends StatelessWidget {
  final String imageUrl;
  final String text;

  const AdvertSliderItem({super.key, required this.imageUrl, required this.text});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            width: 358.w,
            height: 171.h,
            fit: BoxFit.fill,
            placeholder: (context, url) => const CircleLoading(),
            errorWidget: (context, url, error) => Container(
              width: 358.w,
              height: 171.h,
              color: Colors.grey[300],
              alignment: Alignment.center,
              child: const Text(
                'Image not available',
                style: TextStyle(color: Colors.black54),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.r)),
              ),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
