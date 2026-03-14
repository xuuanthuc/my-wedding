import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';
import 'package:wedding/constants/app_colors.dart';
import 'package:wedding/widgets/countdown.dart';
import 'package:wedding/widgets/footer.dart';
import 'package:wedding/widgets/gifts.dart';
import 'package:wedding/widgets/intro.dart';
import 'package:wedding/widgets/invitation.dart';
import 'package:wedding/widgets/location.dart';
import 'package:wedding/widgets/programs.dart';
import 'package:wedding/widgets/register.dart';
import 'package:wedding/widgets/transportation.dart';
import 'package:wedding/widgets/welcome.dart';
import 'constants/app_assets.dart';
import 'cubit/wedding_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Niramit',
        colorScheme: ColorScheme(
          brightness: .light,
          primary: AppColors.primary,
          onPrimary: Colors.white,
          secondary: AppColors.secondary,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          surface: AppColors.secondaryBackground,
          onSurface: AppColors.primary,
        ),
      ),
      themeMode: ThemeMode.light,
      home: BlocProvider(
        create: (_) => WeddingCubit(),
        child: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late VideoPlayerController _controller;
  final GlobalKey _targetKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(AppAssets.introLanding)
      ..initialize().then((_) {
        setState(() {});
      });

    context.read<WeddingCubit>().initAudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeddingCubit, WeddingState>(
      buildWhen: (p, c) => p.introState != c.introState,
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              AnimatedOpacity(
                opacity: state.introState == .ready ? 0 : 1,
                duration: Duration(milliseconds: 300),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: InvitationView(
                        controller: _controller,
                        onTapRegister: () {
                          final context = _targetKey.currentContext;
                          if (context == null) return;
                          Scrollable.ensureVisible(
                            _targetKey.currentContext!,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ),
                    SliverToBoxAdapter(child: CountdownView()),
                    SliverToBoxAdapter(child: WelcomeView()),
                    SliverToBoxAdapter(child: LocationCelebrateView()),
                    SliverToBoxAdapter(child: DayProgrammeView()),
                    SliverToBoxAdapter(child: GiftsView()),
                    SliverToBoxAdapter(child: TransportationView()),
                    SliverToBoxAdapter(key: _targetKey, child: RSVP()),
                    SliverToBoxAdapter(child: Footer()),
                  ],
                ),
              ),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: state.introState == .ready
                    ? IntroView()
                    : SizedBox.shrink(),
              ),
            ],
          ),
          floatingActionButton: state.introState == .played
              ? FloatingActionButton.small(
                  onPressed: () {
                    context.read<WeddingCubit>().onClickVolume();
                  },
                  elevation: 0,
                  shape: CircleBorder(),
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: BlocBuilder<WeddingCubit, WeddingState>(
                      buildWhen: (p, c) => p.enableVolume != c.enableVolume,
                      builder: (context, state) {
                        if (state.enableVolume) {
                          return SvgPicture.asset(
                            AppAssets.icVolume,
                            colorFilter: const ColorFilter.mode(
                              AppColors.primary,
                              BlendMode.srcIn,
                            ),
                          );
                        }
                        return SvgPicture.asset(
                          AppAssets.icVolumeX,
                          colorFilter: const ColorFilter.mode(
                            AppColors.primary,
                            BlendMode.srcIn,
                          ),
                        );
                      },
                    ),
                  ),
                )
              : null,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
