part of 'bloc.dart';

class MasterState extends Equatable {
  final bool isLoading;
  final SharedPreferences? localStorage;

  const MasterState({
    this.isLoading = true,
    this.localStorage,
  });

  @override
  List<Object?> get props => [
    isLoading,
  ];

  MasterState copyWith({
    bool? isLoading,
    SharedPreferences? localStorage,
  }) {
    return MasterState(
      isLoading: isLoading ?? this.isLoading,
      localStorage: localStorage ?? this.localStorage,
    );
  }
}
