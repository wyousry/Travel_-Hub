import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_hub/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:travel_hub/navigation/hotels/data/cubit/hotels_cubit.dart';
import 'package:travel_hub/navigation/land_mark/data/cubit/land_mark_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HotelsCubit()),
        BlocProvider(create: (_) => LandMarkCubit()),
      ],
      child: EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/translation',
        fallbackLocale: Locale('en'),
        child: MyApp(),
      ),
    ),
  );
}
