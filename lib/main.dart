import 'package:flutter/material.dart';
// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:quizapp/routes.dart';
import 'package:quizapp/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

/// We are using a StatefulWidget such that we only create the [Future] once,
/// no matter how many times our widget rebuild.
/// If we used a [StatelessWidget], in the event where [App] is rebuilt, that
/// would re-initialize FlutterFire and make our application re-enter loading state,
/// which is undesired.
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const Center(
            child: Text(
              'error',
              textDirection: TextDirection.ltr,
            ),
          );
        }

        // Once complete, show the application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            routes: appRoutes,
            theme: appTheme,
          );
        }

        // Otherwise, show loading whilst waiting for initialization to complete
        return const Center(
          child: Text(
            'loading...',
            textDirection: TextDirection.ltr,
          ),
        );
      },
    );
  }
}
