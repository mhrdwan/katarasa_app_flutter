// screen/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:katarasa/components/bottom_navbar_componrnts.dart';
import 'package:katarasa/components/card_banner_promo_product.dart';
import 'package:katarasa/components/card_cari_suka_components.dart';
import 'package:katarasa/components/home_menu_components.dart';
import 'package:katarasa/constants/constants.dart';
import 'package:katarasa/screen/topup/topup_screen.dart';
import 'package:katarasa/services/products/product_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  int _currentIndex = 0;
  String _saldoSaya = "0";
  int _saldoSayaInt = 1;

  List<dynamic> coffeeProducts = [];
  List<dynamic> teaProducts = [];
  List<dynamic> promoProducts = [];
  bool _isLoading = true;

  Future<void> _initializeSaldo() async {
    final saldo = await Constants().read(key: 'saldo');
    double saldoNumber = Constants().parseSaldo(saldo ?? '0');
    setState(() {
      _saldoSaya = saldo ?? '0';
      _saldoSayaInt = saldoNumber.toInt();
    });
    print(_saldoSayaInt);
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    fetchInitialData();
    _initializeSaldo();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  // Fetch data sekali saat inisialisasi
  Future<void> fetchInitialData() async {
    try {
      final coffeeResponse =
          await ApiProduct().getProductList(category: 'coffe');
      final teaResponse =
          await ApiProduct().getProductList(category: "tea", limit: 10);
      final promoResponse =
          await ApiProduct().getProductList(limit: 10, page: 2);

      if (mounted) {
        setState(() {
          coffeeProducts = coffeeResponse['data']['products'];
          teaProducts = teaResponse['data']['products'];
          promoProducts = promoResponse['data']['products'];
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _scrollListener() {
    final bool isNowScrolled = _scrollController.offset > 50;
    if (isNowScrolled != _isScrolled) {
      setState(() {
        _isScrolled = isNowScrolled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          // Navigasi antar halaman
          switch (index) {
            case 0:
              // Sudah di Home
              break;
            case 1:
              // Navigator.push(context, MaterialPageRoute(
              //   builder: (context) => CartScreen(),
              // ));
              break;
            case 2:
              // Navigator.push(context, MaterialPageRoute(
              //   builder: (context) => OrderScreen(),
              // ));
              break;
            case 3:
              // Navigator.push(context, MaterialPageRoute(
              //   builder: (context) => ProfileScreen(),
              // ));
              break;
          }
        },
      ),
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
        child: Container(
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
            child: Container(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 3,
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
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                                height:
                                    MediaQuery.of(context).size.height * 0.075,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Colors.green[50],
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                Icons.account_balance_wallet,
                                                color: Colors.green,
                                                size: 24,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Saldo Anda',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                                Text(
                                                  _saldoSaya,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    letterSpacing: 0.3,
                                                    height: 1.4,
                                                    color: Color(0xFF1D1B20),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Divider
                                      Container(
                                        height: 30,
                                        width: 1,
                                        color: Colors.grey[300],
                                      ),

                                      // Top Up & Bayar Buttons - tidak berubah
                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            TopUpScreen(
                                                              saldo:
                                                                  _saldoSayaInt,
                                                            )));
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue[50],
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Icon(
                                                      Icons.add_circle_outline,
                                                      color: Colors.blue,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  SizedBox(height: 4),
                                                  Text(
                                                    'Top Up',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey[700],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {},
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color: Colors.orange[50],
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Icon(
                                                      Icons.payment,
                                                      color: Colors.orange,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  SizedBox(height: 4),
                                                  Text(
                                                    'Bayar',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey[700],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              DeliveryOptions(),
                              MenuOptions(),
                              SizedBox(height: 20),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/img/Banner_app1.png'),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      "Cari yang kamu suka",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
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
                              // Ganti FutureBuilder dengan data yang sudah di-fetch
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children:
                                      coffeeProducts.map<Widget>((product) {
                                    return CardCariSuka(
                                      imagePath: product['images'],
                                      productName: product['name'],
                                      price: product['price'].toString(),
                                      rating: product['quantity_available']
                                          .toString(),
                                      sold: '0+',
                                    );
                                  }).toList(),
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
                                  image: AssetImage(
                                      'assets/img/banner-product1.png'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children:
                                            teaProducts.map<Widget>((product) {
                                          return CardProductPromo(
                                            imagePath: product['images'] ??
                                                'assets/img/product2.png',
                                            productName: product['name'] ?? '',
                                            price: product['price'].toString(),
                                            rating:
                                                product['quantity_available']
                                                        ?.toString() ??
                                                    '0',
                                            sold: '100+',
                                          );
                                        }).toList(),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      "Promo Termurah",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
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
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children:
                                      promoProducts.map<Widget>((product) {
                                    return Padding(
                                      padding: EdgeInsets.only(right: 16),
                                      child: CardCariSuka(
                                        imagePath: product['images'],
                                        productName: product['name'],
                                        price: product['price'].toString(),
                                        rating: product['quantity_available']
                                                ?.toString() ??
                                            '0',
                                        sold: '100+',
                                      ),
                                    );
                                  }).toList(),
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
