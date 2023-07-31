import 'package:cached_network_image/cached_network_image.dart';
import 'package:campings_app/app/constants/app.colors.dart';
import 'package:campings_app/app/constants/app.values.dart';
import 'package:campings_app/core/models/events.model.dart';
import 'package:flutter/material.dart';

class EventsItem extends StatelessWidget {
  const EventsItem({Key? key, this.onTap, required this.eventsModel})
      : super(key: key);

  final GestureTapCallback? onTap;
  final EventsModel eventsModel;

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height / 815;
    double totalWidth = MediaQuery.of(context).size.width / 375;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: totalHeight * 205,
        width: totalWidth * 375,
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Values.corners),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: eventsModel.eventImage,
                imageBuilder: (context, imageProvider) => Container(
                  height: totalHeight * 205,
                  width: totalWidth * 375,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              Container(
                height: totalHeight * 205,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    stops: const [0.5, 0.8],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.6),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: 115,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventsModel.eventType,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: totalHeight * 12,
                      ),
                    ),
                    Text(
                      eventsModel.eventName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: totalHeight * 14,
                      ),
                    ),
                    Text(
                      '${eventsModel.eventLocation} , ${eventsModel.eventDate}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: totalHeight * 12,
                      ),
                    ),
                    Text(
                      '₹ ${eventsModel.eventCharges.toString()} Per Head',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.yellowish,
                        fontSize: totalHeight * 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
