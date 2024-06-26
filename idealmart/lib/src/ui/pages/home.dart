import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:idealmart/src/bloc/product/product_bloc.dart';
import 'package:idealmart/src/bloc/product/product_event.dart';
import 'package:idealmart/src/bloc/product/product_state.dart';
import 'package:idealmart/src/data/category_data.dart';
import 'package:idealmart/src/data/image_strings.dart';
import 'package:idealmart/src/services/product_service.dart';
import 'package:idealmart/src/ui/common/widgets/search_bar.dart';
import 'package:idealmart/src/ui/pages/profile_screen.dart';
import 'package:idealmart/src/ui/pages/stores_screen.dart';
import 'package:idealmart/src/widgets/category_list.dart';
import 'package:idealmart/src/widgets/image_container.dart';
import 'package:idealmart/src/widgets/product_card.dart';
import 'package:idealmart/src/widgets/section_header.dart';
import 'package:idealmart/src/widgets/app_bnb.dart'; // Add this import

import 'all_products_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userName;

  const HomeScreen({required this.userName, Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  late ProductBloc _productBloc;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _productBloc = ProductBloc(productService: ProductService());
    _productBloc.add(FetchProducts());
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var padding = screenSize.width * 0.02;

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      backgroundColor: const Color(0xFF275F61),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => _productBloc,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 4, horizontal: padding),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Good day for shopping!",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  widget.userName,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              icon: const Icon(Iconsax.notification,
                                  color: Colors.white),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomSearchBar(),
                      const SizedBox(height: 8),
                      Column(
                        children: [
                          SectionHeader(
                            title: "Categories",
                            actionText: "View All",
                            onActionTap: () {
                              // Handle "View All" tap
                            },
                            showAction: false,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 12),
                          CategoryList(categories: categories),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  color: const Color(0XFFFFFFFF),
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: padding, vertical: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeader(
                        title: "Special Deals for You",
                        actionText: "View All",
                        onActionTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AllProductsScreen()),
                          );
                        },
                        showAction: true,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 12),
                      CarouselSlider(
                        items: ImageAssets.sliderImages.map((item) {
                          return Builder(
                            builder: (BuildContext context) {
                              return CustomImageContainer(
                                imageUrl: item,
                                height: screenSize.height * 0.25,
                                width: screenSize.width * 0.8,
                                borderRadius: 12.0,
                              );
                            },
                          );
                        }).toList(),
                        carouselController: _controller,
                        options: CarouselOptions(
                          viewportFraction: 0.9,
                          height: screenSize.height * 0.22,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          pauseAutoPlayOnTouch: true,
                          aspectRatio: 2.0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: ImageAssets.sliderImages
                            .asMap()
                            .entries
                            .map((entry) {
                          return GestureDetector(
                            onTap: () => _controller.animateToPage(entry.key),
                            child: Container(
                              width: _current == entry.key ? 24 : 10,
                              height: 6.0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                color: _current == entry.key
                                    ? const Color(0xFF275F61).withOpacity(0.9)
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 12),
                      buildProductSection("Popular Products"),
                      const SizedBox(height: 12),
                      buildProductSection("Latest Products"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Stores',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          // Navigate to home screen or refresh current screen
          _controller
              .animateToPage(0); // Example: Refresh carousel to the first page
          break;
        case 1:
          // Navigate to stores screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StoreListScreen()),
          );
          break;
        case 2:
          // Navigate to profile screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen()),
          );
          break;
      }
    });
  }

  Widget buildProductSection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: title,
          actionText: "View All",
          onActionTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AllProductsScreen()),
            );
          },
          showAction: true,
          color: Colors.black,
        ),
        const SizedBox(height: 12),
        BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductLoaded) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.24,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.products.take(5).length,
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: ProductCard(
                        imageUrl:
                            'https://cdn-icons-png.flaticon.com/128/415/415733.png',
                        productName: product.name,
                        price: product.price,
                        offerPrice: product.discountPrice,
                        description: '',
                        rating: 0,
                        unit: '',
                      ),
                    );
                  },
                ),
              );
            } else if (state is ProductError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('No products available'));
          },
        ),
      ],
    );
  }
}
