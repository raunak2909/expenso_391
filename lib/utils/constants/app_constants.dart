import '../../data/local/models/category_model.dart';

class AppConstants{

  static const String PREF_USER_ID_KEY = "uid";
  static const String PREF_IS_INTRO_LOADED_KEY = "isIntroLoaded";

  static List<CategoryModel> mCat = [
    CategoryModel(id: 1, name: "Coffee", imgPath: "assets/icons/coffee.png"),
    CategoryModel(id: 2, name: "FastFood", imgPath: "assets/icons/fast-food.png"),
    CategoryModel(id: 3, name: "Restaurant", imgPath: "assets/icons/restaurant.png"),
    CategoryModel(id: 4, name: "Recharge", imgPath: "assets/icons/mobile-transfer.png"),
    CategoryModel(id: 5, name: "Petrol", imgPath: "assets/icons/vehicles.png"),
    CategoryModel(id: 6, name: "Travel", imgPath: "assets/icons/travel.png"),
    CategoryModel(id: 7, name: "Shopping", imgPath: "assets/icons/hawaiian-shirt.png"),
  ];

}