import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:spacex/data/spacex_model.dart';

@immutable
sealed class SpacexState extends Equatable {}

class SpacexLoadingState extends SpacexState {
  @override
  List<Object> get props => [];
}

class SpacexSuccessState extends SpacexState {
  final SpacexModel spacexModel;
  SpacexSuccessState(this.spacexModel);

  @override
  List<Object> get props => [spacexModel];
}

class SpacexFailureState extends SpacexState {
  final String errorMessage;
  SpacexFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}



