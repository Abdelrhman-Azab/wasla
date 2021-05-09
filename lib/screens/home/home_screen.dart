import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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
import 'package:wasla/shared/components/globalVariables.dart';
import 'package:wasla/shared/network/network.dart';
import 'package:wasla/style/brand_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home';

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mycontroller;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  CameraPosition currentPosition;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var _locationCubit = LocationCubit.get(context);
    var poly = SearchCubit.get(context).polylines;
    var googleMarkers = SearchCubit.get(context).markers;

    return BlocConsumer<LocationCubit, LocationStates>(
      listener: (context, state) {
        if (state is LocationStateBoundRefresh) {
          LatLngBounds lngBounds = SearchCubit.get(context).bounds;
          mycontroller
              .animateCamera(CameraUpdate.newLatLngBounds(lngBounds, 80));
        }

        if (state is LocationStateClearData) {
          _locationCubit.moveToCureentLocation(_controller);
        }
      },
      builder: (context, state) {
        int totalTaxes = SearchCubit.get(context).totalMoney;
        getUserInfo();

        return Scaffold(
          key: _scaffoldKey,
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
          body: SafeArea(
            child: Stack(children: [
              //Google Maps

              GoogleMap(
                padding: EdgeInsets.only(bottom: _locationCubit.mapPadding),
                zoomControlsEnabled: true,
                zoomGesturesEnabled: true,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                mapType: MapType.normal,
                polylines: poly,
                markers: googleMarkers,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  mycontroller = controller;
                  _controller.complete(controller);

                  _locationCubit.moveToCureentLocation(_controller);
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
                    height: _locationCubit.searchBarHeight,
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
                              decoration:
                                  BoxDecoration(color: Colors.grey[100]),
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
              ),

              //Request a ride
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: _locationCubit.requestBarHeight,
                  padding: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 15,
                            spreadRadius: 0.5,
                            offset: Offset(0.7, 0.7))
                      ],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  child: _locationCubit.isRequested
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DefaultTextStyle(
                              style: const TextStyle(
                                fontSize: 20.0,
                              ),
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  WavyAnimatedText(
                                    'Requesting a Ride...',
                                    textStyle: TextStyle(
                                        color: Colors.black, fontSize: 26),
                                  ),
                                ],
                                isRepeatingAnimation: true,
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            GestureDetector(
                              onTap: () {
                                _locationCubit.cancelRideRequest(context);
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                        width: 1, color: Colors.grey)),
                                child: Icon(Icons.close, size: 25),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Cancel ride")
                          ],
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 70,
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              color: Colors.green[50],
                              child: Row(
                                children: [
                                  Image.asset(
                                    "images/taxi.png",
                                    height: 70,
                                    width: 70,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "Taxi",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  Text(
                                    "$totalTaxes\$",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.moneyBillAlt,
                                    color: Colors.grey[600],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Cash"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.grey[600],
                                    size: 14,
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                            myElevatedButton(
                              text: "REQUEST CAR",
                              function: () {
                                _locationCubit.requestaRide(context);
                                print(_locationCubit.isRequested);
                              },
                              color: Colors.green[800],
                            )
                          ],
                        ),
                ),
              ),

              // Menu and Back button
              Positioned(
                  top: 10,
                  left: 20,
                  child: GestureDetector(
                    onTap: () {
                      _locationCubit.isBackButton
                          ? _locationCubit.backButtonFunction(context)
                          : _scaffoldKey.currentState.openDrawer();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0.7, 0.7),
                                blurRadius: 5,
                                spreadRadius: 0.5)
                          ]),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          _locationCubit.isBackButton
                              ? Icons.arrow_back
                              : Icons.menu,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ))
            ]),
          ),
        );
      },
    );
  }
}
