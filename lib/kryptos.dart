//create a simplt flutter screen
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

List<String> krypto = <String>[];
List<String> symbol = <String>[];
List<String> price = <String>[];
List<String> change = <String>[];
List<String> supply = <String>[];
List<String> maxSupply = <String>[];
List<String> marketCap = <String>[];
List<String> vwap = <String>[];
List<String> rank = <String>[];

void main() {
  runApp(Kryptos());
}

//flutter get json data from api function
getJsonData() async {
  var url = "https://api.coincap.io/v2/assets";
  var response = await http.get(Uri.parse(url));
  var jsonData = jsonDecode(response.body);
  //loop through the json data

  for (var u in jsonData['data']) {
    // print(u['id']);
    // print(u['name']);
    // print(u['symbol']);
    // print(u['priceUsd']);
    // print(u['changePercent24Hr']);
    // print(u['vwap24Hr']);
    // print(u['marketCapUsd']);
    // print(u['volumeUsd24Hr']);
    // print(u['supply']);
    // print(u['maxSupply']);
    // print(u['rank']);
    // print(u['history']);
    // print(u['idIcon']);

    try {
      krypto.add(u['name']);
      symbol.add(u['symbol']);
      price.add(u['priceUsd']);
      change.add(u['changePercent24Hr']);
      supply.add(u['supply']);
      maxSupply.add(u['maxSupply']);
      marketCap.add(u['marketCapUsd']);
      vwap.add(u['vwap24Hr']);
      rank.add(u['rank']);
    } catch (e) {
      print(e);
    }
  }
  return jsonData;
}

class Kryptos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kryptos'),
          backgroundColor: Colors.green,
        ),
        body: FutureBuilder(
          future: getJsonData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: krypto.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      //left column
                      child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                              'NAME: ${krypto[index]} (${symbol[index]})',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                              'PRICE: \$${double.parse(price[index]).toStringAsFixed(2)}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text('Rank: ${rank[index]}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                              '24hr Change: ${double.parse(change[index]).toStringAsFixed(2)}%'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                              'Supply: ${double.parse(supply[index]).toStringAsFixed(2)}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                              'Max Supply: ${double.parse(maxSupply[index]).toStringAsFixed(2)}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                              'Market Cap USD: \$${double.parse(marketCap[index]).toStringAsFixed(2)}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                              'VWAP 24hr: ${double.parse(vwap[index]).toStringAsFixed(2)}'),
                        )
                      ],
                    ),
                  ));
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
