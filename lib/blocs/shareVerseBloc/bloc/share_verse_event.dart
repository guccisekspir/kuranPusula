part of 'share_verse_bloc.dart';

abstract class ShareVerseEvent extends Equatable {
  const ShareVerseEvent();

  @override
  List<Object> get props => [];
}

class SurahSelect extends ShareVerseEvent {
  final Surah selectedSurah;

  SurahSelect({required this.selectedSurah});

  @override
  List<Object> get props => [selectedSurah];
}

class VerseSelect extends ShareVerseEvent {
  final Verse selectedVerse;

  VerseSelect({required this.selectedVerse});

  @override
  List<Object> get props => [selectedVerse];
}
