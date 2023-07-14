import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../api_service/api_service.dart';
import '../../utils/constants.dart';

class QuoteOfTheDay extends StatelessWidget {
  const QuoteOfTheDay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ApiController>(
      builder: (context, apiData, _) {
        return apiData.getCategoryLoader
            ? Shimmer.fromColors(
                baseColor: mediumGreyColor,
                highlightColor: lightGreyColor,
                child: Container(
                  color: Colors.grey,
                  height: 250,
                  width: double.infinity,
                ),
              )
            : apiData.quotesOfDayModel?.data != null &&
                    apiData.quotesOfDayModel!.data!.isNotEmpty
                ? Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(0),
                            topLeft: Radius.circular(0)),
                        child: CachedNetworkImage(
                          width: double.infinity,
                          height: 200,
                          imageUrl:
                              apiData.quotesOfDayModel!.data![0].imageUrl!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: mediumGreyColor,
                            highlightColor: lightGreyColor,
                            child: Container(
                              color: Colors.grey,
                              height: 200,
                              width: double.infinity,
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            placeHolder,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Image.asset(
                          leftQuote,
                          width: 18,
                          height: 18,
                        ),
                      ),
                      Positioned(
                        bottom: 12,
                        right: 12,
                        child: Image.asset(
                          rightQuote,
                          width: 18,
                          height: 18,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: Text(
                            apiData.quotesOfDayModel!.data![0].quote!,
                            style: GoogleFonts.mukta(
                              color: Colors.white,
                              textStyle:
                                  Theme.of(context).textTheme.displayLarge,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  )
                : Image.asset(
                    placeHolder,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  );
      },
    );
  }
}
