import 'package:define_digital_tasks/view_models/home_screen/home_screen_bloc.dart';
import 'package:define_digital_tasks/view_models/savings_history/savings_history_bloc.dart';
import 'package:define_digital_tasks/view_models/withdraw/withdraw_bloc.dart';
import 'package:define_digital_tasks/views/savings_entry_screen.dart';
import 'package:define_digital_tasks/views/savings_history_screen.dart';
import 'package:define_digital_tasks/views/savings_withdraw_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../views/home_screen.dart';
import '../views/splash_screen.dart';
import 'screen_routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case ScreenRoutes.splashScreen:
      return MaterialPageRoute(
        settings: const RouteSettings(name: ScreenRoutes.splashScreen),
        builder: (BuildContext context) => BlocProvider<HomeScreenBloc>(
            create: (context) => HomeScreenBloc(), child: const SplashScreen()),
      );

    case ScreenRoutes.homeScreen:
      return MaterialPageRoute(
        settings: const RouteSettings(name: ScreenRoutes.homeScreen),
        builder: (BuildContext context) => BlocProvider<HomeScreenBloc>(
            create: (context) => HomeScreenBloc(),
            child: HomeScreen(
              compABal: (settings.arguments as Map)["compABal"],
              compBBal: (settings.arguments as Map)["compBBal"],
            )),
      );
    case ScreenRoutes.savingsEntryScreen:
      return MaterialPageRoute(
        settings: const RouteSettings(name: ScreenRoutes.savingsEntryScreen),
        builder: (BuildContext context) => BlocProvider<HomeScreenBloc>(
            create: (context) => HomeScreenBloc(),
            child: const SavingsEntryScreen()),
      );
    case ScreenRoutes.savingsHistoryScreen:
      return MaterialPageRoute(
        settings: const RouteSettings(name: ScreenRoutes.savingsHistoryScreen),
        builder: (BuildContext context) => BlocProvider<SavingsHistoryBloc>(
            create: (context) => SavingsHistoryBloc(),
            child: const SavingsHistoryScreen()),
      );
    case ScreenRoutes.savingsWithdrawlScreen:
      return MaterialPageRoute(
        settings:
            const RouteSettings(name: ScreenRoutes.savingsWithdrawlScreen),
        builder: (BuildContext context) => BlocProvider<WithdrawBloc>(
            create: (context) => WithdrawBloc(),
            child: SavingsWithdrawScreen(
              compABal: (settings.arguments as Map)["compABal"],
              compBBal: (settings.arguments as Map)["compBBal"],
            )),
      );
    default:
      return MaterialPageRoute(
        builder: (BuildContext context) => const SplashScreen(),
      );
  }
}
