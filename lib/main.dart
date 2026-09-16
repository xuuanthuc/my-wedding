import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:wedding/constants/app_colors.dart';
import 'package:wedding/widgets/countdown.dart';
import 'package:wedding/widgets/footer.dart';
import 'package:wedding/widgets/gifts.dart';
import 'package:wedding/widgets/invitation.dart';
import 'package:wedding/widgets/location.dart';
import 'package:wedding/widgets/programs.dart';
import 'package:wedding/widgets/register.dart';
import 'package:wedding/widgets/transportation.dart';
import 'package:wedding/widgets/welcome.dart';

import 'constants/app_assets.dart';
import 'cubit/wedding_cubit.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thực & Yến',
      theme: ThemeData(
        fontFamily: 'Niramit',
        colorScheme: ColorScheme(
          brightness: Brightness.light,
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
      builder: FToastBuilder(),
      navigatorKey: navigatorKey,
      home: BlocProvider(
        create: (_) => WeddingCubit(),
        child: const MyHomePage(title: 'Thực & Yến'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey _targetKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    context.read<WeddingCubit>().initAudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: InvitationView(
              onTapRegister: () {
                final targetContext = _targetKey.currentContext;
                if (targetContext == null) return;

                Scrollable.ensureVisible(
                  targetContext,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
          const SliverToBoxAdapter(child: CountdownView()),
          const SliverToBoxAdapter(child: WelcomeView()),
          const SliverToBoxAdapter(child: LocationCelebrateView()),
          const SliverToBoxAdapter(child: DayProgrammeView()),
          const SliverToBoxAdapter(child: GiftsView()),
          const SliverToBoxAdapter(child: TransportationView()),
          SliverToBoxAdapter(key: _targetKey, child: RSVP()),
          const SliverToBoxAdapter(child: Footer()),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => context.read<WeddingCubit>().onClickVolume(),
        elevation: 0,
        shape: const CircleBorder(),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: BlocBuilder<WeddingCubit, WeddingState>(
            buildWhen: (previous, current) =>
                previous.enableVolume != current.enableVolume,
            builder: (context, state) {
              return SvgPicture.asset(
                state.enableVolume ? AppAssets.icVolume : AppAssets.icVolumeX,
                colorFilter: const ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
