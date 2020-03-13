import 'package:flutter/material.dart';
import '../widgets/ride_card.dart';
import '../widgets/ride_cards.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreen createState() => _AccountScreen();
}

class _AccountScreen extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TabBar(
                      unselectedLabelColor: Colors.grey,
                      labelColor: Colors.red,
                      labelStyle: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                      indicatorColor: Colors.red,
                      tabs: <Widget>[
                        Tab(
                          text: "COMPLETED",
                        ),
                        Tab(
                          text: "CANCELED",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: TabBarView(
                        children: <Widget>[
                          SingleChildScrollView(
                            child: RideCards(),
                          ),
                          Container(
                            child: RideCard(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
