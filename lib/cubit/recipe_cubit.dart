import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/gemini_service.dart';
import 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  final GeminiService _geminiService;

  RecipeCubit(this._geminiService) : super(RecipeInitial());

  Future<void> fetchRecipe(String ingredients) async {
    if (ingredients.isEmpty) {
      emit(const RecipeError("Please enter ingredients."));
      return;
    }

    emit(RecipeLoading());
    try {
      String result = await _geminiService.getRecipe(ingredients);

      if (result.startsWith("Error:")) {
        emit(RecipeError(result));
      } else {
        emit(RecipeLoaded(result));
      }
    } catch (e) {
      emit(RecipeError("An error occurred: ${e.toString()}"));
    }
  }
}