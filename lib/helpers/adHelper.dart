import 'dart:io';

class AdHelper {
  String get intersAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-7158700897724379/8983383004';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-7158700897724379/9721749601';
    }
    return 'ca-app-pub-7158700897724379/8983383004';
  }

  String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-7158700897724379/3874703853';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-7158700897724379/7047662101';
    }
    return 'ca-app-pub-7158700897724379/3874703853';
  }
}
