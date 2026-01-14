import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_ai_app/screens/cooking_tools_screen.dart';
import '../services/ingredients_list.dart';

class TimeSelectionScreen extends StatefulWidget {
  @override
  _TimeSelectionScreenState createState() => _TimeSelectionScreenState();
}

class _TimeSelectionScreenState extends State<TimeSelectionScreen> {
  final IngredientsList ingredientsList = IngredientsList();
  Duration _currentDuration = const Duration(minutes: 30);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle actionButtonStyle = OutlinedButton.styleFrom(
      foregroundColor: Colors.deepPurple.shade400,
      side: BorderSide(color: Colors.grey.shade200),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(vertical: 12),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cooking Time"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          const Icon(Icons.timer_outlined, size: 80, color: Colors.grey),
          const SizedBox(height: 20),
          const Text(
            "How much time do you have?",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 8),
          ),
          const Spacer(),
          Container(
            height: 250,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: CupertinoTimerPicker(
              mode: CupertinoTimerPickerMode.hm,
              initialTimerDuration: _currentDuration,
              onTimerDurationChanged: (Duration newDuration) {
                setState(() {
                  _currentDuration = newDuration;
                });
              },
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: actionButtonStyle,
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Back"),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: OutlinedButton(
                  style: actionButtonStyle,
                  onPressed: () {
                    ingredientsList.availableCookingTime =
                    "${_currentDuration.inHours}h ${_currentDuration.inMinutes % 60}m";

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CookingToolsScreen(),
                      ),
                    );
                  },
                  child: const Text("Next"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}