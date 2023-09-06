class SpacexModel {
  DataLinks? links;
  String? details;
  String? name;
  int? dateUnix;

  SpacexModel({this.links, this.details, this.name, this.dateUnix});

  SpacexModel.fromJson(Map<String, dynamic> json) {
    links = json['links'] != null ? DataLinks.fromJson(json['links']) : null;
    details = json['details'];
    name = json['name'];
    dateUnix = json['date_unix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (links != null) {
      data['links'] = links!.toJson();
    }
    data['details'] = details;
    data['name'] = name;
    data['date_unix'] = dateUnix;
    return data;
  }
}

class DataLinks {
  String? youtubeId;
  ImageLinks? patch;
  DataLinks({this.youtubeId, this.patch});

  DataLinks.fromJson(Map<String, dynamic> json) {
    youtubeId = json['youtube_id'];
    patch = json['patch'] != null ? ImageLinks.fromJson(json['patch']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (patch != null) {
      data['youtube_id'] = youtubeId;
      data['patch'] = patch!.toJson();
    }
    return data;
  }
}

class ImageLinks {
  String? smallThumb;
  ImageLinks({this.smallThumb});

  ImageLinks.fromJson(Map<String, dynamic> json) {
    smallThumb = json['small'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['small'] = smallThumb;
    return data;
  }
}

