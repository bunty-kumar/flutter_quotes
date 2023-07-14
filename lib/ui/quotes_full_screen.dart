import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quotes/ui/widgets/show_Animation.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../model/QuotesModel.dart';
import '../utils/constants.dart';

class QuotesFullScreen extends StatefulWidget {
  const QuotesFullScreen({Key? key, required this.index, required this.data})
      : super(key: key);
  final List<QuotesData> data;
  final int index;

  @override
  State<QuotesFullScreen> createState() => _QuotesFullScreenState();
}

class _QuotesFullScreenState extends State<QuotesFullScreen> {
  final ScreenshotController _screenshotController = ScreenshotController();
  late int currentIndex;

  int delayAmount = 300;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
  }

  void goToPreviousImage() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
      }
    });
  }

  void goToNextImage() {
    setState(() {
      if (currentIndex < widget.data.length - 1) {
        currentIndex++;
      }
    });
  }

  void handleSwipe(DragEndDetails details) {
    if (details.primaryVelocity! > 0) {
      // Swiped right
      goToPreviousImage();
    } else if (details.primaryVelocity! < 0) {
      // Swiped left
      goToNextImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    var data = widget.data;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const ShowAnimation(
            direction: Direction.down, delay: 200, child: Text("Quotify")),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(CupertinoIcons.back),
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onHorizontalDragEnd: handleSwipe,
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
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: data[currentIndex].sId!,
                        child: SingleChildScrollView(
                          child: Screenshot(
                            controller: _screenshotController,
                            child: Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(25),
                              padding: const EdgeInsets.only(
                                  top: 50, bottom: 8, left: 25, right: 25),
                              decoration: BoxDecoration(
                                  color: cardBgColor,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: const <BoxShadow>[
                                    BoxShadow(
                                      color: greyColor,
                                      blurRadius: 5.5,
                                      spreadRadius: 2,
                                      offset: Offset(-1.0, -0.5),
                                    ),
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: ShowAnimation(
                                        direction: Direction.up,
                                        delay: delayAmount,
                                        child: const Icon(
                                            CupertinoIcons.quote_bubble)),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    child: ShowAnimation(
                                      direction: Direction.up,
                                      delay: delayAmount,
                                      child: Text(
                                        "${data[currentIndex].title}",
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.mukta(
                                          textStyle: const TextStyle(
                                            fontSize: 22,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    child: ShowAnimation(
                                      direction: Direction.up,
                                      delay: delayAmount,
                                      child: Text(
                                        data[currentIndex].authorName!.isEmpty
                                            ? "~do_alfaz"
                                            : "~${data[currentIndex].authorName}",
                                        style: GoogleFonts.mukta(
                                          textStyle: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 0),
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 25, right: 25),
                  decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: cardBgColor,
                          blurRadius: 0.5,
                          spreadRadius: 0.5,
                          offset: Offset(0.0, 0.0),
                        ),
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: goToPreviousImage,
                          child: const BottomWidget(
                              icon: Icons.arrow_back_ios, text: "")),
                      InkWell(
                          onTap: () {
                            Clipboard.setData(ClipboardData(
                                    text: data[currentIndex].title!))
                                .then((_) {
                              showSnackBar(context, "copied to clipboard");
                            });
                          },
                          child: const BottomWidget(
                              icon: Icons.copy, text: "Copy")),
                      InkWell(
                          onTap: () {
                            saveButtonClicked();
                          },
                          child: const BottomWidget(
                              icon: Icons.save, text: "Save")),
                      InkWell(
                          onTap: () {
                            shareButtonClicked();
                          },
                          child: Ink(
                            child: const BottomWidget(
                                icon: Icons.share, text: "Share"),
                          )),
                      InkWell(
                          onTap: goToNextImage,
                          child: const BottomWidget(
                              icon: Icons.arrow_forward_ios, text: "")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> shareButtonClicked() async {
    _screenshotController.capture().then((Uint8List? image) async {
      if (image != null) {
        String dir = (await getTemporaryDirectory()).path;
        File file = File("$dir/${DateTime.now().millisecondsSinceEpoch}.png");
        await file.writeAsBytes(image);
        XFile xFile = XFile(file.path);
        Share.shareXFiles([xFile], text: 'Shared from Quotify');
      }
    }).catchError((onError) {
      log(onError.toString());
    });
  }

  void saveButtonClicked() {
    _screenshotController.capture().then((Uint8List? image) async {
      if (image != null) {
        String dir = (await getTemporaryDirectory()).path;
        File file = File("$dir/${DateTime.now().millisecondsSinceEpoch}.png");
        await file.writeAsBytes(image);
        await GallerySaver.saveImage(file.path);
        showSnackBar(context, "Image saved to galley");
      }
    }).catchError((onError) {
      log(onError);
    });
  }
}

class BottomWidget extends StatelessWidget {
  const BottomWidget({Key? key, required this.icon, required this.text})
      : super(key: key);
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        const SizedBox(
          height: 5,
        ),
        text.isNotEmpty
            ? Text(
                text,
                textAlign: TextAlign.left,
                style: GoogleFonts.mukta(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
