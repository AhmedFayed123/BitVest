import 'package:bitvest/features/p2p/presentation/views/widgets/my_ads_screen.dart';
import 'package:bitvest/features/p2p/presentation/views/widgets/p2p_view_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class P2pView extends StatelessWidget {
  const P2pView({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('P2P'),
          actions: [
            IconButton(
              icon: Icon(Icons.ads_click),
              onPressed: () {
                Get.to(() => MyAdsScreen());
              },
            ),
          ],
        ),

        body: P2pViewBody(),
      ),
    );
  }
}
