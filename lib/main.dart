import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';
import 'base/base_state.dart';

// Import the generated file
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Consumer(
        builder: (context, watch, _) {
          return EasyLocalization(
            supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
            path: 'assets/translations',
            startLocale: const Locale('en', 'US'),
            fallbackLocale: const Locale('en', 'US'),
            child: App(),
          );
        },
      ),
    );
  }
}
