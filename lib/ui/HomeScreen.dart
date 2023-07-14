import 'package:flutter/material.dart';
import 'package:flutter_quotes/model/QuotesCategoryModel.dart';
import 'package:flutter_quotes/ui/create_quotes.dart';
import 'package:flutter_quotes/ui/widgets/loader_widget.dart';
import 'package:flutter_quotes/ui/widgets/no_data_found.dart';
import 'package:flutter_quotes/ui/widgets/quote_category_card.dart';
import 'package:flutter_quotes/ui/widgets/quotes_card.dart';
import 'package:flutter_quotes/ui/widgets/show_Animation.dart';
import 'package:flutter_quotes/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../api_service/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    // callApi();
  }

  callApi() async {
    var provider = Provider.of<ApiController>(context, listen: false);
    await provider.getQuotesCategory();
    await provider.getAllQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        centerTitle: true,
        title: const ShowAnimation(
            delay: 200, direction: Direction.down, child: Text("Quotify")),
        actions: [
          Consumer<ApiController>(
            builder: (context, apiData, _) {
              return apiData.getCategoryLoader
                  ? const SizedBox()
                  : apiData.quotesCategoryModel?.data != null &&
                          apiData.quotesCategoryModel!.data!.isNotEmpty
                      ? InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CreateQuotesScreen(
                                    quotesCategoryList:
                                        apiData.quotesCategoryModel!.data!)));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 16, left: 16),
                            child: const Icon(Icons.lightbulb_sharp),
                          ),
                        )
                      : const SizedBox();
            },
          ),
        ],
      ),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<ApiController>(
                builder: (context, apiData, _) {
                  return apiData.getCategoryLoader
                      ? const SizedBox()
                      : apiData.quotesCategoryModel?.data != null &&
                              apiData.quotesCategoryModel!.data!.isNotEmpty
                          ? Container(
                              margin: const EdgeInsets.only(
                                  top: 12, left: 12, right: 12, bottom: 8),
                              height: 40,
                              child: ListView.builder(
                                itemCount:
                                    apiData.quotesCategoryModel!.data!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  var data = apiData.quotesCategoryModel!.data!;
                                  return QuotesCategoryCard(
                                    data: data,
                                    index: index,
                                  );
                                },
                              ),
                            )
                          : const SizedBox();
                },
              ),
              Expanded(
                child: Consumer<ApiController>(
                  builder: (context, apiData, _) {
                    return apiData.getQuotesLoader
                        ? const LoaderWidget()
                        : apiData.quotesModel?.data != null &&
                                apiData.quotesModel!.data!.isNotEmpty
                            ? ListView.builder(
                                itemCount: apiData.quotesModel!.data!.length,
                                itemBuilder: (context, index) {
                                  var data = apiData.quotesModel!.data!;
                                  return QuotesCard(
                                    data: data,
                                    index: index,
                                  );
                                },
                              )
                            : const NoDataFound(
                                text: "No Quotes found",
                              );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
