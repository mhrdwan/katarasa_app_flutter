// components/card_cari_suka_components.dart
import 'package:flutter/material.dart';
import 'package:katarasa/screen/detail_products/detail_product_screen.dart';

class CardCariSuka extends StatefulWidget {
  final String imagePath;
  final String productName;
  final String price;
  final String rating;
  final String sold;

  const CardCariSuka({
    super.key,
    required this.imagePath,
    required this.productName,
    required this.price,
    required this.rating,
    required this.sold,
  });

  @override
  State<CardCariSuka> createState() => _CardCariSukaState();
}

class _CardCariSukaState extends State<CardCariSuka> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Detail_Products(
                  name: widget.productName, gambar: widget.imagePath),
            ));
      },
      child: Container(
        width: 160,
        margin: EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: AspectRatio(
                aspectRatio: 1,
                child: widget.imagePath.startsWith('http')
                    ? Image.network(
                        widget.imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/img/default_product.png',
                            fit: BoxFit.cover,
                          );
                        },
                      )
                    : Image.asset(
                        widget.imagePath,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productName,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Rp ${widget.price}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.red[600],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 14,
                        color: Colors.amber,
                      ),
                      Text(
                        ' ${widget.rating}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        ' • ',
                        style: TextStyle(
                          color: Colors.grey[400],
                        ),
                      ),
                      Text(
                        'Terjual ${widget.sold}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
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
