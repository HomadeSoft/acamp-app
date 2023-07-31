import 'package:campings_app/app/constants/app.credentials.dart';
import 'package:campings_app/app/constants/app.theme.dart';
import 'package:campings_app/app/provider/app.provider.dart';
import 'package:campings_app/app/routes/app.routes.dart';
import 'package:campings_app/core/notifiers/theme.notifier.dart';
import 'package:campings_app/core/service/network.service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: AppCredentials.supabaseApiUrl,
    anonKey: AppCredentials.supabaseApiKey,
  );
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Map _source = {ConnectivityResult.none: false};
  final MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        return MultiProvider(
          providers: AppProvider.providers,
          child: const Core(),
        );
      case ConnectivityResult.none:
      default:
        return const MaterialApp(
          title: 'Met Camping',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.generateRoute,
          initialRoute: AppRouter.noNetWorkRoute,
        );
    }
  }
}

class Core extends StatelessWidget {
  const Core({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    return Consumer<ThemeNotifier>(
      builder: (context, notifier, _) {
        return MaterialApp(
          title: 'Met Camping',
          theme: notifier.darkTheme ? darkTheme : lightTheme,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.generateRoute,
          initialRoute: AppRouter.splashRoute,
        );
      },
    );
  }
}
