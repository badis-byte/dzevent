import 'package:dzevent/l10n/app_localizations.dart';
import 'package:dzevent/logic/cubits/auth/auth_cubit.dart';
import 'dart:io';

import 'package:dzevent/logic/cubits/events/events_cubit.dart';
import 'package:dzevent/presentation/screens/event_feed.dart';
import 'package:dzevent/presentation/screens/home.dart';
import 'package:dzevent/presentation/screens/login.dart';
import 'package:dzevent/presentation/screens/signup.dart';
import 'package:dzevent/presentation/screens/welcome.dart';
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
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => EventsCubit()),
        BlocProvider(create: (context) => AccountCubit()),
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
        '/signup': (_) => Signup(),
        '/login': (_) => Login(),
        '/event_feed': (_) => EventFeed(),
        },

      ),
    );
  }
}
