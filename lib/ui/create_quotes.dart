import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quotes/ui/widgets/show_Animation.dart';
import 'package:flutter_quotes/ui/widgets/title_widget.dart';
import 'package:flutter_quotes/utils/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../api_service/api_service.dart';
import '../model/QuotesCategoryModel.dart';

class CreateQuotesScreen extends StatefulWidget {
  final List<QuotesCategoryData> quotesCategoryList;

  const CreateQuotesScreen({Key? key, required this.quotesCategoryList})
      : super(key: key);

  @override
  State<CreateQuotesScreen> createState() => _CreateQuotesScreenState();
}

class _CreateQuotesScreenState extends State<CreateQuotesScreen> {
  final ValueNotifier<String?> _selectedStudent = ValueNotifier<String?>(null);
  TextEditingController quotesController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  callApi() async {
    var provider = Provider.of<ApiController>(context, listen: false);
    await provider.getAllQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const ShowAnimation(
            delay: 200,
            direction: Direction.down,
            child: Text("Create Quotes")),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(CupertinoIcons.back),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            gd1,
            gd2,
          ],
        )),
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: ShowAnimation(
            delay: 100,
            direction: Direction.right,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleWidget(text: "Select Category"),
                const SizedBox(
                  height: 5,
                ),
                ValueListenableBuilder<String?>(
                  valueListenable: _selectedStudent,
                  builder:
                      (BuildContext context, String? value, Widget? child) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            value: value,
                            isExpanded: true,
                            hint: const Text(
                              "Select Category",
                              style: TextStyle(
                                color: Colors.white,
                                // fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.0,
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.0,
                            ),
                            onChanged: (value) async {
                              _selectedStudent.value = value!;
                              log("selected value :$value");
                            },
                            items: widget.quotesCategoryList.map(
                              (item) {
                                return DropdownMenuItem(
                                  value: item.sId,
                                  child: Text(item.title!),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                const TitleWidget(text: "Add Author"),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: authorController,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: "Add Author",
                    hintStyle: const TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1, color: Colors.white), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1, color: Colors.red), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1, color: Colors.grey), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const TitleWidget(text: "Add Image Url"),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: imageController,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: "Add Url",
                    hintStyle: const TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1, color: Colors.white), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1, color: Colors.red), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1, color: Colors.grey), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const TitleWidget(text: "Add Quotes"),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: quotesController,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: 3,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: "Add Quotes",
                    hintStyle: const TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1, color: Colors.white), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1, color: Colors.red), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1, color: Colors.grey), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Consumer<ApiController>(
                  builder: (context, authController, _) {
                    return authController.addQuotesLoader
                        ? SpinKitThreeBounce(
                            itemBuilder: (BuildContext context, int index) {
                              return DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color:
                                      index.isEven ? Colors.white : Colors.grey,
                                ),
                              );
                            },
                          )
                        : SizedBox(
                            height: 45,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_selectedStudent.value == null) {
                                  showSnackBar(
                                      context, "Please select a category");
                                  return;
                                }
                                if (quotesController.text.trim().isEmpty) {
                                  showSnackBar(
                                      context, "Please add some quotes");
                                  return;
                                }
                                var pData = {
                                  "categoryId": _selectedStudent.value,
                                  "title": quotesController.text.trim(),
                                  "imageUrl": imageController.text.trim(),
                                  "authorName": authorController.text.trim(),
                                };
                                var bool = await authController
                                    .addQuotesCategory(pData, context);
                                if (bool) {
                                  _selectedStudent.value = null;
                                  quotesController.clear();
                                  authorController.clear();
                                  imageController.clear();
                                  callApi();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: bgColor // foreground
                                  ),
                              child: const Text(
                                "SUBMIT",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
