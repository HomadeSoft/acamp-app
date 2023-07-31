import 'package:campings_app/core/notifiers/authentication.notifier.dart';
import 'package:campings_app/core/notifiers/booking.notifer.dart';
import 'package:campings_app/core/notifiers/camping.notifier.dart';
import 'package:campings_app/core/notifiers/events.notifier.dart';
import 'package:campings_app/core/notifiers/favourite.notifier.dart';
import 'package:campings_app/core/notifiers/feedback.notifier.dart';
import 'package:campings_app/core/notifiers/password.notifier.dart';
import 'package:campings_app/core/notifiers/review.notifier.dart';
import 'package:campings_app/core/notifiers/sorts.notifier.dart';
import 'package:campings_app/core/notifiers/theme.notifier.dart';
import 'package:campings_app/core/service/maps.service.dart';
import 'package:campings_app/core/service/photo.service.dart';
import 'package:campings_app/core/utils/obscure.text.util.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProvider {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => ThemeNotifier()),
    ChangeNotifierProvider(create: (_) => PasswordNotifier()),
    ChangeNotifierProvider(create: (_) => AuthenticationNotifer()),
    ChangeNotifierProvider(create: (_) => ObscureTextUtil()),
    ChangeNotifierProvider(create: (_) => FeedbackNotifier()),
    ChangeNotifierProvider(create: (_) => CampingNotifier()),
    ChangeNotifierProvider(create: (_) => BookingNotifier()),
    ChangeNotifierProvider(create: (_) => EventsNotifier()),
    ChangeNotifierProvider(create: (_) => FavouriteNotifier()),
    ChangeNotifierProvider(create: (_) => PhotoService()),
    ChangeNotifierProvider(create: (_) => SortNotifier()),
    ChangeNotifierProvider(create: (_) => MapsService()),
    ChangeNotifierProvider(create: (_) => ReviewNotifier()),
  ];
}
