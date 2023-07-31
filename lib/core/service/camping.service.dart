import 'package:campings_app/core/api/supabase.api.dart';
import 'package:campings_app/core/models/camping.model.dart';
import 'package:campings_app/core/service/maps.service.dart';

class CampingService {
  Future<List<CampingModel>> getAllCampings() async {
    var response = await SupabaseAPI.supabaseClient.from("campings").select();
    List<CampingModel> campingList = (response as List<dynamic>)
        .map((element) => CampingModel.fromJson(element))
        .toList();
    return campingList;
  }

  Future<CampingModel> getSpecificCamping({required int campingId}) async {
    var response = await SupabaseAPI.supabaseClient
        .from("campings")
        .select()
        .eq("camping_id", campingId)
        .single();
    var amresponse = await SupabaseAPI.supabaseClient
        .from("camping_amenities")
        .select("amenities(*)")
        .eq("camping_id", campingId);
    CampingModel camping = CampingModel.fromJson(response);
    for (var item in amresponse) {
      camping.addAmenity(
          item["amenities"]["display_name"], item["amenities"]["image_path"]);
    }
    return camping;
  }

  Future<List<CampingModel>> getSearchCampings(
      {required String campingName}) async {
    var response = await SupabaseAPI.supabaseClient
        .from("campings")
        .select()
        .textSearch('camping_name', campingName);
    List<CampingModel> campingList = (response as List<dynamic>)
        .map((element) => CampingModel.fromJson(element))
        .toList();
    return campingList;
  }

  Future<List<CampingModel>> getNearbyCampings() async {
    var response = await SupabaseAPI.supabaseClient.rpc('nearby_campings',
        params: {
          'lat': MapsService().intialLat,
          'long': MapsService().intialLong
        });
    List<CampingModel> campingList = (response as List<dynamic>)
        .map((element) => CampingModel.fromJson(element))
        .toList();
    return campingList;
  }
}
