// screen/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:katarasa/components/card_banner_promo_product.dart';
import 'package:katarasa/components/card_cari_suka_components.dart';
import 'package:katarasa/components/home_menu_components.dart';
import 'package:katarasa/constants/constants.dart';
import 'package:katarasa/services/products/product_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset > 50 && !_isScrolled) {
      setState(() {
        _isScrolled = true;
      });
    } else if (_scrollController.offset <= 50 && _isScrolled) {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
        child: Container(
          // Container pembungkus untuk background full
          decoration: BoxDecoration(
            color: _isScrolled ? Colors.white : Colors.transparent,
            boxShadow: _isScrolled
                ? [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 3,
                    )
                  ]
                : [],
          ),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        // spreadRadius: 1,
                        // blurRadius: 5,
                        // offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                      decoration: InputDecoration(
                    hintText: 'Cari menu favoritmu...',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey[400],
                    ),
                    // suffixIcon: IconButton(
                    //   icon: Icon(
                    //     Icons.filter_list,
                    //     color: Colors.grey[400],
                    //   ),
                    //   onPressed: () {},
                    // ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  )),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/Banner.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.075,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 1,
                              ),
                            ],
                            color: Colors.red[200],
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: FutureBuilder<String?>(
                              future: Constants().read(key: 'token'),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }

                                return Text(
                                  snapshot.data ?? '',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                );
                              }),
                        ),
                        SizedBox(height: 10),
                        DeliveryOptions(),
                        SizedBox(height: 10),
                        MenuOptions(),
                        SizedBox(height: 20),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.15,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/img/Banner_app1.png'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                "Cari yang kamu suka",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[50],
                                padding: EdgeInsets.symmetric(
                                    horizontal: 11, vertical: 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              child: Text(
                                "Lihat Semua",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Colors.green,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: FutureBuilder<dynamic>(
                            future:
                                ApiProduct().getProductList(category: 'coffe'),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Container(
                                    padding: EdgeInsets.all(16),
                                    child: CircularProgressIndicator());
                              }

                              final products =
                                  snapshot.data['data']['products'];

                              return Row(
                                children: products.map<Widget>((product) {
                                  return CardCariSuka(
                                    imagePath: product['images'],
                                    productName: product['name'],
                                    price: product['price'].toString(),
                                    rating: product['quantity_available']
                                        .toString(),
                                    sold: '0+',
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 3.6,
                    color: const Color.fromARGB(255, 4, 102, 9),
                    child: Row(
                      children: [
                        Padding(padding: EdgeInsets.all(5)),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Image(
                            image: AssetImage('assets/img/banner-product1.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: FutureBuilder<dynamic>(
                                  future: ApiProduct().getProductList(
                                      category: "tea", limit: 10),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Container(
                                          padding: EdgeInsets.all(16),
                                          child: CircularProgressIndicator());
                                    }

                                    if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    }

                                    final products = snapshot.data?['data']
                                            ?['products'] ??
                                        [];

                                    return Row(
                                      children: products.map<Widget>((product) {
                                        return CardProductPromo(
                                          imagePath: product['images'] ??
                                              'assets/img/product2.png',
                                          productName: product['name'] ?? '',
                                          price: product['price'].toString(),
                                          rating: product['quantity_available']
                                                  ?.toString() ??
                                              '0',
                                          sold: '100+',
                                        );
                                      }).toList(),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                "Promo Termurah",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[50],
                                padding: EdgeInsets.symmetric(
                                    horizontal: 11, vertical: 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              child: Text(
                                "Lihat Semua",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Colors.green,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              CardCariSuka(
                                imagePath: 'assets/img/product1.png',
                                productName: 'Kopi Susu',
                                price: '50.000',
                                rating: '4.5',
                                sold: '100+',
                              ),
                              SizedBox(width: 16),
                              CardCariSuka(
                                imagePath: 'assets/img/product1.png',
                                productName: 'Kopi Susu',
                                price: '50.000',
                                rating: '4.5',
                                sold: '100+',
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
