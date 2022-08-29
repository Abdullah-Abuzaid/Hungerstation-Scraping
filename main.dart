import 'services/restaurant_services.dart';

void main() async {
  // final k = await RestaurantServices.getAllRestaurants();
  print(await RestaurantServices.getRestaurants(page: 1));
}
