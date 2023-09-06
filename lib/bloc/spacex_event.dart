import 'package:equatable/equatable.dart';

abstract class SpacexEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SpacexLatestLaunchEvent extends SpacexEvent {}
class SpacexTestEvent extends SpacexEvent {}