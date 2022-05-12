import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kuranpusula/data/quranRepository.dart';
import 'package:kuranpusula/locator.dart';
import 'package:kuranpusula/model/surah.dart';

part 'quran_event.dart';
part 'quran_state.dart';

class QuranBloc extends Bloc<QuranEvent, QuranState> {
  QuranRepository quranRepository = getIt<QuranRepository>();
  List<Surah>? surahList;
  QuranBloc() : super(QuranInitial()) {
    on<QuranEvent>((event, emit) async {
      if (event is GetAllSurahs) {
        emit(SurahLoading());
        try {
          if (surahList == null) {
            surahList = await quranRepository.getSurahs();
            debugPrint("surahList: " + surahList!.length.toString());
            emit(SurahLoaded(surahs: surahList!));
          } else {
            emit(SurahLoaded(surahs: surahList!));
          }
        } catch (e) {
          debugPrint(e.toString());
          emit(SurahLoadError(message: e.toString()));
        }
      }
    });
  }
}
