import 'package:flutter/material.dart';
import 'package:flutter_quotes/ui/category_quotes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../api_service/api_service.dart';
import '../../model/QuotesCategoryModel.dart';
import '../../utils/constants.dart';

class QuotesCategoryCard extends StatefulWidget {
  const QuotesCategoryCard(
      {Key? key, required this.data, required this.index, this.selectedIndex})
      : super(key: key);

  final List<QuotesCategoryData> data;
  final int index;
  final int? selectedIndex;

  @override
  State<QuotesCategoryCard> createState() => _QuotesCategoryCardState();
}

class _QuotesCategoryCardState extends State<QuotesCategoryCard> {
  getQuotesById(String categoryId) async {
    var provider = Provider.of<ApiController>(context, listen: false);
    await provider.getQuotesById(categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        getQuotesById(widget.data[widget.index].sId!);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CategoryQuotes(
              title: widget.data[widget.index].title!,
            ),
          ),
        );
      },
      child: Container(
          margin: const EdgeInsets.only(right: 10, left: 2, top: 2, bottom: 2),
          padding:
              const EdgeInsets.only(top: 3, bottom: 3, left: 12, right: 12),
          decoration: BoxDecoration(
              color: cardBgColor,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: greyColor,
                  blurRadius: 1.5,
                  spreadRadius: 1,
                  offset: Offset(-1.0, -0.5),
                ),
              ]),
          child: Row(
            children: [
              Text(
                widget.data[widget.index].title!,
                style: GoogleFonts.lato(
                  color: widget.selectedIndex != null &&
                          widget.index == widget.selectedIndex
                      ? Colors.black
                      : Colors.white,
                  textStyle: Theme.of(context).textTheme.displayLarge,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          )),
    );
  }
}
