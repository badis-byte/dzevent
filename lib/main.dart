import 'package:dzevent/l10n/app_localizations.dart';
import 'package:dzevent/logic/cubits/events/events_cubit.dart';
import 'package:dzevent/presentation/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://yodqxosgbtkvkuctlfxt.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlvZHF4b3NnYnRrdmt1Y3RsZnh0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQyNDAxNTEsImV4cCI6MjA3OTgxNjE1MX0.7mXNcJGdId8SYfoW_W5WibNHCp_2C__g3q_jixoIVAg",
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => EventsCubit())],
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

        home: NavScreen(),
      ),
    );
  }
}
