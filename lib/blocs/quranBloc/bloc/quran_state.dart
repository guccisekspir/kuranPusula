part of 'quran_bloc.dart';

abstract class QuranState extends Equatable {
  const QuranState();

  @override
  List<Object> get props => [];
}

class QuranInitial extends QuranState {}

class SurahLoading extends QuranState {}

class SurahLoaded extends QuranState {
  final List<Surah> surahs;

  const SurahLoaded({required this.surahs});
}

class SurahLoadError extends QuranState {
  final String message;

  const SurahLoadError({required this.message});
}

class DetailedSurahLoading extends QuranState {}

class DetailedSurahLoaded extends QuranState {
  final DetailedSurah detailedSurah;

  const DetailedSurahLoaded({required this.detailedSurah});
}

class DetailedSurahLoadError extends QuranState {
  final String message;

  const DetailedSurahLoadError({required this.message});
}
