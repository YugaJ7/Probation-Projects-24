import 'package:ecommerce_app/Screens/fashion.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/Components/scrollproduct.dart';
import 'package:ecommerce_app/Components/searchbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/Screens/home.dart';
import 'package:ecommerce_app/Screens/mobiles.dart';
import 'package:ecommerce_app/Screens/electronics.dart';
import 'package:ecommerce_app/Components/product.dart';

List<String> imgList = [
  'assets/images/sale.jpg',
  'assets/images/sale6.jpg',
  'assets/images/sale5.jpg',
  'assets/images/sale1.jpg',
  'assets/images/sale2.jpg',
  'assets/images/sale3.jpg',
  'assets/images/sale4.jpg',
];
List<Product> hotSalesProducts = [
  Product(name: 'Macbook Air M1', price: '\$29,999', image: 'assets/images/macbook.png'),
  Product(name: 'Mixer', price: '\$90', image: 'assets/images/mixer.jpg'),
  Product(name: 'iPhone 16', price: '\$990', image: 'assets/images/phone.png'),
  Product(name: 'Sony Headphones', price: '\$270', image: 'assets/images/head.png'),
];

List<Product> recentViewedProducts = [
  Product(name: 'iPhone 16', price: '\$990', image: 'assets/images/phone.png'),
  Product(name: 'Sony Headphones', price: '\$270', image: 'assets/images/head.png'),
  Product(name: 'Allen Solly', price: '\$99', image: 'assets/images/f1.jpg'),
  Product(name: 'Macbook Air M1', price: '\$29,999', image: 'assets/images/macbook.png'),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Searchbar(), 
      backgroundColor: Colors.white,
      body: SingleChildScrollView(

        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              //Sales Images
              Container(
                child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    viewportFraction: 1.0,
                    enlargeCenterPage: true
                  ),
                  items: imgList
                  .map((item) => Container(
                    padding: const EdgeInsets.fromLTRB(5.0,10.0,5.0,10.0),
                    child: Container(
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                         image: DecorationImage(
                            
                            image: AssetImage(item),
                            fit: BoxFit.fitWidth
                         )
                      ),
                         // Image.asset(item, fit: BoxFit.cover)),
                    ),
                    )
                )
                  .toList(),
                )
              ),
              
              //Quick Categories Section
              Container(
              padding: const EdgeInsets.fromLTRB(10.0,0.0,10.0,10.0),
              
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    OutlinedButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) => const FashionPage())); 
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        foregroundColor: Colors.black87,
                        minimumSize: const Size(88, 36),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        )
                      ), 
                      child: Text('Fashion'),
                    ),
                    const Padding(padding: EdgeInsets.only(right:12.0)),
                    OutlinedButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) => const HomePage()));
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        foregroundColor: Colors.black87,
                        minimumSize: const Size(88, 36),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        )
                      ), 
                      child: Text('Home'),
                    ),
                    const Padding(padding: EdgeInsets.only(right:12.0)),
                    OutlinedButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) => const MobilePage()));
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        foregroundColor: Colors.black87,
                        minimumSize: const Size(88, 36),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        )
                      ), 
                      child: Text('Mobiles'),
                    ),
                    const Padding(padding: EdgeInsets.only(right:12.0)),
                    OutlinedButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) => const ElectronicsPage()));
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        foregroundColor: Colors.black87,
                        minimumSize: const Size(88, 36),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        )
                      ), 
                      child: Text('Electronics'),
                    ),
                    
                  ],
                ),
              ),
            ),
            // Container(
            //   padding: const EdgeInsets.fromLTRB(10.0,0.0,10.0,10.0),
            //   child: ListView(
            //     scrollDirection: Axis.horizontal,
            //     children: [
            //         OutlinedButton(
            //           onPressed: (){}, 
            //           child: Text('Fashion'),
            //           style: OutlinedButton.styleFrom(
            //             padding: EdgeInsets.symmetric(horizontal: 16),
            //             foregroundColor: Colors.black87,
            //             minimumSize: Size(88, 36),
            //             shape: const RoundedRectangleBorder(
            //               borderRadius: BorderRadius.all(Radius.circular(15)),
            //             )
            //           ),
            //         ),
            //         Padding(padding: EdgeInsets.only(right:12.0)),
            //         OutlinedButton(
            //           onPressed: (){}, 
            //           child: Text('Home'),
            //           style: OutlinedButton.styleFrom(
            //             padding: EdgeInsets.symmetric(horizontal: 16),
            //             foregroundColor: Colors.black87,
            //             minimumSize: Size(88, 36),
            //             shape: const RoundedRectangleBorder(
            //               borderRadius: BorderRadius.all(Radius.circular(15)),
            //             )
            //           ),
            //         ),
            //         Padding(padding: EdgeInsets.only(right:12.0)),
            //         OutlinedButton(
            //           onPressed: (){}, 
            //           child: Text('Mobiles'),
            //           style: OutlinedButton.styleFrom(
            //             padding: EdgeInsets.symmetric(horizontal: 16),
            //             foregroundColor: Colors.black87,
            //             minimumSize: Size(88, 36),
            //             shape: const RoundedRectangleBorder(
            //               borderRadius: BorderRadius.all(Radius.circular(15)),
            //             )
            //           ),
            //         ),
            //         Padding(padding: EdgeInsets.only(right:12.0)),
            //         OutlinedButton(
            //           onPressed: (){}, 
            //           child: Text('Electronics'),
            //           style: OutlinedButton.styleFrom(
            //             padding: EdgeInsets.symmetric(horizontal: 16),
            //             foregroundColor: Colors.black87,
            //             minimumSize: Size(88, 36),
            //             shape: const RoundedRectangleBorder(
            //               borderRadius: BorderRadius.all(Radius.circular(15)),
            //             )
            //           ),
            //         ),
                    
            //       ],
            //   ),
            // ),

            //Hot Sales Text
            Container(
              padding: const EdgeInsets.fromLTRB(10.0,0.0,10.0,10.0),
              child: const Text(
                'Hot sales',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            
            //Hot Sales Products  
            Container(
                padding: const EdgeInsets.fromLTRB(10.0,0.0,10.0,10.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: hotSalesProducts.map((product) => scrollproduct(
                        product: product,
                        allProducts: hotSalesProducts,
                    )).toList()
                  
                  ),

                ),
            ),

            //Recent Text
            Container(
              padding: const EdgeInsets.fromLTRB(10.0,0.0,10.0,10.0),
              child: const Text(
                'Recent Viewed',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            
            //Recent Products  
            Container(
                padding: const EdgeInsets.fromLTRB(10.0,0.0,10.0,10.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: recentViewedProducts.map((product) => scrollproduct(
                        product: product,
                        allProducts: recentViewedProducts,
                    )).toList()

                  ),

                ),
            )
                
          ]
        ),
      ),
    );
  }
}
    
