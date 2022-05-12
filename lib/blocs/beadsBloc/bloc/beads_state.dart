part of 'beads_bloc.dart';

abstract class BeadsState extends Equatable {
  const BeadsState();

  @override
  List<Object> get props => [];
}

class BeadsInitial extends BeadsState {}

class BeadsSaving extends BeadsState {}

class BeadsSaved extends BeadsState {}

class BeadsSaveError extends BeadsState {
  final String message;

  const BeadsSaveError({required this.message});
}

class BeadsLoading extends BeadsState {}

class BeadsLoaded extends BeadsState {
  final List<Beads> beads;

  const BeadsLoaded({required this.beads});
}

class BeadsLoadError extends BeadsState {
  final String message;

  const BeadsLoadError({required this.message});
}
