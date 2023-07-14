import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/QuotesCategoryModel.dart';

class QuotesCategoryCard extends StatefulWidget {
  const QuotesCategoryCard({Key? key,
    required this.data,
    required this.index,
    this.selectedIndex})
      : super(key: key);

  final List<QuotesCategoryData> data;
  final int index;
  final int? selectedIndex;

  @override
  State<QuotesCategoryCard> createState() => _QuotesCategoryCardState();
}

class _QuotesCategoryCardState extends State<QuotesCategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.only(top: 5, bottom: 5, left: 8, right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.0),
          color: widget.selectedIndex != null && widget.index ==
              widget.selectedIndex
              ? Colors.white
              : Colors.grey,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(1.0, 1.0), //(x,y)
              blurRadius: 1.0,
            ),
          ],
        ),
        child: Row(
          children: [
            Text(
              widget.data[widget.index].title!,
              style: GoogleFonts.lato(
                color: widget.selectedIndex != null && widget.index ==
                    widget.selectedIndex
                    ? Colors.black
                    : Colors.white,
                textStyle: Theme
                    .of(context)
                    .textTheme
                    .displayLarge,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ));
  }
}
