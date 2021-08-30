import 'package:flutter/material.dart';

class SplashLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(Icons.flight_takeoff),
              Icon(Icons.favorite),
            ],
          ),
          Text("Diário de viagens"),
          LinearProgressIndicator(),
        ],
      ),
    );
  }
}
