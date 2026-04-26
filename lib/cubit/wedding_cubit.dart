import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wedding/constants/app_assets.dart';
import 'package:http/http.dart' as http;
import 'package:wedding/widgets/register.dart';

part 'wedding_state.dart';

class WeddingCubit extends Cubit<WeddingState> {
  WeddingCubit() : super(WeddingState());

  var client = http.Client();

  Future<void> registerAttendance(
    String name,
    AttendingState attendance,
    TransportationState transportation,
    String note,
  ) async {
    emit(state.copyWith(isRegistering: true));
    try {
      await client.post(
        Uri.parse(
          'https://script.google.com/macros/s/AKfycbwLqKvjZhUCQfGZgK59Gljj9wHXQuxN0VAKpZapB0YdZew2DK5T1t3p35uck2A7MVI/exec',
        ),
        body: {
          "name": name,
          "attendance": attendance.message,
          "transportation": attendance == AttendingState.yes
              ? transportation.message
              : "no",
          "note": note,
        },
      );
    } catch (_) {}
    emit(state.copyWith(isRegistering: false));
  }

  final AudioPlayer? audioPlayer = AudioPlayer();

  void initAudioPlayer() async {
    await audioPlayer?.setSource(
      AssetSource(AppAssets.backgroundMusic, mimeType: 'audio/mpeg'),
    );
    await audioPlayer?.setReleaseMode(ReleaseMode.loop);
  }

  void onClickVolume() async {
    if (audioPlayer?.state == .playing) {
      await audioPlayer?.pause();
    } else {
      await audioPlayer?.resume();
    }
    emit(state.copyWith(enableVolume: !state.enableVolume));
  }

  void introIsCompleted() async {
    await audioPlayer?.resume();
    emit(state.copyWith(introState: .played, enableVolume: true));
  }

  void countRemainingTime() {
    DateTime target = DateTime(2026, 9, 26, 12);
    DateTime now = DateTime.now();

    Duration diff = target.difference(now);
    emit(state.copyWith(diffTime: diff));
  }
}
