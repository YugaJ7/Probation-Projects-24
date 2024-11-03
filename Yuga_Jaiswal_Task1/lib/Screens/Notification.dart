import 'package:flutter/material.dart';
class Notify extends StatelessWidget {
  const Notify({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: TextButton(
                onPressed: (){},
                style: TextButton.styleFrom(
                       backgroundColor: Colors.grey[200],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                child: Item(title: "Your order will be \ndelivered by tomorrow", image: 'assets/images/macbook.png'),
                ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: TextButton(
                onPressed: (){},
                style: TextButton.styleFrom(
                       backgroundColor: Colors.grey[200],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                child: Item(title: "40% OFF on Philip\nMixer", image: 'assets/images/mixer.jpg'),
                
                  ),
            ),
            
          ],
        ),
    );
  }
}

class Item extends StatelessWidget {
  final String title;
  final String image;

  const Item({super.key, 
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Row(
         children: [
            Container(
                 width: 100,
                 height: 100,
                 decoration: BoxDecoration(
                 image: DecorationImage(                    
                    image: AssetImage(image),
                    fit: BoxFit.fitWidth
                     )
                  ),
            ),
            const SizedBox(width: 30),
            Text(title,style: TextStyle(fontSize: 16,color: Colors.grey[700]),),
         ],
        ),
        const Row(
          children: [
             Icon(Icons.arrow_forward_ios_rounded,size: 30,color: Colors.grey,),
           ]
        )
       ],
   );
  }
}