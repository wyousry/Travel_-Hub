import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hub/features/ai_camera/ai_camera.dart';
import 'package:travel_hub/features/auth/login/presentation/views/login_screen.dart';
import 'package:travel_hub/navigation/home/home_screen.dart';
import 'package:travel_hub/navigation/hotels/booking/book_screen.dart';
import 'package:travel_hub/navigation/hotels/data/cubit/hotels_cubit.dart';
import 'package:travel_hub/navigation/hotels/hotels_screen.dart';
import 'package:travel_hub/features/splash/splash_screen.dart';
import 'package:travel_hub/navigation/main_screen.dart';
import 'package:travel_hub/navigation/maps/full_map_screen.dart';
import 'package:travel_hub/navigation/places/places_screen.dart';

abstract class AppRouter {
  static const kLoginView = '/loginView';
  static const kRegisterOneView = '/registerOneView';
  static const kRegisterTwoView = '/registerTwoView';
  static const kRegisterThreeView = '/registerThreeView';

  //Navigation Feature
  static const kNavigationView = '/navigation';
  static const kPlacesView = '/placesView';
  static const kMapView = '/mapView';
  //Home Feature
  static const kHomeView = '/home';
  static const kCameraView = '/cameraView';

  //Hotels Feature
  static const kHotelsView = '/hotels';
  static const kBookView = '/book';

  static final routers = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: kLoginView,
        builder: (context, state) => const LoginScreen(),
      ),
      // GoRoute(
      //path: kRegisterOneView,
      // builder: (context, state) => const RegisterOneView(),
      //  ),

      //Home Feature
      GoRoute(path: kHomeView, builder: (context, state) => const HomeScreen()),
      GoRoute(path: kCameraView, builder: (context, state) => const AiCamera()),

      //Navigation Feature
      GoRoute(
        path: kNavigationView,
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: kPlacesView,
        builder: (context, state) => const PlacesScreen(),
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

      GoRoute(path: kBookView, builder: (context, state) => const BookScreen()),
    ],
  );
}
