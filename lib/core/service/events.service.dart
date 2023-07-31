import 'package:campings_app/core/api/supabase.api.dart';
import 'package:campings_app/core/models/events.model.dart';

class EventsService {
  Future<List<EventsModel>> getAllEvents() async {
    var response = await SupabaseAPI.supabaseClient.from("events").select();
    List<EventsModel> eventsList = (response as List<dynamic>)
        .map((element) => EventsModel.fromJson(element.data))
        .toList();
    return eventsList;
  }
}
