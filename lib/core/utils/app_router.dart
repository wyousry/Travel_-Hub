import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hub/features/ai_camera/ai_camera.dart';
import 'package:travel_hub/features/auth/login/presentation/views/login_screen.dart';
import 'package:travel_hub/features/auth/register/view/register_screen.dart';
import 'package:travel_hub/features/welcome/welcome_screen.dart';
import 'package:travel_hub/navigation/land_mark/data/carousel_slider_cubit/carousel_slider_cubit.dart';
import 'package:travel_hub/navigation/land_mark/data/cubit/land_mark_cubit.dart';
import 'package:travel_hub/navigation/land_mark/land_mark_details_screen.dart';
import 'package:travel_hub/navigation/land_mark/land_mark_screen.dart';
import 'package:travel_hub/navigation/land_mark/models/land_mark_model.dart';
import 'package:travel_hub/navigation/home/home_screen.dart';
import 'package:travel_hub/navigation/hotels/booking/book_screen.dart';
import 'package:travel_hub/navigation/hotels/data/cubit/hotels_cubit.dart';
import 'package:travel_hub/navigation/hotels/hotels_screen.dart';
import 'package:travel_hub/features/splash/splash_screen.dart';
import 'package:travel_hub/navigation/hotels/hotels_screen_details.dart';
import 'package:travel_hub/navigation/hotels/models/hotels_model.dart';
import 'package:travel_hub/navigation/main_screen.dart';
import 'package:travel_hub/navigation/maps/full_map_screen.dart';


abstract class AppRouter {
  static const kWelcomeView = '/welcomeView';
  static const kLoginView = '/loginView';
  static const kRegisterView = '/registerView';
 

  //Navigation Feature
  static const kNavigationView = '/navigation';
  static const kMapView = '/mapView';
  //Home Feature
  static const kHomeView = '/home';
  static const kCameraView = '/cameraView';

  //Hotels Feature
  static const kHotelsView = '/hotels';
  static const kBookView = '/book';
   static const kHotelsDetailsView = '/details';
  //Land Mark Feature
  static const kLandMarkView = '/landMark';
  static const kLandMarkDetailsView = '/marksDetails';


  static final routers = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(path:kWelcomeView, builder: (context, state) => const TravelWelcomeScreen()),
      GoRoute(
        path: kLoginView,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
      path: kRegisterView,
       builder: (context, state) => const RegisterScreen(),
       ),

      //Home Feature
      GoRoute(path: kHomeView, builder: (context, state) => const HomeScreen()),
      GoRoute(path: kCameraView, builder: (context, state) => const AiCamera()),

      //Navigation Feature
      GoRoute(
        path: kNavigationView,
        builder: (context, state) => const MainScreen(),
      ),

      GoRoute(
        path: kMapView,
        builder: (context, state) => const FullMapScreen(),
      ),

   GoRoute(
        path: kHotelsView,
        builder: (context, state) => BlocProvider(
          create: (context) => HotelsCubit()..loadHotels(),
          child: const HotelsScreen(),
        ),
      ),
            GoRoute(
        path: kHotelsDetailsView,
        builder: (context, state) {
          final hotels = state.extra as Hotels;
          return HotelsScreenDetails(hotels);
        },
      ),
      GoRoute(
        path: kLandMarkView,
        builder: (context, state) => BlocProvider(
          create: (context) => LandMarkCubit()..loadLandMark(),
          child: const LandMarkScreen(),
        ),
      ),
      GoRoute(
        path: kLandMarkDetailsView,
        builder: (context, state) {
          final landMark = state.extra as LandMark;
          return BlocProvider(
            create: (context) => CarouselSliderCubit(),
            child: LandMarkDetailsScreen(landMark),
          );
        },
      ),

      GoRoute(path: kBookView, builder: (context, state) => const BookScreen()),
    ],
  );
}
