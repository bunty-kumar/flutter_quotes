import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_quotes/model/QuotesCategoryModel.dart';
import 'package:flutter_quotes/model/add_category_model.dart';
import 'package:flutter_quotes/model/quote_of_day_model.dart';
import 'package:flutter_quotes/utils/constants.dart';
import 'package:http/http.dart' as http;
import '../model/QuotesModel.dart';

class ApiController extends ChangeNotifier {
  static const baseUrl = "http://192.168.0.7:8000/api/";

  bool _getCategoryLoader = true;

  bool get getCategoryLoader => _getCategoryLoader;

  setGetCategoryLoader(bool value) {
    _getCategoryLoader = value;
    notifyListeners();
  }

  bool _getQuotesIdLoader = true;

  bool get getQuotesIdLoader => _getQuotesIdLoader;

  setGetQuotesIdLoader(bool value) {
    _getQuotesIdLoader = value;
    notifyListeners();
  }

  bool _getQuotesLoader = true;

  bool get getQuotesLoader => _getQuotesLoader;

  setGetQuotesLoader(bool value) {
    _getQuotesLoader = value;
    notifyListeners();
  }

  bool _addQuotesLoader = false;

  bool get addQuotesLoader => _addQuotesLoader;

  setAddQuotesLoader(bool value) {
    _addQuotesLoader = value;
    notifyListeners();
  }

  bool _getQuotesOfDayLoader = true;

  bool get getQuotesOfDayLoader => _getQuotesOfDayLoader;

  setGetQuotesOfDay(bool value) {
    _getQuotesOfDayLoader = value;
    notifyListeners();
  }

  QuotesCategoryModel? _quotesCategoryModel;

  QuotesCategoryModel? get quotesCategoryModel => _quotesCategoryModel;

  QuotesModel? _quotesModel;

  QuotesModel? get quotesModel => _quotesModel;

  QuotesModel? _quotesByIDModel;

  QuotesModel? get quotesByIDModel => _quotesByIDModel;

  QuoteOfDayModel? _quotesOfDayModel;

  QuoteOfDayModel? get quotesOfDayModel => _quotesOfDayModel;

  // add product api
  Future<bool> addQuotesCategory(Map pData, BuildContext context) async {
    log("req body $pData");
    setAddQuotesLoader(true);
    var url = Uri.parse("${baseUrl}quotes");
    try {
      final resp = await http.post(url, body: pData);
      if (resp.statusCode == 200) {
        var quotes = AddQuotesModel.fromJson(jsonDecode(resp.body));
        showSnackBar(context, quotes.msg!);
        log("resp data before ${resp.body}");
        setAddQuotesLoader(false);
        if (quotes.status == false) {
          return false;
        } else {
          return true;
        }
      } else {
        showSnackBar(context, "failed to get response");
        log("failed to get response");
        setAddQuotesLoader(false);
        return false;
      }
    } catch (ex) {
      showSnackBar(context, ex.toString());
      log("error ${ex.toString()}");
      setAddQuotesLoader(false);
      return false;
    }
  }

  // get Quotes Category api
  Future<void> getQuotesCategory() async {
    var url = Uri.parse("${baseUrl}quotesCategory");
    bool isOnline = await Constant.checkInternet();
    setGetCategoryLoader(true);
    if (isOnline) {
      try {
        final resp = await http.get(url);
        if (resp.statusCode == 200) {
          _quotesCategoryModel =
              QuotesCategoryModel.fromJson(jsonDecode(resp.body));
          log("resp data before ${resp.body}");
          setGetCategoryLoader(false);
        } else {
          log("failed to get response");
          _quotesCategoryModel = null;
          setGetCategoryLoader(false);
        }
      } catch (ex) {
        log("error ${ex.toString()}");
        _quotesCategoryModel = null;
        setGetCategoryLoader(false);
      }
    } else {
      log("No internet connection");
    }
  }

  // get Quotes by id api
  Future<void> getQuotesById(String categoryId) async {
    var url = Uri.parse("${baseUrl}quotes/$categoryId");
    bool isOnline = await Constant.checkInternet();
    setGetQuotesIdLoader(true);
    if (isOnline) {
      try {
        final resp = await http.get(url);
        if (resp.statusCode == 200) {
          _quotesByIDModel = QuotesModel.fromJson(jsonDecode(resp.body));
          log("resp data before ${resp.body}");
          setGetQuotesIdLoader(false);
        } else {
          log("failed to get response");
          _quotesByIDModel = null;
          setGetQuotesIdLoader(false);
        }
      } catch (ex) {
        log("error ${ex.toString()}");
        _quotesByIDModel = null;
        setGetQuotesIdLoader(false);
      }
    } else {
      log("No internet connection");
    }
  }

  // get all Quotes api
  Future<void> getAllQuotes() async {
    var url = Uri.parse("${baseUrl}quotes");
    bool isOnline = await Constant.checkInternet();
    setGetQuotesLoader(true);
    if (isOnline) {
      try {
        final resp = await http.get(url);
        if (resp.statusCode == 200) {
          _quotesModel = QuotesModel.fromJson(jsonDecode(resp.body));
          log("resp data before ${resp.body}");
          setGetQuotesLoader(false);
        } else {
          log("failed to get response");
          _quotesModel = null;
          setGetQuotesLoader(false);
        }
      } catch (ex) {
        log("error ${ex.toString()}");
        _quotesModel = null;
        setGetQuotesLoader(false);
      }
    } else {
      log("No internet connection");
    }
  }

  // get quotes of day api
  Future<void> getQuotesOfDay() async {
    var url = Uri.parse("${baseUrl}quoteOfDay");
    bool isOnline = await Constant.checkInternet();
    setGetQuotesOfDay(true);
    if (isOnline) {
      try {
        final resp = await http.get(url);
        if (resp.statusCode == 200) {
          _quotesOfDayModel = QuoteOfDayModel.fromJson(jsonDecode(resp.body));
          log("resp data before ${resp.body}");
          setGetQuotesOfDay(false);
        } else {
          log("failed to get response");
          _quotesOfDayModel = null;
          setGetQuotesOfDay(false);
        }
      } catch (ex) {
        log("error ${ex.toString()}");
        _quotesOfDayModel = null;
        setGetQuotesOfDay(false);
      }
    } else {
      log("No internet connection");
    }
  }
}
