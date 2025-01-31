import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CryptoTicker extends StatelessWidget {
  final List<Map<String, String>> cryptoList = [
    {"rank": "#5", "symbol": "MOKL", "change": "+15.9%", "color": "green"},
    {"rank": "#6", "symbol": "ASTRE", "change": "-52.99%", "color": "red"},
    {"rank": "#7", "symbol": "NOT", "change": "+6.69%", "color": "green"},
    {"rank": "#8", "symbol": "TON", "change": "-0.2%", "color": "red"},
    {"rank": "#9", "symbol": "APHBT", "change": "-13.3%", "color": "red"},
    {"rank": "#10", "symbol": "FWT", "change": "-31.7%", "color": "red"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      width: double.infinity,
      color: Colors.black, // لون الخلفية
      child: Marquee(
        text: cryptoList.map((crypto) {
          return "${crypto['rank']} ${crypto['symbol']} "
              "${crypto['change']} ";
        }).join("  •  "), // فصل كل عنصر بـ "•"
        style: TextStyle(fontSize: 16.sp, color: Colors.white),
        scrollAxis: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        blankSpace: 50.0.w,
        velocity: 30.0,
        pauseAfterRound: Duration(seconds: 1),
        startPadding: 10.0,
        accelerationDuration: Duration(seconds: 1),
        accelerationCurve: Curves.linear,
        decelerationDuration: Duration(milliseconds: 500),
        decelerationCurve: Curves.easeOut,
      ),
    );
  }
}
