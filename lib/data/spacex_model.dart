import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class SpacexData extends Equatable {
  final String name;
  final String details;
  final String smallThumb;
  final String date;
  final String youtubeID;
  const SpacexData({required this.name, required this.details, required this.smallThumb,
    required this.date, required this.youtubeID});

  @override
  List<Object?> get props => [name, details, smallThumb, date, youtubeID];

  factory SpacexData.fromModel(SpacexModel model) =>
      SpacexData(name: model.name ?? 'No name', details: model.details ?? 'No details available!',
          smallThumb: model.links?.patch?.smallThumb ?? '', date: DateFormat("yyyy-MM-dd")
          .format(DateTime.fromMillisecondsSinceEpoch((model.dateUnix ?? 0) * 1000))
          .toString(), youtubeID: model.links?.youtubeId ?? '');
}

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

