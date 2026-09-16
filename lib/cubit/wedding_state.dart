part of 'wedding_cubit.dart';

class WeddingState extends Equatable {
  const WeddingState({
    this.enableVolume = false,
    this.diffTime,
    this.isRegistering = false,
  });

  final bool enableVolume;
  final Duration? diffTime;
  final bool isRegistering;

  WeddingState copyWith({
    bool? enableVolume,
    Duration? diffTime,
    bool? isRegistering,
  }) {
    return WeddingState(
      enableVolume: enableVolume ?? this.enableVolume,
      diffTime: diffTime ?? this.diffTime,
      isRegistering: isRegistering ?? this.isRegistering,
    );
  }

  @override
  List<Object> get props => [
    enableVolume,
    ?diffTime,
    isRegistering,
  ];
}
