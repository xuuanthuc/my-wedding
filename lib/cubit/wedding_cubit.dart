import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wedding/constants/app_assets.dart';

part 'wedding_state.dart';

class WeddingCubit extends Cubit<WeddingState> {
  WeddingCubit() : super(WeddingState());

  final AudioPlayer? audioPlayer = AudioPlayer();

  void onClickVolume() async {
    if (audioPlayer?.state == .playing) {
      await audioPlayer?.pause();
    } else {
      await audioPlayer?.resume();
    }
    emit(state.copyWith(enableVolume: !state.enableVolume));
  }

  void introIsCompleted() async {
    await audioPlayer?.setReleaseMode(ReleaseMode.loop);
    await audioPlayer?.play(
      AssetSource(AppAssets.backgroundMusic, mimeType: 'audio/mpeg'),
    );
    emit(state.copyWith(introState: .played, enableVolume: true));
  }

  void countRemainingTime() {
    DateTime target = DateTime(2026, 9, 26, 12);
    DateTime now = DateTime.now();

    Duration diff = target.difference(now);
    emit(state.copyWith(diffTime: diff));
  }
}
