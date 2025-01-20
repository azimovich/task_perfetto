import 'package:flutter/foundation.dart';

import '../../../core/setting/setup.dart';

class ChooseLanguagePageVm extends ChangeNotifier {
  String languageCode = language ?? 'uz';

  void changeLanguage(String value) {
    languageCode = value;
    notifyListeners();
  }
}
