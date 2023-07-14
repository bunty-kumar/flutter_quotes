import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quotes/ui/splash_screen.dart';
import 'package:flutter_quotes/utils/constants.dart';
import 'package:provider/provider.dart';
import 'api_service/api_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    // navigation bar color
    statusBarColor: statusBarColor,
    statusBarBrightness: Brightness.dark,
    //status bar brightness
    statusBarIconBrightness: Brightness.light,
    //status barIcon Brightness
    systemNavigationBarDividerColor: statusBarColor,
    //Navigation bar divider color
    // systemNavigationBarIconBrightness: Brightness.light, //navigation bar icon
  ));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ApiController(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quotes App',
      debugShowCheckedModeBanner: false,
      theme: Themes.defaultTheme,
      home: const SplashScreen(),
    );
  }
}
