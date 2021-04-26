import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:wasla/screens/home/cubit/cubit.dart';
import 'package:wasla/screens/home/cubit/states.dart';
import 'package:wasla/screens/search/cubit/cubit.dart';
import 'package:wasla/screens/search/search_screen.dart';
import 'package:wasla/shared/components/components.dart';
import 'package:wasla/style/brand_colors.dart';
import 'dart:io' show Platform;

class HomeScreen extends StatefulWidget {
  static const String id = 'home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mycontroller;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  CameraPosition currentPosition;

  @override
  Widget build(BuildContext context) {
    var poly = SearchCubit().get(context).polylines;
    print("second poly length ${poly.length}");

    return BlocConsumer<LocationCubit, LocationStates>(
      listener: (context, state) {
        if (state is LocationStateBoundRefresh) {}
      },
      builder: (context, state) {
        return Scaffold(
          drawer: Container(
            width: 250,
            color: Colors.white,
            child: Drawer(
              child: ListView(
                padding: EdgeInsets.all(0),
                children: [
                  DrawerHeader(
                    child: Row(
                      children: [
                        Image.asset(
                          "images/user_icon.png",
                          width: 70,
                          height: 70,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Abdelrhman",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              "View Profile",
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  myListTile(
                      iconData: OMIcons.cardGiftcard, title: "Free Rides"),
                  myListTile(iconData: OMIcons.creditCard, title: "Payments"),
                  myListTile(iconData: OMIcons.history, title: "Ride History"),
                  myListTile(
                      iconData: OMIcons.contactSupport, title: "Support"),
                  myListTile(iconData: OMIcons.info, title: "About"),
                ],
              ),
            ),
          ),
          body: Stack(children: [
            //Google Maps

            GoogleMap(
              padding: EdgeInsets.only(bottom: Platform.isAndroid ? 300 : 270),
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              mapType: MapType.normal,
              polylines: poly,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                mycontroller = controller;
                _controller.complete(controller);

                LocationCubit.get(context).moveToCureentLocation(_controller);
              },
            ),
            //Menu Button

            //Search bar
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Nice to see you!",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          "Where are you going?",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, SearchScreen.id);
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(color: Colors.grey[100]),
                            height: 50,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Colors.blueAccent,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "Search destination",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          height: 60,
                          child: Row(
                            children: [
                              Icon(
                                OMIcons.home,
                                color: BrandColors.colorDimText,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Home",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Sadat city, monofia,egypt",
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Divider(),
                        Container(
                          color: Colors.white,
                          height: 60,
                          child: Row(
                            children: [
                              Icon(
                                OMIcons.workOutline,
                                color: BrandColors.colorDimText,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Work",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Sadat city, monofia,egypt",
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            )
          ]),
        );
      },
    );
  }
}
