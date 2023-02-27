import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../helper/ad_helper.dart';

class MyBannerAd extends StatefulWidget {
  const MyBannerAd({Key? key}) : super(key: key);

  @override
  State<MyBannerAd> createState() => _MyBannerAdState();
}

class _MyBannerAdState extends State<MyBannerAd> {
  late BannerAd _bannerAd;

  bool _isBannerAdReady = false;
  void createBottomBannerAd() async {
    _bannerAd = BannerAd(
      // Change Banner Size According to Ur Need
      size: AdSize.banner,
      adUnitId: BannerAd.testAdUnitId, request: const AdRequest(),

      listener: BannerAdListener(onAdLoaded: (_) {
        setState(() {
          _isBannerAdReady = true;
        });
      }, onAdFailedToLoad: (ad, LoadAdError error) {
        // ignore: avoid_print
        print("Failed to Load A Banner Ad${error.message}");
        // _isBannerAdReady = false;
        ad.dispose();
      }),
    );
    _bannerAd.load();
  }

  @override
  void initState() {
    super.initState();
    createBottomBannerAd();

    // _bannerAd = BannerAd(
    //     // Change Banner Size According to Ur Need
    //     size: AdSize.banner,
    //     adUnitId: AdHelper.bannerAdUnitId,

    //     listener: BannerAdListener(onAdLoaded: (_) {
    //       setState(() {
    //         _isBannerAdReady = true;
    //       });
    //     }, onAdFailedToLoad: (ad, LoadAdError error) {
    //       // ignore: avoid_print
    //       print("Failed to Load A Banner Ad${error.message}");
    //       _isBannerAdReady = false;
    //       ad.dispose();
    //     }),
    //     request: const AdRequest())
    //   ..load();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          color: Colors.red,
        ),
        const SizedBox(height: 20),
        //Simple Container
        Container(
          height: 70,
          color: Colors.indigo,
        ),
        const SizedBox(height: 20),
        if (_isBannerAdReady)
          Container(
            height: _bannerAd.size.height.toDouble(),
            width: _bannerAd.size.width.toDouble(),
            child: AdWidget(ad: _bannerAd),
          ),
        const SizedBox(height: 20),
        Container(
          height: 70,
          color: Colors.deepOrange,
        ),
        const SizedBox(height: 20),
        Container(
          height: 70,
          color: Colors.purple,
        ),
      ],
    );
  }
}
