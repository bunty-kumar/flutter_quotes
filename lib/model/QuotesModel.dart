class QuotesModel {
  bool? status;
  String? msg;
  List<QuotesData>? data;

  QuotesModel({this.status, this.msg, this.data});

  QuotesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <QuotesData>[];
      json['data'].forEach((v) {
        data!.add(QuotesData.fromJson(v));
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

class QuotesData {
  String? sId;
  String? categoryId;
  String? title;
  String? authorName;
  String? imageUrl;
  String? updatedOn;
  String? createdOn;
  int? iV;

  QuotesData(
      {this.sId,
      this.categoryId,
      this.title,
      this.authorName,
      this.imageUrl,
      this.updatedOn,
      this.createdOn,
      this.iV});

  QuotesData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryId = json['categoryId'];
    title = json['title'];
    authorName = json['authorName'];
    imageUrl = json['imageUrl'];
    updatedOn = json['updatedOn'];
    createdOn = json['createdOn'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['categoryId'] = categoryId;
    data['title'] = title;
    data['authorName'] = authorName;
    data['imageUrl'] = imageUrl;
    data['updatedOn'] = updatedOn;
    data['createdOn'] = createdOn;
    data['__v'] = iV;
    return data;
  }
}
