part of 'new_trip_cubit.dart';

@immutable
abstract class NewTripState {
  final NewTripRepository repository;
  const NewTripState(this.repository);
}

class NewTripInitial extends NewTripState {
  const NewTripInitial(NewTripRepository repository) : super(repository);
}

class NewTripSelectTypeOnPassenger extends NewTripState {
  const NewTripSelectTypeOnPassenger(NewTripRepository repository)
      : super(repository);
}

class NewTripSelectTypeOnDriver extends NewTripState {
  const NewTripSelectTypeOnDriver(NewTripRepository repository)
      : super(repository);
}

class NewTripSetDate extends NewTripState {
  const NewTripSetDate(NewTripRepository repository) : super(repository);
}

class NewTripSetDirectionFrom extends NewTripState {
  const NewTripSetDirectionFrom(NewTripRepository repository)
      : super(repository);
}

class NewTripSetDirectionTo extends NewTripState {
  const NewTripSetDirectionTo(NewTripRepository repository) : super(repository);
}

class NewTripAddComment extends NewTripState {
  const NewTripAddComment(NewTripRepository repository) : super(repository);
}
