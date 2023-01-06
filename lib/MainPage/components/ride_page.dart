import 'package:flutter/material.dart';
import 'package:proj_ver1/data/repository/models/ride_model.dart';

class RidePage extends StatelessWidget {
  RidePage({Key? key, required this.id, required this.ride}) : super(key: key);
  final int id;
  final Ride ride;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Icon(
          ride.vehicle == 'Automóvil' ? Icons.drive_eta : Icons.motorcycle, size: 40
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width,
                  child: Text(""),
                  color: Colors.grey,
                ),
                ListTile(
                  leading: Icon(Icons.place),
                  title: Text(ride.start + " - " + ride.end),
                  subtitle: Text(ride.dateAndTime),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(ride.plate), 
                      Text(ride.color)
                    ],
                  )
                ),
                ListTile(
                  leading: Icon(Icons.money),
                  title: Text(ride.price),
                  trailing: Column(
                    children: [
                      Icon(Icons.numbers), 
                      Text(ride.room)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
