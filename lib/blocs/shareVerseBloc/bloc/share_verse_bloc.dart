import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuranpusula/model/detailedSurah.dart';
import 'package:kuranpusula/model/surah.dart';

part 'share_verse_event.dart';
part 'share_verse_state.dart';

class ShareVerseBloc extends Bloc<ShareVerseEvent, ShareVerseState> {
  Surah? selectedSurah;
  Verse? selectedVerse;
  ShareVerseBloc() : super(ShareVerseInitial()) {
    on<ShareVerseEvent>((event, emit) {
      if (event is SurahSelect) {
        selectedSurah = event.selectedSurah;
        emit(SurahSelected(selectedSurah: selectedSurah!));
      } else if (event is VerseSelect) {
        selectedVerse = event.selectedVerse;
        emit(VerseSelected(selectedVerse: selectedVerse!, selectedSurah: selectedSurah!));
      }
    });
  }
}
