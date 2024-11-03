import 'package:flutter/material.dart';
import 'package:ecommerce_app/Components/product.dart';
import 'package:ecommerce_app/Components/navbar.dart';

const List<Widget> UPI = [
  Text('Google Pay'),
  Text('Amazon Pay'),
  Text('Credit Card/Debit Card'),
  Text('EMI'),
  Text('Net Banking'),
  Text('Cash on Delivery')
];

class Buy extends StatefulWidget {
  final Product product;

  const Buy({super.key, required this.product});

  @override
  _BuyState createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  final List<bool> _selected = <bool>[true, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Checkout',
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      //bottomNavigationBar: Navbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(widget.product.image, height: 80),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.product.price,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.orange,
                        ),
                      ),
                      const Text(
                        'Including taxes and duties',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Select your payment method',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ToggleButtons(
                  direction: Axis.vertical,
                  onPressed: (int index) {
                    setState(() {
                      _selected[index] = !_selected[index];
                      for (int i = 0; i < _selected.length; i++) {
                        if (i != index) {
                          _selected[i] = false;
                        }
                      }
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedBorderColor: Colors.orange,
                  selectedColor: Colors.white,
                  fillColor: Colors.orangeAccent,
                  color: Colors.grey,
                  isSelected: _selected,
                  children: UPI,
                  //padding: EdgeInsets.symmetric(vertical: 8.0),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
