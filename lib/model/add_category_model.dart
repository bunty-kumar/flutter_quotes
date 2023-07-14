class AddQuotesModel {
  bool? status;
  String? msg;
  Data? data;

  AddQuotesModel({this.status, this.msg, this.data});

  AddQuotesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? categoryId;
  String? title;
  String? authorName;
  String? imageUrl;
  String? sId;
  String? updatedOn;
  String? createdOn;
  int? iV;

  Data(
      {this.categoryId,
      this.title,
      this.authorName,
      this.imageUrl,
      this.sId,
      this.updatedOn,
      this.createdOn,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    title = json['title'];
    authorName = json['authorName'];
    imageUrl = json['imageUrl'];
    sId = json['_id'];
    updatedOn = json['updatedOn'];
    createdOn = json['createdOn'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['title'] = title;
    data['authorName'] = authorName;
    data['imageUrl'] = imageUrl;
    data['_id'] = sId;
    data['updatedOn'] = updatedOn;
    data['createdOn'] = createdOn;
    data['__v'] = iV;
    return data;
  }
}
