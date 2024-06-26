import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idealmart/src/bloc/product/product_bloc.dart';
import 'package:idealmart/src/bloc/product/product_event.dart';
import 'package:idealmart/src/bloc/product/product_state.dart';
import 'package:idealmart/src/services/product_service.dart';
import 'package:idealmart/src/widgets/product_card.dart';

class FilteredProductsScreen extends StatefulWidget {
  final String category;

  const FilteredProductsScreen({required this.category, Key? key})
      : super(key: key);

  @override
  _FilteredProductsScreenState createState() => _FilteredProductsScreenState();
}

class _FilteredProductsScreenState extends State<FilteredProductsScreen> {
  late ProductBloc _productBloc;

  @override
  void initState() {
    super.initState();
    _productBloc = ProductBloc(productService: ProductService());
    _productBloc.add(FetchProductsByCategory(category: widget.category));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.category} Products',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF275F61),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocProvider(
        create: (context) => _productBloc,
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProductLoaded) {
              return GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return ProductCard(
                    imageUrl:
                        'https://cdn-icons-png.flaticon.com/128/415/415733.png', // Assuming `imageUrl` is a property of Product
                    productName: product.name,
                    price: product.price,
                    offerPrice: product.discountPrice,
                    description: '',
                    rating: 0,
                    unit: '',
                  );
                },
              );
            } else if (state is ProductError) {
              return Center(child: Text(state.message));
            }
            return Center(child: Text('No products available'));
          },
        ),
      ),
    );
  }
}
