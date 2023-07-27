part of 'today_verse_bloc.dart';

abstract class TodayVerseEvent extends Equatable {
  const TodayVerseEvent();

  @override
  List<Object> get props => [];
}

class GetTodayVerse extends TodayVerseEvent {
  final int surahNumber;

  GetTodayVerse({required this.surahNumber});

  @override
  List<Object> get props => [surahNumber];
}
