// components/home_menu_components.dart
import 'package:flutter/material.dart';

class DeliveryOptions extends StatelessWidget {
  const DeliveryOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.09,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildDeliveryItem(Icons.delivery_dining, 'Delivery', Colors.orange),
          _buildDeliveryItem(
              Icons.store_mall_directory, 'Pick Up', Colors.blue),
        ],
      ),
    );
  }

  Widget _buildDeliveryItem(IconData icon, String label, Color color) {
    return Column(
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
            size: 25,
            color: color,
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class MenuOptions extends StatelessWidget {
  const MenuOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildMenuItem(Icons.new_releases, 'New Menu', Colors.red),
          _buildMenuItem(Icons.flash_on, 'Flash Sale', Colors.amber),
          _buildMenuItem(Icons.stars, 'Mission', Colors.purple),
          _buildMenuItem(Icons.local_offer, 'Voucher', Colors.green),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.1),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Icon(
            icon,
            size: 25,
            color: color,
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
