import 'package:campings_app/app/constants/app.colors.dart';
import 'package:campings_app/core/models/camping.model.dart';
import 'package:campings_app/core/notifiers/camping.notifier.dart';
import 'package:campings_app/core/notifiers/theme.notifier.dart';
import 'package:campings_app/presentation/screens/campingScreen/widgets/camping.widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CampingScreen extends StatelessWidget {
  final CampingScreenArgs campingScreenArgs;
  const CampingScreen({Key? key, required this.campingScreenArgs})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeNotifier =
        Provider.of<ThemeNotifier>(context, listen: true);
    var themeFlag = themeNotifier.darkTheme;
    return Scaffold(
      backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
      body: Center(
        child: SingleChildScrollView(
          child: Consumer<CampingNotifier>(
            builder: (context, notifier, _) {
              return FutureBuilder(
                future: notifier.getSpecificCamping(
                    campingId: campingScreenArgs.campingId),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    CampingModel camping = snapshot.data;
                    return buildCampingData(
                      context: context,
                      campingModel: camping,
                      themeFlag: themeFlag,
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class CampingScreenArgs {
  final dynamic campingId;

  CampingScreenArgs({
    required this.campingId,
  });
}
