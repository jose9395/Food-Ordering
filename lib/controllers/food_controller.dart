import 'package:food_ordering_app/models/submitted_food.dart';
import 'package:get/get.dart';
import '../models/food_model.dart';
import '../services/food_service.dart';

class FoodController extends GetxController {

  var foods = <Food>[].obs;
  var filteredFoods = <Food>[].obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    fetchFoods();
    super.onInit();
  }

  void fetchFoods() async {
    try {
      final fetchedFoods = await FoodService().fetchFoods();
      foods.value = fetchedFoods;
      filteredFoods.value = foods;
    } catch (e) {
      // Handle error
      print('Failed to fetch foods: $e');
    }
  }

  void filterFoods(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredFoods.value = foods;
    } else {
      filteredFoods.value = foods
          .where(
              (food) => food.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
