import 'package:bitvest/core/components/widgets/circle_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdvertSliderItem extends StatelessWidget {
  final String imageUrl;

  const AdvertSliderItem({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: 358.w,
        height: 171.h,
        fit: BoxFit.fill,
        placeholder: (context, url) {
          return const CircleLoading();
        },
        errorWidget: (context, url, error) {
          return const Center(child: Text('Image not available'));
        },
      ),
    );
  }
}
