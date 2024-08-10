import 'package:flutter/material.dart';
import 'package:food_ordering_app/services/sqflite.dart';
import 'package:get/get.dart';
import 'add_food_page.dart';
import '../controllers/food_controller.dart';
import '../models/submitted_food.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FoodController foodController = Get.put(FoodController());

  late SqliteService noteDatabase;

  @override
  void initState() {
    noteDatabase = SqliteService();
    noteDatabase.initializedDB().whenComplete(() async {
      await noteDatabase.retrieve();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Search App'),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  foodController.filterFoods(value);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Search for food',
                ),
              ),
            ),
            Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                // Prevent infinite height
                physics: NeverScrollableScrollPhysics(),
                // Disable scrolling within ListView
                itemCount: foodController.filteredFoods.length,
                itemBuilder: (context, index) {
                  final food = foodController.filteredFoods[index];
                  return ListTile(
                    title: Text(food.name),
                  );
                },
              );
            }),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade600,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1485962398705-ef6a13c41e8f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MTJ8fHxlbnwwfHx8fHw%3D'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade600,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MTZ8fHxlbnwwfHx8fHw%3D'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 500,
              child: FutureBuilder(
                future: noteDatabase.retrieve(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<SubmittedFood>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: ScrollPhysics(),
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(8.0),
                            title: Text(snapshot.data![index].name),
                            subtitle: Column(
                                children:
                                [
                              Text(snapshot.data![index].cuisine),
                                  Text(snapshot.data![index].rating),
                                  Text(snapshot.data![index].image),
                            ])


                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Get.to(() => AddFoodPage());
          if (result != null) {}
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
