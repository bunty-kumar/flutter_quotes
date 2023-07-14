import 'package:flutter/material.dart';
import 'package:flutter_quotes/ui/widgets/loader_widget.dart';
import 'package:flutter_quotes/ui/widgets/no_data_found.dart';
import 'package:flutter_quotes/ui/widgets/quote_category_card.dart';
import 'package:flutter_quotes/ui/widgets/quotes_card.dart';
import 'package:flutter_quotes/ui/widgets/show_Animation.dart';
import 'package:provider/provider.dart';

import '../api_service/api_service.dart';
import '../utils/constants.dart';
import 'create_quotes.dart';

class CategoryQuotes extends StatefulWidget {
  final String title;

  const CategoryQuotes({Key? key, required this.title}) : super(key: key);

  @override
  State<CategoryQuotes> createState() => _CategoryQuotesState();
}

class _CategoryQuotesState extends State<CategoryQuotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        centerTitle: true,
        title: ShowAnimation(
            delay: 200, direction: Direction.right, child: Text(widget.title)),
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
                    return apiData.getQuotesIdLoader
                        ? const LoaderWidget()
                        : apiData.quotesByIDModel?.data != null &&
                                apiData.quotesByIDModel!.data!.isNotEmpty
                            ? ShowAnimation(
                                delay: 200,
                                direction: Direction.down,
                                child: ListView.builder(
                                  itemCount:
                                      apiData.quotesByIDModel!.data!.length,
                                  itemBuilder: (context, index) {
                                    var data = apiData.quotesByIDModel!.data!;
                                    return QuotesCard(
                                      data: data,
                                      index: index,
                                    );
                                  },
                                ),
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
