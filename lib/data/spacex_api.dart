import 'package:spacex/data/spacex_model.dart';

mixin SpacexApi {
  final spacexURL = "https://api.spacexdata.com/";
  final latestLaunchEndpoint = "v4/launches/latest";

  final apiExceptionMessage = 'Failed to Load SpaceX Launch Data';

  Future<SpacexModel> getTestData();
  Future<SpacexModel> getLatestSpacexLaunchData();
}