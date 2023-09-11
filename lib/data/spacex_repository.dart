import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:spacex/data/seed_data.dart';
import 'package:spacex/data/spacex_api.dart';
import 'package:spacex/data/spacex_model.dart';

class SpacexRepository with SpacexApi {

  // Supply seed data to test pull to refresh
  @override
  Future<SpacexData> getTestData() async {
    await Future.delayed(const Duration(seconds: 3));
    final dateUnix = (DateTime.now().toUtc().millisecondsSinceEpoch/1000).round();
    final spacexModel = SpacexModel(name: SeedData.crewName, details: SeedData.details, dateUnix: dateUnix, links: DataLinks(patch: ImageLinks(smallThumb: SeedData.aiImageLink)));
    return SpacexData.fromModel(spacexModel);
  }

  @override
  Future<SpacexData> getLatestSpacexLaunchData() async {
    final latestLaunchURI = Uri.parse(spacexURL+latestLaunchEndpoint);
    final response = await http.get(latestLaunchURI);
    if (response.statusCode == 200) {
      final spacexModel = SpacexModel.fromJson(convert.jsonDecode(response.body));
      return SpacexData.fromModel(spacexModel);
    }
    else {
      throw Exception(apiExceptionMessage);
    }
  }
}