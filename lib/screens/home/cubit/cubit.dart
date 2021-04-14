import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/screens/home/cubit/states.dart';

class LocationCubit extends Cubit<LocationStates> {
  LocationCubit() : super(LocationStateInitial());

  static LocationCubit get(context) => BlocProvider.of(context);
}
