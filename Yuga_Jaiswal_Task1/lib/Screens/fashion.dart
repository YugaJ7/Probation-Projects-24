import 'package:flutter/material.dart';
import 'package:ecommerce_app/Components/product.dart';
import 'package:ecommerce_app/Components/product_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecommerce_app/Components/searchbar.dart';
//import 'package:ecommerce_app/Components/navbar.dart';

class FashionPage extends StatelessWidget {
  const FashionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Searchbar(),
      backgroundColor: Colors.white,
      //bottomNavigationBar: Navbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text("Fashion",
                 style: GoogleFonts.poppins(fontSize: 50.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
                    height: 10, 
                    width:250 , 
                    color: Colors.orange,
                  ),
          const SizedBox(height: 5),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(15.0,0.0,15.0,10.0),
              child:GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: (100/140),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  scrollDirection: Axis.vertical,
                  itemCount: MyProduct.allProducts.length,
                  itemBuilder:(context, index) {
                    final allProducts = MyProduct.allProducts[index];
                    return ProductCard(product : allProducts);
                  },
                )
            ),
          )
        ]
      )
    );
  }
}



class MyProduct {
  static List<Product> allProducts = [
    Product(
      name: 'Peter England',
      price: '\$290',
      image: 'assets/images/f1.jpg'),
      Product(
      name: 'Mufti',
      price: '\$90',
      image: 'assets/images/f2.jpg'),
      Product(
      name: 'Peter England',
      price: '\$99',
      image: 'assets/images/f3.jpg'),
      Product(
      name: 'U.S. Polo Assn.',
      price: '\$500',
      image: 'assets/images/f4.jpg'),
      Product(
      name: 'Allen Solly',
      price: '\$50',
      image: 'assets/images/f5.jpg'),
      Product(
      name: 'Highlander',
      price: '\$100',
      image: 'assets/images/f6.jpg'),
  ];
}