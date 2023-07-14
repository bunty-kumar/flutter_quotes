class QuoteOfDayModel {
  bool? status;
  String? msg;
  List<QuotesOfDayData>? data;

  QuoteOfDayModel({this.status, this.msg, this.data});

  QuoteOfDayModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <QuotesOfDayData>[];
      json['data'].forEach((v) {
        data!.add(QuotesOfDayData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuotesOfDayData {
  String? sId;
  String? quote;
  String? imageUrl;
  String? updatedOn;
  String? createdOn;
  int? iV;

  QuotesOfDayData(
      {this.sId,
      this.quote,
      this.imageUrl,
      this.updatedOn,
      this.createdOn,
      this.iV});

  QuotesOfDayData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    quote = json['quote'];
    imageUrl = json['imageUrl'];
    updatedOn = json['updatedOn'];
    createdOn = json['createdOn'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['quote'] = quote;
    data['imageUrl'] = imageUrl;
    data['updatedOn'] = updatedOn;
    data['createdOn'] = createdOn;
    data['__v'] = iV;
    return data;
  }
}
