import 'package:flutter/material.dart';
import 'package:idealmart/src/ui/pages/product_details_screen.dart';

class LightColor {
  static const Color background = Colors.white;
  static const Color red = Colors.red;
  static const Color orange = Colors.orange;
  static const Color iconColor = Colors.black54;
}

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final double price;
  final double? offerPrice;
  final String description;
  final int rating;
  final String unit;

  const ProductCard({
    required this.imageUrl,
    required this.productName,
    required this.price,
    this.offerPrice,
    required this.description,
    required this.rating,
    required this.unit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(
              imageUrl: imageUrl,
              productName: productName,
              price: price,
              offerPrice: offerPrice,
              description: description,
              rating: rating,
              unit: unit,
            ),
          ),
        );
      },
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: LightColor.background,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 6,
              spreadRadius: 3,
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                child: Image.network(imageUrl, height: 64, width: 64),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: offerPrice != null ? 16 : 14,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '\$${price.toString()}',
                              style: TextStyle(
                                fontSize: offerPrice != null ? 18 : 16,
                                color: Color(0xFF275F61),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 5),
                            if (offerPrice != null)
                              Text(
                                '\$${offerPrice.toString()}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                          ],
                        ),
                        Icon(Icons.chevron_right,
                            color: Colors.green.withOpacity(0.8), size: 24),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
