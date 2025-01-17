// screen/detail_products/detail_product_screen.dart
import 'package:flutter/material.dart';

class Detail_Products extends StatefulWidget {
  final String name;
  final String gambar;
  const Detail_Products({super.key, required this.name, required this.gambar});

  @override
  State<Detail_Products> createState() => _Detail_ProductsState();
}

class _Detail_ProductsState extends State<Detail_Products> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        // elevation: 0,
        // iconTheme: IconThemeData(color: Colors.white),
        // flexibleSpace: Container(
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage(widget.gambar),
        //       fit: BoxFit.cover,
        //       alignment: Alignment.topCenter,
        //     ),
        //   ),
        // ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.gambar),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 2.6,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(20), right: Radius.circular(20))),
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
