import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idealmart/src/bloc/store/stores_event.dart';
import 'package:idealmart/src/bloc/store/stores_state.dart';
import 'package:idealmart/src/model/store_model.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc() : super(StoreInitial()) {
    on<FetchStores>(_onFetchStores);
  }

  Future<void> _onFetchStores(
      FetchStores event, Emitter<StoreState> emit) async {
    try {
      emit(StoreLoading());
      final stores = await fetchStoresFromApi();
      emit(StoreLoaded(stores));
    } catch (e) {
      emit(StoreError(e.toString()));
    }
  }

  Future<List<Store>> fetchStoresFromApi() async {
    final url = 'https://idealmart.onrender.com/api/v1/idm/store';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((store) => Store.fromJson(store)).toList();
    } else {
      throw Exception('Failed to load stores');
    }
  }
}
