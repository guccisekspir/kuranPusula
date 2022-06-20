import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kuranpusula/helpers/adHelper.dart';

part 'admob_event.dart';
part 'admob_state.dart';

class AdmobBloc extends Bloc<AdmobEvent, AdmobState> {
  InterstitialAd? _interstitialAd;
  AdHelper adHelper = AdHelper();
  AdmobBloc() : super(AdmobInitial()) {
    on<AdmobEvent>((event, emit) {
      if (event is LoadIntersAd) {
        InterstitialAd.load(
            adUnitId: adHelper.intersAdUnitId,
            request: AdRequest(keywords: ["kuran", "islam", "eid", "quran", "muslim"]),
            adLoadCallback: InterstitialAdLoadCallback(
              onAdLoaded: (InterstitialAd ad) {
                // Keep a reference to the ad so you can show it later.
                _interstitialAd = ad;
                ad.fullScreenContentCallback = FullScreenContentCallback(
                  onAdShowedFullScreenContent: (InterstitialAd ad) => print('%ad onAdShowedFullScreenContent.'),
                  onAdDismissedFullScreenContent: (InterstitialAd ad) {
                    print('$ad onAdDismissedFullScreenContent.');
                    ad.dispose();
                  },
                  onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
                    print('$ad onAdFailedToShowFullScreenContent: $error');
                    ad.dispose();
                  },
                  onAdImpression: (InterstitialAd ad) => print('$ad impression occurred.'),
                );
              },
              onAdFailedToLoad: (LoadAdError error) {
                print('InterstitialAd failed to load: $error');
              },
            ));
      } else if (event is ShowIntersAd) {
        if (_interstitialAd != null) {
          print("inters null değil show dendi");

          _interstitialAd!.show();
          _interstitialAd = null;
          add(LoadIntersAd(DateTime.now()));
        } else {
          print("inters null show dendi");
          InterstitialAd.load(
              adUnitId: adHelper.intersAdUnitId,
              request: AdRequest(keywords: ["bitcoin", "binance", "crypto", "etherium"]),
              adLoadCallback: InterstitialAdLoadCallback(
                onAdLoaded: (InterstitialAd ad) {
                  // Keep a reference to the ad so you can show it later.
                  ad.show();
                  add(LoadIntersAd(DateTime.now()));
                  ad.fullScreenContentCallback = FullScreenContentCallback(
                    onAdShowedFullScreenContent: (InterstitialAd ad) => print('%ad onAdShowedFullScreenContent.'),
                    onAdDismissedFullScreenContent: (InterstitialAd ad) {
                      print('$ad onAdDismissedFullScreenContent.');
                      ad.dispose();
                    },
                    onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
                      print('$ad onAdFailedToShowFullScreenContent: $error');
                      ad.dispose();
                    },
                    onAdImpression: (InterstitialAd ad) => print('$ad impression occurred.'),
                  );
                },
                onAdFailedToLoad: (LoadAdError error) {
                  print('InterstitialAd failed to load: $error');
                },
              ));
        }
      }
    });
  }
}
