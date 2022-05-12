part of 'beads_bloc.dart';

abstract class BeadsEvent extends Equatable {
  const BeadsEvent();

  @override
  List<Object> get props => [];
}

class SaveBeads extends BeadsEvent {
  final Beads beads;

  const SaveBeads({required this.beads});
}

class GetUserBeads extends BeadsEvent {}

class GetSelectedBeadsFromHive extends BeadsEvent {
  final Beads selectedBeads;

  const GetSelectedBeadsFromHive({required this.selectedBeads});
}

class DeleteBeads extends BeadsEvent {
  final Beads willDeleteBead;

  const DeleteBeads({required this.willDeleteBead});
}
