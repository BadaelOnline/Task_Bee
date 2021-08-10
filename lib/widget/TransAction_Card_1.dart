import 'package:flutter/material.dart';

Widget cardTransaction(
    {@required String titleExchange,
    @required String datetime,
    Image iconMoneyType,
    @required String walletType,
    @required String contact,
    @required String note,
    @required String totaleMoney,
    @required Image imageWallet,
    String attachments,
    String currencyname,
    @required String payedMoney,
    @required Image iconExchang,
    @required String restMoney,
    String currency}) {
  return Card(
    margin: EdgeInsets.all(10),
    elevation: 5.0,
    child: Container(
      color: Colors.grey[100],
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(children: [
                    Container(
                      width: 30,
                      height: 30,
                      child: Image.asset(
                        'assets/wallet/dollars.png',
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        'Purchases and Spending',
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700]),
                      ),
                    ),
                  ]),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        datetime,
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 8.0),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.delete,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[400],
            endIndent: 13,
            indent: 13,
          ),
          Container(
            padding: EdgeInsets.only(
              right: 15,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 45,
                                  height: 45,
                                  child: IconButton(
                                      onPressed: () {}, icon: iconExchang),
                                ),
                                Container(
                                  child: Text(
                                    titleExchange,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 45,
                                  height: 45,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.blue,
                                    size: 27,
                                  ),
                                  // child: IconButton(
                                  //   onPressed: () {},
                                  //   icon: Image.asset(
                                  //     'assets/image/user.png',
                                  //   ),
                                  // ),
                                ),
                                Container(
                                  child: Text(
                                    contact,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                    width: 42,
                                    height: 42,
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: Image.asset(
                                          'assets/wallet/details.png',
                                        ))),
                                Container(
                                  child: Text(
                                    note,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(walletType),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Total:'),
                              SizedBox(
                                height: 5,
                              ),
                              Text('Payed:'),
                              SizedBox(
                                height: 5,
                              ),
                              Text('Rest:'),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                totaleMoney,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                payedMoney,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                restMoney,
                                style: TextStyle(
                                  color: Colors.red[500],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(currency),
                              SizedBox(
                                height: 5,
                              ),
                              Text(currency),
                              SizedBox(
                                height: 5,
                              ),
                              Text(currency),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ]),
          ),
        ],
      ),
    ),
  );
}
