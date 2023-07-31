import 'package:campings_app/presentation/screens/aboutScreen/about.screen.dart';
import 'package:campings_app/presentation/screens/allCampingsScreen/all.campings.screen.dart';
import 'package:campings_app/presentation/screens/bookingScreen/booking.screen.dart';
import 'package:campings_app/presentation/screens/campingScreen/camping.screen.dart';
import 'package:campings_app/presentation/screens/favouriteScreen/favourite.screen.dart';
import 'package:campings_app/presentation/screens/feedbackScreen/feedback.screen.dart';
import 'package:campings_app/presentation/screens/homeScreen/home.screen.dart';
import 'package:campings_app/presentation/screens/loginScreen/login.screen.dart';
import 'package:campings_app/presentation/screens/navigationScreen/navigation.screen.dart';
import 'package:campings_app/presentation/screens/noNetworkScreen/no.network.screen.dart';
import 'package:campings_app/presentation/screens/onBoardingScreen/on.boarding.screen.dart';
import 'package:campings_app/presentation/screens/prevBookingScreen/prev.booking.screen.dart';
import 'package:campings_app/presentation/screens/profileScreen/profile.screen.dart';
import 'package:campings_app/presentation/screens/reviewScreen/review.list.screen.dart';
import 'package:campings_app/presentation/screens/reviewScreen/review.screen.dart';
import 'package:campings_app/presentation/screens/searchScreen/search.screen.dart';
import 'package:campings_app/presentation/screens/settingScreen/setting.screen.dart';
import 'package:campings_app/presentation/screens/signupScreen/signup.screen.dart';
import 'package:campings_app/presentation/screens/splashScreen/splash.screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String onboardingRoute = "/onboard";
  static const String splashRoute = "/splash";
  static const String loginRoute = "/login";
  static const String signupRoute = "/signup";
  static const String navRoute = "/nav";
  static const String homeRoute = "/home";
  static const String settingRoute = "/setting";
  static const String aboutRoute = "/about";
  static const String feedbackRoute = "/feedback";
  static const String reviewRoute = "/review";
  static const String reviewListRoute = "/reviewList";
  static const String campingDetailRoute = "/camping";
  static const String prevbookingRoute = "/prevbooking";
  static const String favRoute = "/fav";
  static const String profileRoute = "/profile";
  static const String searchRoute = "/search";
  static const String bookingRoute = "/bookingF";
  static const String allCampingsRoute = "/allCampings";
  static const String noNetWorkRoute = "/noNet";

  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        {
          return MaterialPageRoute(
            builder: (_) => const SplashScreen(),
          );
        }
      case onboardingRoute:
        {
          return MaterialPageRoute(
            builder: (_) => OnBoardingScreen(),
          );
        }

      case loginRoute:
        {
          return MaterialPageRoute(
            builder: (_) => LoginScreen(),
          );
        }
      case signupRoute:
        {
          return MaterialPageRoute(
            builder: (_) => SignUpScreen(),
          );
        }
      case navRoute:
        {
          return MaterialPageRoute(
            builder: (_) => const NavigationScreen(),
          );
        }
      case homeRoute:
        {
          return MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          );
        }
      case settingRoute:
        {
          return MaterialPageRoute(
            builder: (_) => const SettingScreen(),
          );
        }
      case aboutRoute:
        {
          return MaterialPageRoute(
            builder: (_) => const AboutScreen(),
          );
        }
      case feedbackRoute:
        {
          return MaterialPageRoute(
            builder: (_) => FeedbackScreen(),
          );
        }
      case reviewRoute:
        {
          return MaterialPageRoute(
            builder: (context) => ReviewScreen(
              reviewScreenArgs: ModalRoute.of(context)!.settings.arguments
                  as ReviewScreenArgs,
            ),
            settings: settings,
          );
        }
      case reviewListRoute:
        {
          return MaterialPageRoute(
            builder: (context) => ReviewListScreen(
              campingId: ModalRoute.of(context)!.settings.arguments as int,
            ),
            settings: settings,
          );
        }
      case prevbookingRoute:
        {
          return MaterialPageRoute(
            builder: (_) => const PreviousBookingScreen(),
          );
        }
      case favRoute:
        {
          return MaterialPageRoute(
            builder: (_) => const FavouriteScreen(),
          );
        }
      case searchRoute:
        {
          return MaterialPageRoute(
            builder: (_) => const SearchScreen(),
          );
        }
      case profileRoute:
        {
          return MaterialPageRoute(
            builder: (context) => ProfileScreen(
              profileTaskArgs:
                  ModalRoute.of(context)!.settings.arguments as ProfileTaskArgs,
            ),
            settings: settings,
          );
        }
      case campingDetailRoute:
        {
          return MaterialPageRoute(
            builder: (context) => CampingScreen(
              campingScreenArgs: ModalRoute.of(context)!.settings.arguments
                  as CampingScreenArgs,
            ),
            settings: settings,
          );
        }
      case bookingRoute:
        {
          return MaterialPageRoute(
            builder: (context) => BookingScreen(
              bookingScreenArgs: ModalRoute.of(context)!.settings.arguments
                  as BookingScreenArgs,
            ),
            settings: settings,
          );
        }
      case allCampingsRoute:
        {
          return MaterialPageRoute(
            builder: (context) => const AllCampingScreen(),
          );
        }
      case noNetWorkRoute:
        {
          return MaterialPageRoute(
            builder: (context) => const NoNetworkScreen(),
          );
        }
    }
    return null;
  }
}
