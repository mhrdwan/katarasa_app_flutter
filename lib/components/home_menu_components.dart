// components/home_menu_components.dart
import 'package:flutter/material.dart';

class DeliveryOptions extends StatelessWidget {
  const DeliveryOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildDeliveryItem(
            Icons.delivery_dining,
            'Delivery',
            Colors.orange[700]!,
            context,
          ),
          Container(
            height: 40,
            width: 1,
            color: Colors.grey[200],
          ),
          _buildDeliveryItem(
            Icons.storefront_rounded,
            'Pick Up',
            Colors.blue[700]!,
            context,
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryItem(
      IconData icon, String label, Color color, BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.35,
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 24,
                color: color,
              ),
            ),
            SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuOptions extends StatelessWidget {
  const MenuOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        'icon': Icons.local_fire_department_rounded,
        'label': 'New Menu',
        'color': Colors.red[700],
        'gradient': [Colors.red[400]!, Colors.red[700]!]
      },
      {
        'icon': Icons.flash_on_rounded,
        'label': 'Flash Sale',
        'color': Colors.amber[700],
        'gradient': [Colors.amber[400]!, Colors.amber[700]!]
      },
      {
        'icon': Icons.stars_rounded,
        'label': 'Mission',
        'color': Colors.purple[700],
        'gradient': [Colors.purple[400]!, Colors.purple[700]!]
      },
      {
        'icon': Icons.local_offer_rounded,
        'label': 'Voucher',
        'color': Colors.green[700],
        'gradient': [Colors.green[400]!, Colors.green[700]!]
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: menuItems
            .map((item) => _buildMenuItem(
                  item['icon'],
                  item['label'],
                  item['color'],
                  item['gradient'],
                ))
            .toList(),
      ),
    );
  }

  Widget _buildMenuItem(
      IconData icon, String label, Color color, List<Color> gradient) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradient,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 26,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}
