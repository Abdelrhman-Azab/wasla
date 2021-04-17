import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/screens/search/cubit/states.dart';
import 'package:wasla/shared/network/network.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchStateInitial());

  SearchCubit get(context) => BlocProvider.of(context);
  List<Predictions> predictions = [];

  seachPlace(String placeName) async {
    Uri url = Uri.parse(
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=AIzaSyCORdT7v6fwbupqmdkSg_-q6nc7m9FVESw&sessiontoken=1234567890&components=country:eg");
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
}

class Predictions {
  String placeId;
  String mainPlace;
  String secondPlace;
  Predictions(this.placeId, this.mainPlace, this.secondPlace);
}
