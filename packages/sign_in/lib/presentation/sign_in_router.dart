part of '../sign_in.dart';

final signInNavigatorKey = GlobalKey<NavigatorState>();

class SignInRouter {
  static final main = GlobalKey<NavigatorState>();
  static final modal = GlobalKey<NavigatorState>();

  static const signInEmailPage = '/sign-in/email';
  static const signInEmailLinkPage = '/sign-in/email/link';
  static const signInEmailPasswordPage = '/sign-in/email/password';
  static const signInPhonePage = '/sign-in/phone';
  static const signInVerificationPage = '/sign-in/phone/verification';

  handleAdditionnalRoutes(String route) {}

  static Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    if (settings.name != null) {
      print("[SignInRouter] Route is ${settings.name}");
      switch (settings.name) {
        case signInEmailPage:
          return platformPageRoute(
            builder: (_) => const SignInEmailPage(),
            fullscreenDialog: true,
          );
        case signInEmailLinkPage:
          return platformPageRoute(
            builder: (_) => const SignInEmailLinkPage(),
            fullscreenDialog: true,
          );
        case signInEmailPasswordPage:
          return platformPageRoute(
            builder: (_) => const SignInEmailPasswordPage(),
          );
      }

      return platformPageRoute(
        builder: (_) => Center(
          child: PlatformScaffold(
              body: Center(
                  child: Text(
                      "This app called a page named ${settings.name} but the SignInRouter has not been configured to handle this page."))),
        ),
      );
    }
    return null;
  }

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) =>
      _onGenerateRoute(settings);
}

class SignInRouterX extends SignInRouter {
  static const signInLandingPage = '/sign-in';
  static const signInProfile = '/sign-in/profile';

  @override
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    SignInRouter._onGenerateRoute(settings);
    print("[SignInRouterX] Route is ${settings.name}");
    switch (settings.name) {
      case signInLandingPage:
        return platformPageRoute(
          builder: (_) =>
              PlatformScaffold(body: Center(child: Text("Landing"))),
        );
      case signInProfile:
        return platformPageRoute(
          builder: (_) =>
              PlatformScaffold(body: Center(child: Text("profile"))),
        );
    }
  }
}

class SignInNavigator extends StatelessWidget {
  const SignInNavigator({
    Key? key,
    this.theme,
    this.localizations,
    required this.authSettings,
    required this.landingPage,
    this.handleAdditionnalRoutes,
  }) : super(key: key);

  final SignInTheme? theme;
  final SignInLocalizations? localizations;
  final AuthSettings authSettings;
  final Widget landingPage;
  final Function(String route)? handleAdditionnalRoutes;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        authSettingsProvider.overrideWithValue(authSettings),
        if (theme != null) signInThemeProvider.overrideWithValue(theme!),
        if (localizations != null)
          signInLocalizationsProvider.overrideWithValue(localizations!),
      ],
      child: Navigator(
        key: SignInRouter.main,
        initialRoute: SignInRouterX.signInLandingPage,
        onGenerateRoute: SignInRouterX.onGenerateRoute,
      ),
    );
  }
}
