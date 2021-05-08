import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wasla/screens/home/cubit/states.dart';
import 'package:wasla/screens/search/cubit/cubit.dart';
import 'package:wasla/shared/network/network.dart';

class LocationCubit extends Cubit<LocationStates> {
  LocationCubit() : super(LocationStateInitial());

  static LocationCubit get(context) => BlocProvider.of(context);

  String readableAddress = "";
  Position currentPos;
  GoogleMapController mainController;
  double mapPadding = 310;
  double searchBarHeight = 300;
  double requestBarHeight = 0;
  bool isBackButton = false;
  bool isRequested = false;

  void moveToCureentLocation(Completer<GoogleMapController> _controller) async {
    LocationPermission permission = await Geolocator.checkPermission();
    print(permission);
    Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    currentPos = position;
    LatLng cameraPosition = LatLng(position.latitude, position.longitude);

    CameraPosition myPosition =
        CameraPosition(target: cameraPosition, zoom: 14);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(myPosition));
    mainController = controller;
    String address = await getNamedLocation(position);

    readableAddress = address;
    print(address);
  }

  Future<String> getNamedLocation(Position position) async {
    String placeAddress = "";
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      emit(LocationStateFailed());
      return placeAddress;
    }
    emit(LocationStateNetworkSuccess());
    String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=AIzaSyCORdT7v6fwbupqmdkSg_-q6nc7m9FVESw';
    var response = await getRequest(Uri.parse(url));
    if (response != "Failed") {
      placeAddress = response['results'][0]['formatted_address'];
    } else {
      emit(LocationStateFailed());
    }
    emit(LocationStateSuccess());
    return placeAddress;
  }

  refresh() {
    emit(LocationStateBoundRefresh());
  }

  showRequestCarContainer() {
    searchBarHeight = 0;
    requestBarHeight = 270;
    mapPadding = 280;
    emit(LocationStateBoundRefresh());
  }

  backButtonFunction(BuildContext context) {
    SearchCubit.get(context).polylines.clear();
    SearchCubit.get(context).markers.clear();
    SearchCubit.get(context).latlngs.clear();
    SearchCubit.get(context).destinationName = "";
    SearchCubit.get(context).OriginName = "";
    searchBarHeight = 300;
    requestBarHeight = 0;
    mapPadding = 310;
    isBackButton = false;
    emit(LocationStateClearData());
  }

  requestaRide() {
    isRequested = !isRequested;
    emit(LocationStateRequestaRide());
  }
}
