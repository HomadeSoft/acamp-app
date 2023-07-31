import 'package:campings_app/core/models/camping.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class CampingMarker extends Marker {
  CampingMarker({required this.camping})
      : super(
          anchorPos: AnchorPos.align(AnchorAlign.top),
          height: 60,
          width: 60,
          point: LatLng(camping.campingLat, camping.campingLong),
          builder: (BuildContext ctx) => const Icon(
            Icons.place_rounded,
            color: Colors.deepOrange,
            size: 50,
          ),
        );

  final CampingModel camping;
}
