class RecipeSteps {
  late String text;
  late List<String> cooking_steps = [];

  RecipeSteps(this.text){
  }

  List<String> parseTextIntoSteps(){

    int instructionsIndex = text.indexOf("Instructions:");

    String instructionsPart = text.substring(instructionsIndex);
    cooking_steps = instructionsPart.split("\n");
    return cooking_steps;




    }
  }

