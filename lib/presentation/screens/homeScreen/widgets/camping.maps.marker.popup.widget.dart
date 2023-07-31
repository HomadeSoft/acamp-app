import 'package:campings_app/app/constants/app.values.dart';
import 'package:campings_app/app/routes/app.routes.dart';
import 'package:campings_app/core/models/camping.model.dart';
import 'package:campings_app/presentation/screens/campingScreen/camping.screen.dart';
import 'package:flutter/material.dart';

class CampingMarkerPopup extends StatelessWidget {
  const CampingMarkerPopup({Key? key, required this.camping}) : super(key: key);
  final CampingModel camping;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Values.corners),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(camping.campingPhotos[0], width: 200),
              ),
            ),
            Text(camping.campingName),
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRouter.campingDetailRoute,
                  arguments: CampingScreenArgs(
                    campingId: camping.campingId,
                  ),
                );
              },
              icon: const Icon(Icons.info_outline),
            ),
          ],
        ),
      ),
    );
  }
}
