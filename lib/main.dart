import 'package:dzevent/firebase_options.dart';
import 'package:dzevent/l10n/app_localizations.dart';
import 'package:dzevent/logic/cubits/auth/auth_cubit.dart';
import 'dart:io';

import 'package:dzevent/logic/cubits/events/events_cubit.dart';
import 'package:dzevent/logic/cubits/followers/followers_cubits.dart';
import 'package:dzevent/logic/cubits/interests/interests_cubit.dart';
import 'package:dzevent/logic/cubits/notifications/notifications_cubits.dart';
import 'package:dzevent/presentation/screens/assocAdmin.dart';
import 'package:dzevent/presentation/screens/asosciationEventInterests.dart';
import 'package:dzevent/presentation/screens/associationProfileTwo.dart';
import 'package:dzevent/presentation/screens/event_feed.dart';
import 'package:dzevent/presentation/screens/followers.dart';
import 'package:dzevent/presentation/screens/login.dart';
import 'package:dzevent/presentation/screens/my_account_credentials.dart';
import 'package:dzevent/presentation/screens/notifications.dart';
import 'package:dzevent/presentation/screens/signup.dart';
import 'package:dzevent/presentation/screens/user_profile.dart';
import 'package:dzevent/presentation/screens/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isLinux || Platform.isWindows) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  await initMyApp();
  runApp(const MainApp());
}

Future<bool> initFirebaseMessaging() async {
  await firebaseRequestPermission();
  final token = await FirebaseMessaging.instance.getToken();
  print("Firebase token is : $token");
  final topic = "events";
  await FirebaseMessaging.instance.subscribeToTopic(topic);
  print("Subscribed to topic $topic");
  return true;
}

Future<bool> firebaseRequestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print("User garnted permission");
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print("User garnted provisional permission");
  } else {
    print("User declined or has not accepted permission");
  }
  return true;
}

Future<bool> initMyApp() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  initFirebaseMessaging();
  return true;
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => EventsCubit()),
        BlocProvider(create: (context) => AccountCubit()),
        BlocProvider(create: (context) => InterestsCubit()),
        BlocProvider(create: (context) => NotificationsCubit()),
        BlocProvider(create: (context) => FollowCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        //localization
        locale: Locale('en'),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [Locale('en'), Locale('ar'), Locale('fr')],

        home: ImageCarousel(),
        routes: {
          '/admin': (_) => Assocadmin(),
          '/signup': (_) => Signup(),
          '/login': (_) => Login(),
          '/event_feed': (_) => EventFeed(),
          '/assocownprofile': (_) => AssocProfTwo(),
          '/userprofile': (_) => Myaccountcredentials(),
          '/association-interests': (_) => AssociationInterestRequestsPage(),
          'notifications': (_) => NotificationsPage(),
          'followed-feed': (_) => FollowedAssociationsScreen(),
        },

        theme: ThemeData(
          useMaterial3: true,

          dialogTheme: DialogThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.white,
          ),

          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            bodyMedium: TextStyle(fontSize: 16, color: Colors.black54),
          ),

          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            surface: Colors.white,
          ),
        ),
      ),
    );
  }
}
