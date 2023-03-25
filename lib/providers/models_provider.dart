import 'package:flutter/cupertino.dart';
import 'package:fluuter_chatgpt/models/models_model.dart';
import 'package:fluuter_chatgpt/services/api_services.dart';

class ModelsProvider with ChangeNotifier {
  String _currentModel = "gpt-3.5-turbo-0301";
  List<ModelsModel> _modelsList = [];
  List<ModelsModel> get getModelsList {
    return _modelsList;
  }

  String get getCurrModel {
    return _currentModel;
  }

  void setCurrModel(String newModel) {
    _currentModel = newModel;
    notifyListeners();
  }

  Future<List<ModelsModel>> getAllModels() async {
    _modelsList = await ApiServices.getModels();
    return _modelsList;
  }
}
