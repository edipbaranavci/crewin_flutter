part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({this.stream});

  final Stream<QuerySnapshot>? stream;

  @override
  List<Object> get props => [stream ?? Stream<QuerySnapshot>];

  HomeState copyWith({
    Stream<QuerySnapshot>? stream,
  }) {
    return HomeState(
      stream: stream ?? this.stream,
    );
  }
}

class HomeInitial extends HomeState {}
