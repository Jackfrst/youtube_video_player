import 'dart:convert';
import 'package:edenberry/utils/models/courses_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';
import '../models/wellness_model.dart';

class APIProvider with ChangeNotifier{
  List<Wellness> _wellness = [];
  List<Wellness> get wellness => _wellness;

  List<Wellness> _product = [];
  List<Wellness> get product => _product;

  List<Courses> _courses = [];
  List<Courses> get courses => _courses;

  APIProvider() {
    _fetchWellness();
    _fetchProduct();
    _fetchCourses();
  }

  Future<void> _fetchWellness() async {
    final response = await http.get(Uri.parse('$baseUrl$wellnessApi'));
    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      _wellness = jsonList.map((jsonObject) => Wellness.fromJson(jsonObject)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<void> _fetchProduct() async {
    final response = await http.get(Uri.parse('$baseUrl$wellnessApi'));//Need to change
    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      _product = jsonList.map((jsonObject) => Wellness.fromJson(jsonObject)).toList(); //Need to change
      notifyListeners();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<void> _fetchCourses() async {
    final response = await http.get(Uri.parse('$baseUrl$coursesApi'));
    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      _courses = jsonList.map((jsonObject) => Courses.fromJson(jsonObject)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}