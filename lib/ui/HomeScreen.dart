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

  TextEditingController searchController = TextEditingController();

  List<QuotesCategoryData> quotesCategoryList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        centerTitle: true,
        title: const ShowAnimation(
            delay: 200, direction: Direction.down, child: Text("Quotify")),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CreateQuotesScreen(
                      quotesCategoryList: quotesCategoryList)));
            },
            child: Container(
              margin: const EdgeInsets.only(right: 16, left: 16),
              child: const Icon(Icons.lightbulb_sharp),
            ),
          )
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
              Expanded(
                child: Consumer<ApiController>(
                  builder: (context, apiData, _) {
                    if (apiData.quotesCategoryModel != null) {
                      quotesCategoryList = apiData.quotesCategoryModel!.data!;
                    }
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
                                text: "No data found",
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
