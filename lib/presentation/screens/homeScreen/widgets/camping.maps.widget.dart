import 'package:campings_app/app/constants/app.strings.dart';
import 'package:campings_app/core/models/camping.model.dart';
import 'package:campings_app/core/service/camping.service.dart';
import 'package:campings_app/core/service/maps.service.dart';
import 'package:campings_app/presentation/screens/homeScreen/widgets/camping.maps.marker.dart';
import 'package:campings_app/presentation/screens/homeScreen/widgets/camping.maps.marker.popup.widget.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class CampingsMap extends StatefulWidget {
  const CampingsMap({
    super.key,
  });

  @override
  State<CampingsMap> createState() => _CampingsMapState();
}

class _CampingsMapState extends State<CampingsMap> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mapsService = Provider.of<MapsService>(context);

    return FutureBuilder<LatLng>(
        future: mapsService.updateLocation(),
        builder: (context, campingSnapshot) {
          if (campingSnapshot.connectionState == ConnectionState.done) {
            return FutureBuilder<List<Marker>>(
                future: getClosebyCamps(),
                builder:
                    (BuildContext buildContext, AsyncSnapshot markersSnapshot) {
                  if (markersSnapshot.connectionState == ConnectionState.done) {
                    final markers = markersSnapshot.data!;
                    markers.add(Marker(
                      point: campingSnapshot.data!,
                      width: 70,
                      height: 70,
                      builder: (context) => const Icon(
                        Icons.person_pin,
                        color: Colors.blueGrey,
                        size: 50,
                      ),
                    ));
                    return FlutterMap(
                        options: MapOptions(
                          zoom: 11,
                          maxZoom: 17,
                          minZoom: 3,
                          center: campingSnapshot.data,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.example.app',
                          ),
                          PopupMarkerLayer(
                            options: PopupMarkerLayerOptions(
                                markers: markers,
                                popupDisplayOptions: PopupDisplayOptions(
                                  builder:
                                      (BuildContext context, Marker marker) {
                                    if (marker is CampingMarker) {
                                      return CampingMarkerPopup(
                                          camping: marker.camping);
                                    }
                                    return const Card(
                                        child: Padding(
                                      padding: EdgeInsets.all(3.0),
                                      child: Text(Strings.hi),
                                    ));
                                  },
                                )),
                          ),
                        ]);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}

Future<List<Marker>> getClosebyCamps() async {
  List<Marker> markers = [];
  List<CampingModel> campings = await CampingService().getNearbyCampings();
  for (var camping in campings) {
    markers.add(CampingMarker(
      camping: camping,
    ));
  }
  return markers;
}
