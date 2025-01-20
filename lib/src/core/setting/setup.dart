import 'dart:developer';

import 'package:flutter/material.dart';
import '../storage/app_storage.dart';

String? language;
String? accessToken;

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Read initial local data
  accessToken = await AppStorage.$read(key: StorageKey.accessToken);
  language = await AppStorage.$read(key: StorageKey.language);

  log("Setup complete");
  log("AccessToken: $accessToken");
  log("Language: $language");
}
