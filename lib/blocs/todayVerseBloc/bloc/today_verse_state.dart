part of 'today_verse_bloc.dart';

abstract class TodayVerseState extends Equatable {
  const TodayVerseState();

  @override
  List<Object> get props => [];
}

class TodayVerseInitial extends TodayVerseState {}

class TodayVerseLoading extends TodayVerseState {}

class TodayVerseLoaded extends TodayVerseState {
  final (String, String) translationAndVerse;

  const TodayVerseLoaded({required this.translationAndVerse});

  @override
  List<Object> get props => [translationAndVerse];
}

class TodayVerseError extends TodayVerseState {
  final String message;

  const TodayVerseError({required this.message});

  @override
  List<Object> get props => [message];
}
