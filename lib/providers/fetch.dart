import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class fetch with ChangeNotifier {
  num? _temperature;
  num? get temperature => _temperature;
  Future<void> fetchTemp() async {
    const url = "fetch_link_for_short_circuit";
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body);
      _temperature = extractedData["temperature"];
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  bool? _shortCircuit;
  bool? get shortCircuit => _shortCircuit;
  Future<void> fetchShortCircuit() async {
    const url = "fetch_for_short_circuit";
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body);
      _shortCircuit = extractedData["shortCircuit"];
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
