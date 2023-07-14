import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quotes/ui/HomeScreen.dart';
import 'package:flutter_quotes/utils/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../api_service/api_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    callApi();
    openScreens();
  }

  openScreens() {
    Future.delayed(const Duration(milliseconds: 1500), () async {
      Navigator.pushAndRemoveUntil(
        (context),
        CupertinoPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        (route) => false,
      );
    });
  }

  callApi() async {
    var provider = Provider.of<ApiController>(context, listen: false);
    await provider.getQuotesCategory();
    await provider.getAllQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              gd1,
              gd2,
            ],
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Icon(
                  CupertinoIcons.quote_bubble_fill,
                  size: 100,
                  color: Colors.white70,
                ),
              ),
              /*Center(
                child: Image.asset(
                  appLogo,
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                  color: Colors.grey,
                ),
              ),*/
              const SizedBox(
                height: 12,
              ),
              Text(
                "Quotify",
                style: GoogleFonts.lato(
                  color: Colors.white70,
                  textStyle: Theme.of(context).textTheme.displayLarge,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
