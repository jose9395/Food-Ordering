import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/food_model.dart';

class FoodService {
  Future<List<Food>> fetchFoods() async {
    final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Food>.from(data['categories'].map((item) => Food.fromJson(item)));
    } else {
      throw Exception('Failed to load foods');
    }
  }
}
