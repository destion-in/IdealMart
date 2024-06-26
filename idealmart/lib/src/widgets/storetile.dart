import 'package:flutter/material.dart';
import 'package:idealmart/src/model/store_model.dart';

class StoreTile extends StatelessWidget {
  final Store store;

  StoreTile({required this.store});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(store.name),
      subtitle: Text('${store.category} - ${store.city}'),
      leading: CircleAvatar(
        child:
            Text(store.name[0]), // Display the first letter of the store name
      ),
      onTap: () {
        // You can add actions on tap, like navigating to a store detail page
      },
    );
  }
}
