import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idealmart/src/bloc/store/stores_bloc.dart';
import 'package:idealmart/src/bloc/store/stores_event.dart';
import 'package:idealmart/src/bloc/store/stores_state.dart';
import 'package:idealmart/src/widgets/storetile.dart';

class StoreListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Store List'),
      ),
      body: BlocProvider(
        create: (context) => StoreBloc()..add(FetchStores()),
        child: BlocBuilder<StoreBloc, StoreState>(
          builder: (context, state) {
            if (state is StoreLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is StoreLoaded) {
              return ListView.builder(
                itemCount: state.stores.length,
                itemBuilder: (context, index) {
                  return StoreTile(store: state.stores[index]);
                },
              );
            } else if (state is StoreError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return Center(child: Text('Please fetch stores'));
          },
        ),
      ),
    );
  }
}
