import 'package:bitvest/core/components/widgets/circle_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: imageUrl.isNotEmpty
                  ? Image.network(imageUrl, width: 80.w, height: 80.h, fit: BoxFit.cover)
                  : Icon(Icons.image, size: 80.w),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppStyles.textStyle16regular,
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
                  SizedBox(height: 5.h),
                  GestureDetector(
                    onTap: () {
                      if (url.isNotEmpty) {
                        Get.to(() => NewsWebView(url: url));
                      }
                    },
                    child: Text(
                      'Read more',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class NewsWebView extends StatefulWidget {
  final String url;

  const NewsWebView({required this.url, super.key});

  @override
  _NewsWebViewState createState() => _NewsWebViewState();
}

class _NewsWebViewState extends State<NewsWebView> {
  late final WebViewController _controller;
  bool _isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() => _isLoading = true); // Show loader
          },
          onPageFinished: (String url) {
            setState(() => _isLoading = false); // Hide loader
          },
          onWebResourceError: (WebResourceError error) {
            setState(() => _isLoading = false); // Hide loader on error
            debugPrint("WebView error: ${error.description}");
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url)); // Load the initial URL
  }

  @override
  Widget build(BuildContext context) {
    bool isValidUrl = Uri.tryParse(widget.url)?.hasAbsolutePath ?? false;

    // Show invalid URL message if URL is not valid
    if (!isValidUrl) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('News Detail'),
        ),
        body: Center(
          child: Text('Invalid URL: ${widget.url}'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('News Detail'),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller), // Use WebViewWidget
          if (_isLoading) // Show loader while loading
            const CircleLoading(),
        ],
      ),
    );
  }
}




