import 'package:dhan_saarthi/core/storage/preference_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/utils/app_loader.dart';
import 'core/utils/app_utils.dart';
import 'features/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializingInitials();

  final isLoggedIn = await PreferenceStorage.getLoginStatus();

  // Delay to ensure App is fully initialized
  Future.delayed(const Duration(milliseconds: 500),
      () => runApp(MyApp(isLoggedIn: isLoggedIn)));
}

/// Initializes the app with necessary configurations and settings.
Future<void> initializingInitials() async {
  await Loader.instance.init();
  await GetStorage.init();

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );

  orientations();
}
