part of 'quran_bloc.dart';

abstract class QuranEvent extends Equatable {
  const QuranEvent();

  @override
  List<Object> get props => [];
}

class GetAllSurahs extends QuranEvent {}

class GetSurahDetails extends QuranEvent {
  final int surahId;
  final DateTime dateTime;

  const GetSurahDetails({required this.surahId, required this.dateTime});

  @override
  List<Object> get props => [surahId, dateTime];
}
