import 'package:flutter/material.dart';
import 'package:ecommerce_app/Components/product.dart';
import 'package:ecommerce_app/Screens/product_detail.dart';
class scrollproduct extends StatelessWidget {
  final Product product;
  final List<Product> allProducts;
  const scrollproduct({super.key, required this.product, required this.allProducts});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          children: [
            Image.asset(product.image, height: 100), 
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(product.name, style: const TextStyle(fontSize: 16)),
            ),
            Text(product.price, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetail(
                        product: product,allProducts: allProducts)));},
                child: const Text('Free shipping'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}