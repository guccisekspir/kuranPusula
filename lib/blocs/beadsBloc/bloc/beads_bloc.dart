import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuranpusula/data/hiveRepository.dart';
import 'package:kuranpusula/locator.dart';
import 'package:kuranpusula/model/beads.dart';

part 'beads_event.dart';
part 'beads_state.dart';

class BeadsBloc extends Bloc<BeadsEvent, BeadsState> {
  HiveRepository hiveRepository = getIt<HiveRepository>();
  BeadsBloc() : super(BeadsInitial()) {
    on<BeadsEvent>((event, emit) async {
      if (event is SaveBeads) {
        emit(BeadsSaving());
        try {
          bool isSaved = await hiveRepository.saveBeadsToHive(event.beads);
          if (isSaved) {
            emit(BeadsSaved());
          } else {
            emit(BeadsSaveError(message: "Beads could not be saved"));
          }
        } catch (e) {
          emit(BeadsSaveError(message: e.toString()));
        }
      } else if (event is GetUserBeads) {
        emit(BeadsLoading());
        try {
          List<Beads> beads = await hiveRepository.getSavedBeads();
          emit(BeadsLoaded(beads: beads));
        } catch (e) {
          emit(BeadsLoadError(message: e.toString()));
        }
      }
    });
  }
}
