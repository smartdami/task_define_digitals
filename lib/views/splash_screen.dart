import 'package:define_digital_tasks/utils/app_size.dart';
import 'package:define_digital_tasks/view_models/home_screen/home_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../routes/screen_routes.dart';
import '../utils/db_helper.dart';
import '../widgets/common_text_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late HomeScreenBloc _homeScreenBloc;
  @override
  void initState() {
    super.initState();
    _homeScreenBloc = BlocProvider.of<HomeScreenBloc>(context);
    _initDbConections();
  }

  _initDbConections() async {
    await DatabaseHelper().database;
    _homeScreenBloc.add(LoadCompanyCardDetailsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeScreenBloc, HomeScreenState>(
      listener: (context, state) async {
        if (state is CompanyCardDetailsLoadedState) {
          await Future.delayed(const Duration(seconds: 2));

          if (mounted) {
            Navigator.pushReplacementNamed(context, ScreenRoutes.homeScreen,
                arguments: {
                  "compABal": state.compABalance,
                  "compBBal": state.compBBalance
                });
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return Padding(
                    padding: REdgeInsets.symmetric(
                        horizontal: AppWidgetSize.dimen_5),
                    child: AnimatedDot(index: index),
                  );
                }),
              ),
              CommonTextWidget(
                textString: 'Define Digital Banking',
                topPadding: AppWidgetSize.dimen_15,
                textStyle: TextStyle(
                  fontSize: AppWidgetSize.dimen_24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedDot extends StatefulWidget {
  final int index;
  const AnimatedDot({super.key, required this.index});

  @override
  State<AnimatedDot> createState() => _AnimatedDotState();
}

class _AnimatedDotState extends State<AnimatedDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    _scaleAnimation = Tween(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        width: AppWidgetSize.dimen_12,
        height: AppWidgetSize.dimen_12,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.deepPurpleAccent,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
