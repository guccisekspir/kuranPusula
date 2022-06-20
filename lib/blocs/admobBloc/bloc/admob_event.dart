part of 'admob_bloc.dart';

abstract class AdmobEvent extends Equatable {
  const AdmobEvent();

  @override
  List<Object> get props => [];
}

class LoadIntersAd extends AdmobEvent {
  final DateTime dateTime;
  const LoadIntersAd(this.dateTime);
  @override
  List<Object> get props => [dateTime];
}

class ShowIntersAd extends AdmobEvent {
  final DateTime dateTime;
  const ShowIntersAd(this.dateTime);
  @override
  List<Object> get props => [dateTime];
}
