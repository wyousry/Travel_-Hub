import 'package:go_router/go_router.dart';
import 'package:travel_hub/features/auth/login/login_screen.dart';
import 'package:travel_hub/features/home/home_screen.dart';
import 'package:travel_hub/features/splash/splash_screen.dart';

abstract class AppRouter {
  static const kLoginView = '/loginView';
  static const kRegisterOneView = '/registerOneView';
  static const kRegisterTwoView = '/registerTwoView';
  static const kRegisterThreeView = '/registerThreeView';
  //Home Feature
  static const kHomeView = '/homeStudentView';





  static final routers = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
     GoRoute(path: kLoginView, builder: (context, state) => const LoginScreen()),
     // GoRoute(
        //path: kRegisterOneView,
       // builder: (context, state) => const RegisterOneView(),
    //  ),

      //Home Feature
      GoRoute(
        path: kHomeView,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
