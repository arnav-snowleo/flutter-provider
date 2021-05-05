import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './constants/theme.dart' as Theme;
import 'providers/auth.dart';
import './providers/bookmarked_stories.dart';
import './providers/liked_stories.dart';
import 'providers/stories.dart';
import 'providers/topics.dart';
import './providers/user.dart';
import './providers/viewed_stories.dart';
import './screens/bookmarked_stories_screen.dart';
import './screens/choose_topics_screen.dart';
import './screens/create_account_screen.dart';
import './screens/email_screen.dart';
import './screens/forgot_password_screen.dart';
import './screens/forgot_password_success_screen.dart';
import './screens/home_screen.dart';
import './screens/liked_stories_screen.dart';
import './screens/login_screen.dart';
import './screens/splash_screen.dart';
import './screens/viewed_stories_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProxyProvider<Auth, User>(
          update: (context, auth, prevUser) => User(auth),
          create: (BuildContext context) => User(null),
        ),
        // ChangeNotifierProvider.value(value: User()),
//         ChangeNotifierProvider.value(value: Topics()),
//         ChangeNotifierProvider.value(value: Stories()),
//         ChangeNotifierProvider.value(value: BookmarkedStories()),
        ChangeNotifierProvider.value(value: LikedStories()),
//         ChangeNotifierProvider.value(value: ViewedStories()),
      ],
      child: Consumer2<Auth, User>(
        builder: (ctx, auth, user, _) => MaterialApp(
          title: 'app',
          theme: Theme.darkTheme,
          home: auth.isAuthenticated
              // ? (user.isNew ? ChooseTopicsScreen() : HomeScreen())
              ? FutureBuilder(
                  future: user.init,
                  builder: (ctx, userResultSnapshot) =>
                      userResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : (user.isNew ? ChooseTopicsScreen() : HomeScreen()),
                )
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : EmailScreen(),
                ),
          // : EmailScreen(),
          routes: {
//             BookmarkedStoriesScreen.id: (context) => BookmarkedStoriesScreen(),
//             ChooseTopicsScreen.id: (context) => ChooseTopicsScreen(),
//             CreateAccountScreen.id: (context) => CreateAccountScreen(),
//             EmailScreen.id: (context) => EmailScreen(),
//             ForgotPasswordScreen.id: (context) => ForgotPasswordScreen(),
//             ForgotPasswordSuccessScreen.id: (context) =>
//                 ForgotPasswordSuccessScreen(),
//             HomeScreen.id: (context) => HomeScreen(),
//             LikedStoriesScreen.id: (context) => LikedStoriesScreen(),
//             LoginScreen.id: (context) => LoginScreen(),
//             SplashScreen.id: (context) => SplashScreen(),
//             ViewedStoriesScreen.id: (context) => ViewedStoriesScreen(),
          },
        ),
      ),
    );
  }
}
