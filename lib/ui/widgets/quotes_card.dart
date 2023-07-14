import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quotes/ui/quotes_full_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/QuotesModel.dart';
import '../../utils/constants.dart';

class QuotesCard extends StatefulWidget {
  const QuotesCard({Key? key, required this.data, required this.index})
      : super(key: key);

  final List<QuotesData> data;
  final int index;

  @override
  State<QuotesCard> createState() => _QuotesCardState();
}

class _QuotesCardState extends State<QuotesCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => QuotesFullScreen(
              data: widget.data,
              index: widget.index,
            ),
          ),
        );
      },
      child: Hero(
        tag: widget.data[widget.index].sId!,
        child: Container(
          margin:
              const EdgeInsets.only(left: 16, bottom: 12, right: 16, top: 12),
          padding:
              const EdgeInsets.only(left: 25, bottom: 25, top: 25, right: 25),
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
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Icon(
                  CupertinoIcons.quote_bubble,
                  size: 20,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Material(
                color: Colors.transparent,
                child: Text(
                  "${widget.data[widget.index].title}",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.mukta(
                    textStyle: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Material(
                color: Colors.transparent,
                child: Text(
                  widget.data[widget.index].authorName!.isEmpty
                      ? "~do_alfaz"
                      : "~${widget.data[widget.index].authorName}",
                  style: GoogleFonts.mukta(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
