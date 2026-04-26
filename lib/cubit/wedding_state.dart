part of 'wedding_cubit.dart';

enum IntroState { ready, played }

class WeddingState extends Equatable {
  const WeddingState({
    this.enableVolume = false,
    this.introState = .ready,
    this.diffTime,
    this.isRegistering = false,
  });

  final bool enableVolume;
  final IntroState introState;
  final Duration? diffTime;
  final bool isRegistering;

  WeddingState copyWith({
    bool? enableVolume,
    IntroState? introState,
    Duration? diffTime,
    bool? isRegistering,
  }) {
    return WeddingState(
      enableVolume: enableVolume ?? this.enableVolume,
      introState: introState ?? this.introState,
      diffTime: diffTime ?? this.diffTime,
      isRegistering: isRegistering ?? this.isRegistering,
    );
  }

  @override
  List<Object> get props => [
    enableVolume,
    introState,
    ?diffTime,
    isRegistering,
  ];
}
