import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wasla/models/address.dart';
import 'package:wasla/models/direction.dart';
import 'package:wasla/models/predictions.dart';
import 'package:wasla/screens/search/cubit/states.dart';
import 'package:wasla/shared/network/network.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchStateInitial());

  SearchCubit get(context) => BlocProvider.of(context);

  // predictions that shown on search
  List<Predictions> predictions = [];

  // address of the new place
  Address newAddress = new Address();

  // direction from origin to new place
  Direction direction = new Direction();

  final Set<Marker> markers = {};

  List<LatLng> latlngs = [];

  final Set<Polyline> polylines = {};

  LatLngBounds bounds;

  searchPlace(String placeName) async {
    Uri url = Uri.parse(
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=AIzaSyCORdT7v6fwbupqmdkSg_-q6nc7m9FVESw&sessiontoken=1234567890");
    var data = await getRequest(url);
    if (data == "Failed") {
      emit(SearchStateFailed());
      return;
    } else {
      predictions.clear();
      List dataMap = data["predictions"];
      for (int i = 0; i < dataMap.length; i++) {
        predictions.add(
          Predictions(
            dataMap[i]["place_id"],
            dataMap[i]["structured_formatting"]["main_text"],
            dataMap[i]["structured_formatting"]["secondary_text"],
          ),
        );
      }
      emit(SearchStateSuccess());
    }
  }

  getDetails(String placeid) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeid&key=AIzaSyCORdT7v6fwbupqmdkSg_-q6nc7m9FVESw";
    var result = await getRequest(Uri.parse(url));
    if (result == "Failed") {
      emit(SearchDetailsStateFailed());
      return;
    }
    newAddress.name = result["result"]["name"];
    newAddress.latitude = result["result"]["geometry"]["location"]["lat"];
    newAddress.longitude = result["result"]["geometry"]["location"]["lng"];
    newAddress.id = result["result"]["place_id"];

    emit(SearchDetailsStateSuccess());
  }

  getDirections(LatLng origin, LatLng destination) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&mode=driving&key=AIzaSyCORdT7v6fwbupqmdkSg_-q6nc7m9FVESw";
    var result = await getRequest(Uri.parse(url));
    if (result == "Failed") {
      emit(SearchGetDirectionStateFailed());
      return;
    }
    direction.distanceText = result["routes"][0]["legs"][0]["distance"]["text"];
    direction.distanceValue =
        result["routes"][0]["legs"][0]["distance"]["value"];
    direction.durationText = result["routes"][0]["legs"][0]["duration"]["text"];
    direction.durationValue =
        result["routes"][0]["legs"][0]["duration"]["value"];
    direction.encodedPoint =
        await result["routes"][0]["legs"][0]["steps"][0]["polyline"]["points"];

    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult polyresult = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyCORdT7v6fwbupqmdkSg_-q6nc7m9FVESw",
      PointLatLng(origin.latitude, origin.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.driving,
    );

    latlngs.clear();

    if (polyresult.points.isNotEmpty) {
      polyresult.points.forEach((PointLatLng point) {
        latlngs.add(LatLng(point.latitude, point.longitude));
      });

      Polyline polyline = Polyline(
          polylineId: PolylineId("polyid"),
          endCap: Cap.roundCap,
          startCap: Cap.roundCap,
          jointType: JointType.round,
          points: latlngs,
          width: 4,
          color: Color.fromARGB(255, 95, 109, 237),
          geodesic: true);
      polylines.clear();
      polylines.add(polyline);
      getBounds(origin, destination);

      emit(SearchGetDirectionStateSuccess());
    }
  }

  getBounds(LatLng origin, LatLng destination) {
    if (origin.latitude > destination.latitude &&
        origin.longitude > destination.longitude) {
      bounds = LatLngBounds(southwest: destination, northeast: origin);
    } else if (origin.longitude > destination.longitude) {
      bounds = LatLngBounds(
          southwest: LatLng(origin.latitude, destination.longitude),
          northeast: LatLng(destination.latitude, origin.longitude));
    } else if (origin.latitude > destination.latitude) {
      bounds = LatLngBounds(
          southwest: LatLng(destination.latitude, origin.longitude),
          northeast: LatLng(origin.latitude, destination.longitude));
    } else {
      bounds = LatLngBounds(southwest: origin, northeast: destination);
    }
  }
}
