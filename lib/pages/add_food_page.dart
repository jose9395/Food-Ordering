import 'package:flutter/material.dart';
import 'package:food_ordering_app/models/submitted_food.dart';
import 'package:food_ordering_app/services/sqflite.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:math';


class AddFoodPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cuisineController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();

   SqliteService noteDatabase = SqliteService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Add Food'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _imageController,
                decoration: InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter image URL';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Restaurant Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter restaurant name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cuisineController,
                decoration: InputDecoration(labelText: 'Cuisine'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter cuisine';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ratingController,
                decoration: InputDecoration(labelText: 'Rating'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter rating';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {

                    SubmittedFood val1  = SubmittedFood(id: Random().nextInt(16),
                        image: _imageController.text,
                        name: _nameController.text,
                        cuisine: _cuisineController.text,
                        rating: _ratingController.text);
                    List<SubmittedFood> res = [val1];
                    noteDatabase.insert(res);
                  }
                  Navigator.pop(context);
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
