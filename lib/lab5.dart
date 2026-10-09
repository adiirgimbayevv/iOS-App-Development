import 'package:flutter/material.dart';

void main(){
  runApp(const SportNutritionApp());

}

class SportNutritionApp extends StatelessWidget{
  const SportNutritionApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Sport Nutrition Store",
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const ProductDetailScreen(),
    );
  }
}

class ProductDetailScreen extends StatefulWidget{
  const  ProductDetailScreen({super.key});

  @override

    State<ProductDetailScreen> createState()=>_ProductDetailScreenState();

}

class _ProductDetailScreenState extends State<ProductDetailScreen>{
  bool _isBookMarked=false;

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        centerTitle: true,
      ),
      body: SafeArea(child: Column(
        children: [
          Expanded(child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.network('https://ir.ozone.ru/s3/multimedia-1-u/7167560646.jpg',
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context,error,StackTrace){
                        return Container(
                          height: 250,
                          width: double.infinity,
                          color: Colors.deepPurple,
                          child: const Icon(
                            Icons.fitness_center,
                            size: 120,
                            color: Colors.deepPurple,
                          ),
                        );
                      },),),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon:Icon(
                            _isBookMarked?Icons.bookmark:Icons.bookmark_border,
                            color: Colors.deepPurple,
                          ),
                          onPressed: (){
                            setState(() {
                              _isBookMarked= !_isBookMarked;
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const[
                    Expanded(child: Text('WHEY Gold Protein', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold
                    ),
                    ),),SizedBox(width: 8),
                    Text('4 990 ₸',
                    style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple,

                    ),),
                  ],
                ),
                const SizedBox(height: 8),

                Row(
                  children: const[
                    Icon(Icons.star, color:Colors.amber, size: 20),
                    SizedBox(width: 4),
                    Text('4.9', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,
                    ),), SizedBox(width: 6),
                    Text('(67 reviews)', style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: const[
                    Chip(label: Text('Protein')),
                    Chip(label: Text('3.0 kg')),
                    Chip(label: Text('Banana')),
                    Chip(label: Text('27g pr')),
                    Chip(label: Text('Magnesium 0.67g')),
                    
                  ],
                ),
                const SizedBox(height: 16),

                const Text(
                  'Description',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),

                ),
                const SizedBox(height: 8),
                const Text('BUY IT NOW', style: TextStyle(color: Colors.black54, height: 1.4),),

              ],
            ),
          ),),

          Container(padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color:Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),),
              
            ],
          ),
          child: Row(
            children: [
              Expanded(child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                onPressed: (){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Product added to Korzina'), duration: Duration(seconds: 2),),

                  );
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Korzinaga', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              ),),
            ],
          ),),
        ],
      ),),
    );
  }
}
