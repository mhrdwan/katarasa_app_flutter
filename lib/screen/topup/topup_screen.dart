// screen/topup/topup_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';

class TopUpScreen extends StatefulWidget {
  final int saldo;
  const TopUpScreen({super.key, this.saldo = 0});

  @override
  State<TopUpScreen> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  // Dummy data for transaction history
  final List<Map<String, dynamic>> transactions = [
    {
      'date': DateTime.now().subtract(Duration(days: 1)),
      'amount': 1000000,
      'type': 'Top Up',
      'status': 'Success'
    },
    {
      'date': DateTime.now().subtract(Duration(days: 2)),
      'amount': 500000,
      'type': 'Top Up',
      'status': 'Success'
    },
    // Add more transaction history items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            height: MediaQuery.of(context).size.height / 2.2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.green[700]!,
                  Colors.green[500]!,
                ],
              ),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      SizedBox(height: MediaQuery.of(context).padding.top + 60),
                      Text(
                        'Rp ${NumberFormat('#,###').format(widget.saldo)}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      SizedBox(height: 25),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.add_circle_outline,
                                  color: Colors.green),
                              label: Text(
                                'Top Up',
                                style: TextStyle(
                                  color: Colors.green[700],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          // SizedBox(width: 12),
                          // Expanded(
                          //   child: ElevatedButton.icon(
                          //     onPressed: () {},
                          //     icon: Icon(Icons.sync, color: Colors.green),
                          //     label: Text(
                          //       'Transfer',
                          //       style: TextStyle(
                          //         color: Colors.green[700],
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //     style: ElevatedButton.styleFrom(
                          //       backgroundColor: Colors.white,
                          //       padding: EdgeInsets.symmetric(vertical: 12),
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(10),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Back button
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          // Balance Card
          // Positioned(
          //   top: MediaQuery.of(context).padding.top + 60,
          //   left: 16,
          //   right: 16,
          //   child: Card(
          //     elevation: 8,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(15),
          //     ),
          //     child: Padding(
          //       padding: EdgeInsets.all(16),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             'Your Balance',
          //             style: TextStyle(
          //               fontSize: 16,
          //               color: Colors.grey[600],
          //             ),
          //           ),
          //           SizedBox(height: 8),
          //           Text(
          //             'Rp 1.500.000',
          //             style: TextStyle(
          //               fontSize: 24,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),

          // Main Content
          DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.6,
            maxChildSize: 0.965,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Drag indicator
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ),

                      // Top Up Button
                      // Padding(
                      //   padding: const EdgeInsets.all(16),
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //       // Add your top up logic here
                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //       backgroundColor: Colors.green[600],
                      //       minimumSize: Size(double.infinity, 50),
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(10),
                      //       ),
                      //     ),
                      //     child: Text(
                      //       'Top Up Now',
                      //       style: TextStyle(
                      //         fontSize: 16,
                      //         fontWeight: FontWeight.bold,
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      // Transaction History
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Transaction History',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16),
                            ...transactions
                                .map((transaction) => Card(
                                      margin: EdgeInsets.only(bottom: 12),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.green[100],
                                          child: Icon(
                                            Icons.account_balance_wallet,
                                            color: Colors.green[600],
                                          ),
                                        ),
                                        title: Text(
                                          'Rp ${NumberFormat('#,###').format(transaction['amount'])}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          DateFormat('dd MMM yyyy')
                                              .format(transaction['date']),
                                        ),
                                        trailing: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.green[50],
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            transaction['status'],
                                            style: TextStyle(
                                              color: Colors.green[600],
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
