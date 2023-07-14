class QuotesCategoryModel {
  bool? status;
  String? msg;
  List<QuotesCategoryData>? data;

  QuotesCategoryModel({this.status, this.msg, this.data});

  QuotesCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <QuotesCategoryData>[];
      json['data'].forEach((v) {
        data!.add(QuotesCategoryData.fromJson(v));
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

class QuotesCategoryData {
  String? sId;
  String? title;
  String? imageUrl;
  String? updatedOn;
  String? createdOn;
  int? iV;

  QuotesCategoryData(
      {this.sId,
      this.title,
      this.imageUrl,
      this.updatedOn,
      this.createdOn,
      this.iV});

  QuotesCategoryData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    imageUrl = json['imageUrl'];
    updatedOn = json['updatedOn'];
    createdOn = json['createdOn'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['imageUrl'] = imageUrl;
    data['updatedOn'] = updatedOn;
    data['createdOn'] = createdOn;
    data['__v'] = iV;
    return data;
  }
}
