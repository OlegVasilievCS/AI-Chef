import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/ingredients_list.dart';
import 'dietary_restrictions_screen.dart';

class ImageAnalyzeScreen extends StatefulWidget {
  final String base64imageList;

  const ImageAnalyzeScreen({super.key, required this.base64imageList});

  @override
  _ImageAnalyzeScreenState createState() => _ImageAnalyzeScreenState();
}

class _ImageAnalyzeScreenState extends State<ImageAnalyzeScreen> {
  final IngredientsList ingredientsList = IngredientsList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Analysis")),
      body: Center(
        child: Text(widget.base64imageList),
      ),
        bottomNavigationBar: Container(
          child: ElevatedButton(
              onPressed: () {
                ingredientsList.chosenIngredients.add(widget.base64imageList);
                Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => DietaryRestrictionsScreen(),
                ),
              );
              }, child: Text("Next"),
        )
        )
    );
  }
}