part of 'wedding_cubit.dart';

enum IntroState { ready, played }

class WeddingState extends Equatable {
  const WeddingState({
    this.enableVolume = false,
    this.introState = .ready,
    this.diffTime,
  });

  final bool enableVolume;
  final IntroState introState;
  final Duration? diffTime;

  WeddingState copyWith({
    bool? enableVolume,
    IntroState? introState,
    Duration? diffTime,
  }) {
    return WeddingState(
      enableVolume: enableVolume ?? this.enableVolume,
      introState: introState ?? this.introState,
      diffTime: diffTime ?? this.diffTime,
    );
  }

  @override
  List<Object> get props => [enableVolume, introState, ?diffTime];
}
