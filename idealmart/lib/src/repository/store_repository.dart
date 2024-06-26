// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:idealmart/src/model/store_model.dart';

// class Repository {
//   Future<List<StoreModel>> getAllStores() async {
//     try {
//       final response = await http
//           .get('https://idealmart.onrender.com/api/v1/idm/store' as Uri);

//       if (response.statusCode == 200) {
//         final List<dynamic> jsonData = json.decode(response.body);
//         List<StoreModel> stores =
//             jsonData.map((e) => StoreModel.fromJson(e)).toList();
//         return stores;
//       } else {
//         throw Exception('Failed to load stores');
//       }
//     } catch (e) {
//       throw Exception('Error fetching stores: $e');
//     }
//   }

//   Future<StoreModel> getStoreDetails(String storeId) async {
//     try {
//       final response = await http.get(
//           'https://idealmart.onrender.com/api/v1/idm/store/$storeId' as Uri);

//       if (response.statusCode == 200) {
//         final jsonData = json.decode(response.body);
//         StoreModel store = StoreModel.fromJson(jsonData);
//         return store;
//       } else {
//         throw Exception('Failed to load store details');
//       }
//     } catch (e) {
//       throw Exception('Error fetching store details: $e');
//     }
//   }
// }
