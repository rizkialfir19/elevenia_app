import 'package:elevenia_app/app_router.dart';
import 'package:elevenia_app/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/core.dart';

class App extends StatelessWidget {
  final BaseLocalStorageClient localStorageClient;
  // final BaseHomeRepository homeRepository;

  const App({
    Key? key,
    required this.localStorageClient,
    // required this.homeRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => localStorageClient,
        ),
        // RepositoryProvider(
        //   create: (context) => homeRepository,
        // ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppSetupCubit()..initialize(),
          ),
          BlocProvider(
            create: (context) => TabCubit(),
          ),
          BlocProvider(
            create: (context) => AuthenticationCubit(
              appSetupCubit: context.read<AppSetupCubit>(),
            ),
          ),
        ],
        child: EleveniaApp(),
      ),
    );
  }
}

class EleveniaApp extends StatelessWidget {
  EleveniaApp({Key? key}) : super(key: key);

  final AppRouter _appRouter = AppRouter();
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  DateTime? _lastUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      initialRoute: RouteName.splashScreen,
      onGenerateRoute: _appRouter.onGenerateRoute,
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          body: MultiBlocListener(
            listeners: [
              BlocListener<AuthenticationCubit, BaseState>(
                listener: (context, state) {
                  if (state is AuthenticatedState) {
                    if (_lastUser == null) {
                      _lastUser = state.timestamp;
                      // Trigger Patch Change Tab
                      context.read<TabCubit>().changeTab(tab: AppTab.home);
                      _navigatorKey.currentState!.pushNamedAndRemoveUntil(
                        RouteName.landingScreen,
                        (route) => false,
                      );
                    }
                  }

                  if (state is UnauthenticatedState) {
                    _lastUser = null;
                    // Can navigate to login/register screen if needed
                    context.read<TabCubit>().changeTab(tab: AppTab.home);
                    _navigatorKey.currentState!.pushNamedAndRemoveUntil(
                      RouteName.landingScreen,
                      (route) => false,
                    );
                  }
                },
              ),
            ],
            child: child!,
          ),
        );
      },
    );
  }
}
