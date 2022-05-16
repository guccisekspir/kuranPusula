import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kuranpusula/data/hiveRepository.dart';
import 'package:kuranpusula/locator.dart';
import 'package:kuranpusula/model/beads.dart';

part 'beads_event.dart';
part 'beads_state.dart';

class BeadsBloc extends Bloc<BeadsEvent, BeadsState> {
  HiveRepository hiveRepository = getIt<HiveRepository>();
  List<Beads> userBeads = [];
  BeadsBloc() : super(BeadsInitial()) {
    on<BeadsEvent>((event, emit) async {
      if (event is SaveBeads) {
        emit(BeadsSaving());
        try {
          bool isSaved = await hiveRepository.saveBeadsToHive(event.beads);
          if (isSaved) {
            debugPrint("kaydedildi" + event.beads.bead.toString());
            emit(BeadsSaved());
          } else {
            emit(const BeadsSaveError(message: "Beads could not be saved"));
          }
          List<Beads> beads = await hiveRepository.getSavedBeads();
          beads.sort();
          userBeads = beads;
        } catch (e) {
          emit(BeadsSaveError(message: e.toString()));
        }
      } else if (event is GetUserBeads) {
        emit(BeadsLoading());
        try {
          List<Beads> beads = await hiveRepository.getSavedBeads();
          beads.sort();
          debugPrint("çEKİLDEİ USER BEADS: ${beads.length}");

          emit(BeadsLoaded(beads: beads));
          userBeads = beads;
        } catch (e) {
          emit(BeadsLoadError(message: e.toString()));
        }
      } else if (event is GetSelectedBeadsFromHive) {
        emit(BeadsLoading());
        try {
          List<Beads> beads = await hiveRepository.getSavedBeads();
          Beads? isAlreadySavedBeeds;
          for (var element in beads) {
            if (element.bead == event.selectedBeads.bead) {
              isAlreadySavedBeeds = element;
            }
          }
          emit(SelectedBeadsFetched(hiveSavedBead: isAlreadySavedBeeds ?? event.selectedBeads));
        } catch (e) {
          emit(BeadsLoadError(message: e.toString()));
        }
      } else if (event is DeleteBeads) {
        emit(BeadsLoading());
        try {
          bool isDeleted = await hiveRepository.deleteBeadsFromHive(event.willDeleteBead);
          List<Beads> beads = await hiveRepository.getSavedBeads();
          beads.sort();
          userBeads = beads;
          emit(BeadsLoaded(beads: userBeads));
        } catch (e) {
          emit(BeadsLoadError(message: e.toString()));
        }
      }
    });
  }
}
