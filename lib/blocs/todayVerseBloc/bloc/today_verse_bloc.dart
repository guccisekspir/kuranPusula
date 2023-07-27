import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuranpusula/data/quranRepository.dart';
import 'package:kuranpusula/locator.dart';

part 'today_verse_event.dart';
part 'today_verse_state.dart';

class TodayVerseBloc extends Bloc<TodayVerseEvent, TodayVerseState> {
  QuranRepository quranRepository = getIt<QuranRepository>();
  TodayVerseBloc() : super(TodayVerseInitial()) {
    on<TodayVerseEvent>((event, emit) async {
      if (event is GetTodayVerse) {
        emit(TodayVerseLoading());
        try {
          (String, String) translationAndVerse =
              await quranRepository.getVerseAndSurahName(event.surahNumber);
          emit(TodayVerseLoaded(translationAndVerse: translationAndVerse));
        } catch (e) {
          emit(TodayVerseError(message: e.toString()));
        }
      }
    });
  }
}
