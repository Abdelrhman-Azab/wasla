import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:wasla/screens/home/cubit/cubit.dart';
import 'package:wasla/screens/search/cubit/cubit.dart';
import 'package:wasla/screens/search/cubit/states.dart';
import 'package:wasla/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  static const String id = "search";
  final TextEditingController pickUpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var predictions = SearchCubit().get(context).predictions;

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 230,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 0.5,
                        blurRadius: 5.0,
                        offset: Offset(0.7, 0.7),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 24, bottom: 20, right: 24, top: 48),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Stack(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.arrow_back)),
                            Center(
                              child: Text(
                                "Set Destination",
                                style: TextStyle(
                                    fontFamily: "Bolt-Semibold", fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "images/pickicon.png",
                              height: 16,
                              width: 16,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Container(
                                child: TextField(
                                  controller: pickUpController
                                    ..text = LocationCubit.get(context)
                                        .readableAddress,
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey[200],
                                      filled: true,
                                      border: InputBorder.none,
                                      hintText: "Pickup Location"),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "images/desticon.png",
                              height: 16,
                              width: 16,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Container(
                                child: TextField(
                                  onChanged: (value) {
                                    if (value.length > 1) {
                                      SearchCubit()
                                          .get(context)
                                          .seachPlace(value);
                                    }
                                  },
                                  autofocus: true,
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey[200],
                                      filled: true,
                                      border: InputBorder.none,
                                      hintText: "Where to?"),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    height: 500,
                    child: ListView.separated(
                        padding: EdgeInsets.only(top: 20),
                        itemBuilder: (context, index) {
                          return searchListContainer(
                              mainText: predictions[index].mainPlace,
                              secondaryText: predictions[index].secondPlace);
                        },
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                        itemCount: predictions.length))
              ],
            ),
          ),
        );
      },
    );
  }
}
