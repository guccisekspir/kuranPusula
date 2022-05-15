part of 'share_verse_bloc.dart';

abstract class ShareVerseState extends Equatable {
  const ShareVerseState();

  @override
  List<Object> get props => [];
}

class ShareVerseInitial extends ShareVerseState {}

class SurahSelected extends ShareVerseState {
  final Surah selectedSurah;

  SurahSelected({required this.selectedSurah});

  @override
  List<Object> get props => [selectedSurah];
}

class VerseSelected extends ShareVerseState {
  final Verse selectedVerse;
  final Surah selectedSurah;

  VerseSelected({required this.selectedVerse, required this.selectedSurah});

  @override
  List<Object> get props => [selectedVerse, selectedSurah];
}
