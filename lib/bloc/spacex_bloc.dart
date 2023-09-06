import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/bloc/spacex_event.dart';
import 'package:spacex/bloc/spacex_state.dart';
import 'package:spacex/data/spacex_repository.dart';

class SpacexBloc extends Bloc<SpacexEvent, SpacexState> {
  final SpacexRepository _spacexRepository;
  SpacexBloc(this._spacexRepository) : super(SpacexLoadingState()) {
    on<SpacexLatestLaunchEvent>((event, emit) async {
      emit(SpacexLoadingState());
      try {
        final launchData = await _spacexRepository.getLatestSpacexLaunchData();
        emit(SpacexSuccessState(launchData));
      } catch(e) {
        emit(SpacexFailureState(e.toString()));
      }
    });

    on<SpacexTestEvent>((event, emit) async {
      emit(SpacexLoadingState());
      try {
        final launchData = await _spacexRepository.getTestData();
        emit(SpacexSuccessState(launchData));
      } catch(e) {
        emit(SpacexFailureState(e.toString()));
      }
    });
  }
}