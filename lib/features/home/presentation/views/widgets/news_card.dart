import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../core/components/widgets/circle_loading.dart';
import '../../../../../core/constant/colors.dart';
import '../../../../../core/constant/styles.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.url,
  });

  final String imageUrl, title, description, url;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kCardBackgroundColor,
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: InkWell(
        onTap: () {
          if (url.isNotEmpty) {
            Get.to(() => NewsWebView(url: url));
          }
        },
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: imageUrl.isNotEmpty
                    ? Image.network(
                  imageUrl,
                  width: 80.w,
                  height: 80.h,
                  fit: BoxFit.cover,
                )
                    : Container(
                  width: 80.w,
                  height: 80.h,
                  color: Colors.grey[300],
                  alignment: Alignment.center,
                  child: Icon(Icons.image_not_supported, size: 36.sp, color: Colors.grey[600]),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppStyles.textStyle14semiBold,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      description,
                      style: AppStyles.textStyle12regular.copyWith(color: kHintTextColor),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Text(
                          'Read more'.tr,
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(Icons.open_in_new, size: 16.sp, color: Colors.blueAccent),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  const NewsCard.skeleton({super.key})
      : imageUrl = '',
        title = 'Loading...',
        description = 'Loading...',
        url = '';
}


class NewsWebView extends StatefulWidget {
  final String url;

  const NewsWebView({required this.url, super.key});

  @override
  State<NewsWebView> createState() => _NewsWebViewState();
}

class _NewsWebViewState extends State<NewsWebView> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _isLoading = true),
          onPageFinished: (_) => setState(() => _isLoading = false),
          onWebResourceError: (error) {
            debugPrint("WebView error: ${error.description}");
            setState(() => _isLoading = false);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    final isValidUrl = Uri.tryParse(widget.url)?.hasAbsolutePath ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text('News Detail', style: AppStyles.textStyle16bold),
        backgroundColor: kCardBackgroundColor,
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      body: isValidUrl
          ? Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading) const CircleLoading(),
        ],
      )
          : Center(
        child: Text(
          'Invalid URL: ${widget.url}',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
