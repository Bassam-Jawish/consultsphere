import 'package:consultsphere/features/authentication/presentation/pages/forgot_password_page.dart';
import 'package:consultsphere/features/authentication/presentation/pages/vertification_send_page.dart';
import 'package:consultsphere/features/base/presentation/pages/base.dart';
import 'package:consultsphere/features/expert/presentation/pages/top_experts_page.dart';
import 'package:consultsphere/features/splash/presentation/pages/splash_page.dart';
import 'package:consultsphere/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/authentication/presentation/pages/login_page.dart';
import '../../features/authentication/presentation/pages/register_page.dart';

abstract class AppRouter {
  static const kLoginPage = '/login';
  static const kRegisterPage = 'register';
  static const kForgotPasswordPage = 'forgot_password';
  static const kVerificationRegisterPage = 'verification_register';
  static const kVerificationForgotPage = 'verification_forgot';
  static const kCreatePasswordPage = 'create_password';
  static const kBasePage = '/base';
  static const kMessagesPage = 'messages';
  static const kTopExpertsPage = 'top_experts';

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static CustomTransitionPage scaleTransition(page) =>
      CustomTransitionPage<void>(
        child: page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            ScaleTransition(
          scale: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 300),
      );

  static CustomTransitionPage slideTransition(page) =>
      CustomTransitionPage<void>(
        child: page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 200),
        reverseTransitionDuration: const Duration(milliseconds: 200),
      );

  static CustomTransitionPage fadeTransition(page) =>
      CustomTransitionPage<void>(
        child: page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: CurveTween(curve: Curves.ease).animate(animation),
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 200),
        reverseTransitionDuration: const Duration(milliseconds: 200),
      );

  /*

  // For base bottom nav bar pages
  static final _shellNavigatorHome =
      GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final _shellNavigatorMessages =
      GlobalKey<NavigatorState>(debugLabel: 'shellMessages');

  */

  static bool _splashScreenShown = false;

  static final router = GoRouter(
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        pageBuilder: (context, state) {
          _splashScreenShown = true;
          return const MaterialPage(child: SplashPage());
        },
      ),
      GoRoute(
        path: kLoginPage,
        name: 'login',
        pageBuilder: (context, state) {
          return const MaterialPage(child: LoginPage());
        },
        routes: [
          GoRoute(
              path: kRegisterPage,
              name: 'register',
              pageBuilder: (context, state) =>
                  slideTransition(const RegisterPage()),
              routes: [
                GoRoute(
                    path: '$kVerificationRegisterPage/:email',
                    name: 'verification_register',
                    pageBuilder: (context, state) => slideTransition(
                          VerificationSendPage(
                              email:
                                  state.pathParameters['email']!.toString() ??
                                      ''),
                        )),
              ]),
          GoRoute(
            path: kForgotPasswordPage,
            name: 'forgot_password',
            pageBuilder: (context, state) =>
                slideTransition(const ForgotPasswordPage()),
            routes: [
              GoRoute(
                path: '$kVerificationForgotPage/:email',
                name: 'verification_forgot',
                pageBuilder: (context, state) => slideTransition(
                  VerificationSendPage(
                      email: state.pathParameters['email']!.toString() ?? ''),
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: kBasePage,
        name: 'base',
        pageBuilder: (context, state) {
          return const MaterialPage(child: BasePage());
        },
        routes: [
          GoRoute(
            path: kTopExpertsPage,
            name: 'top_experts',
            pageBuilder: (context, state) =>
                slideTransition(const TopExpertsPage()),
          ),
        ],
      ),

      // If want to keep bottom nav bar in each page
      /*
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return BasePage(
            navigationShell: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHome,
            routes: <RouteBase>[
              GoRoute(
                path: kHomePage,
                name: "home",
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    const MaterialPage(child: HomePage()),
                routes: [
                  GoRoute(
                    path: kTopExpertsPage,
                    name: 'topExpertsPage',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      child: const TopExpertsPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorMessages,
            routes: <RouteBase>[
              GoRoute(
                path: kMessagesPage,
                name: "messages",
                builder: (BuildContext context, GoRouterState state) =>
                    const MessagesPage(),
              ),
            ],
          ),
        ],
      ),
      */
    ],
    redirect: (context, state) {
      debugPrint(state.fullPath);
      if (!_splashScreenShown) {
        return null;
      }
      if (token == 'No data found!' && state.fullPath == '/base') {
        return kLoginPage;
      }
      return null;
    },
  );
}
