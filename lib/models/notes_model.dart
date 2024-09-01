// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class NotesModel {
  String? status;
  List<Data>? data;

  NotesModel({this.status, this.data});

  NotesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? notesId;
  String? notesTitle;
  String? notesContant;
  String? notesImage;
  int? notesUser;

  Data(
      {this.notesId,
      this.notesTitle,
      this.notesContant,
      this.notesImage,
      this.notesUser});

  Data.fromJson(Map<String, dynamic> json) {
    notesId = json['notes_id'];
    notesTitle = json['notes_title'];
    notesContant = json['notes_contant'];
    notesImage = json['notes_image'];
    notesUser = json['notes_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notes_id'] = this.notesId;
    data['notes_title'] = this.notesTitle;
    data['notes_contant'] = this.notesContant;
    data['notes_image'] = this.notesImage;
    data['notes_user'] = this.notesUser;
    return data;
  }
}
