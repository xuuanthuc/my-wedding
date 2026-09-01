import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import 'package:wedding/constants/app_assets.dart';
import 'package:wedding/widgets/register.dart';

part 'wedding_state.dart';

class WeddingCubit extends Cubit<WeddingState> {
  WeddingCubit() : super(const WeddingState());

  final client = http.Client();

  final AudioPlayer audioPlayer = AudioPlayer();

  Future<void> registerAttendance(
      String name,
      AttendingState attendance,
      TransportationState transportation,
      String note,
      ) async {
    emit(
      state.copyWith(
        isRegistering: true,
      ),
    );

    try {
      await client.post(
        Uri.parse(
          'https://script.google.com/macros/s/'
              'AKfycbwLqKvjZhUCQfGZgK59Gljj9wHXQuxN0VAKpZapB0YdZew2DK5T1t3p35uck2A7MVI/exec',
        ),
        body: {
          "name": name,
          "attendance": attendance.message,
          "transportation":
          attendance == AttendingState.yes
              ? transportation.message
              : "no",
          "note": note,
        },
      );
    } catch (e) {
      print(
        'Register attendance failed: $e',
      );
    }

    emit(
      state.copyWith(
        isRegistering: false,
      ),
    );
  }

  Future<void> initAudioPlayer() async {
    try {
      await audioPlayer.setSource(
        AssetSource(
          AppAssets.backgroundMusic,
          mimeType: 'audio/mpeg',
        ),
      );

      await audioPlayer.setReleaseMode(
        ReleaseMode.loop,
      );
    } catch (e) {
      // Audio lỗi cũng không ảnh hưởng website.
      print(
        'Background music initialization failed: $e',
      );
    }
  }

  Future<void> onClickVolume() async {
    try {
      if (audioPlayer.state == PlayerState.playing) {
        await audioPlayer.pause();

        emit(
          state.copyWith(
            enableVolume: false,
          ),
        );
      } else {
        await audioPlayer.resume();

        emit(
          state.copyWith(
            enableVolume: true,
          ),
        );
      }
    } catch (e) {
      print(
        'Background music play failed: $e',
      );

      emit(
        state.copyWith(
          enableVolume: false,
        ),
      );
    }
  }

  Future<void> introIsCompleted() async {
    // ===================================================
    // QUAN TRỌNG:
    //
    // Mở website TRƯỚC.
    // Audio có chạy được hay không không liên quan.
    // ===================================================
    emit(
      state.copyWith(
        introState: IntroState.played,
        enableVolume: false,
      ),
    );

    try {
      await audioPlayer.resume();

      if (isClosed) return;

      emit(
        state.copyWith(
          enableVolume: true,
        ),
      );
    } catch (e) {
      // Safari/iPhone có thể block autoplay.
      // Thiệp vẫn hoạt động bình thường.
      print(
        'Background music autoplay blocked: $e',
      );
    }
  }

  void countRemainingTime() {
    final target = DateTime(
      2026,
      9,
      30,
      11,
    );

    final now = DateTime.now();

    final diff = target.difference(now);

    emit(
      state.copyWith(
        diffTime: diff,
      ),
    );
  }

  @override
  Future<void> close() async {
    client.close();

    await audioPlayer.dispose();

    return super.close();
  }
}