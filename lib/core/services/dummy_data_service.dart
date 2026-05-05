import 'package:home_food/core/models/address_model.dart';
import 'package:home_food/core/models/app_user.dart';
import 'package:home_food/core/models/cart_item.dart';
import 'package:home_food/core/models/custom_food_request.dart';
import 'package:home_food/core/models/food_item.dart';
import 'package:home_food/core/models/home_cook.dart';
import 'package:home_food/core/models/order_model.dart';
import 'package:home_food/core/models/review_model.dart';

class DummyDataService {
  final List<String> categories = const [
    'Rice',
    'Curry',
    'Snacks',
    'Desserts',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Custom food',
  ];

  final List<AddressModel> addresses = const [
    AddressModel(
      id: 'addr1',
      label: 'Home',
      street: '12 Lake View Road',
      area: 'Banani',
      city: 'Dhaka',
      latitude: 23.7937,
      longitude: 90.4066,
      type: AddressType.home,
    ),
    AddressModel(
      id: 'addr2',
      label: 'Office',
      street: '45 Startup Avenue',
      area: 'Gulshan',
      city: 'Dhaka',
      latitude: 23.7925,
      longitude: 90.4078,
      type: AddressType.office,
    ),
    AddressModel(
      id: 'addr3',
      label: 'Other',
      street: '22 Green Park',
      area: 'Dhanmondi',
      city: 'Dhaka',
      latitude: 23.7461,
      longitude: 90.3742,
      type: AddressType.other,
    ),
  ];

  late final AppUser demoCustomer = AppUser(
    id: 'user1',
    name: 'Nadia Rahman',
    email: 'nadia@example.com',
    phone: '+8801700000000',
    role: UserRole.customer,
    favoriteFoodIds: const ['food1', 'food5', 'food7'],
    savedAddresses: addresses,
  );

  late final AppUser demoSeller = AppUser(
    id: 'seller1',
    name: 'Sharmeen Kitchen',
    email: 'seller@example.com',
    phone: '+8801800000000',
    role: UserRole.seller,
    favoriteFoodIds: const [],
    savedAddresses: const [],
  );

  final List<HomeCook> homeCooks = const [
    HomeCook(
      id: 'cook1',
      name: 'Sharmeen Kitchen',
      specialty: 'Traditional Bengali Lunch',
      imageUrl:
          'https://images.unsplash.com/photo-1547592180-85f173990554?auto=format&fit=crop&w=800&q=80',
      rating: 4.9,
      distanceKm: 1.8,
      deliveryTime: '25-30 min',
      acceptsCustomOrders: true,
    ),
    HomeCook(
      id: 'cook2',
      name: 'Aunty Runa',
      specialty: 'Snacks and Evening Treats',
      imageUrl:
          'https://images.unsplash.com/photo-1490645935967-10de6ba17061?auto=format&fit=crop&w=800&q=80',
      rating: 4.8,
      distanceKm: 2.4,
      deliveryTime: '20-25 min',
      acceptsCustomOrders: true,
    ),
    HomeCook(
      id: 'cook3',
      name: 'Village Spice Home',
      specialty: 'Comfort Curry Bowls',
      imageUrl:
          'https://images.unsplash.com/photo-1606787366850-de6330128bfc?auto=format&fit=crop&w=800&q=80',
      rating: 4.7,
      distanceKm: 3.1,
      deliveryTime: '30-35 min',
      acceptsCustomOrders: false,
    ),
  ];

  late final List<FoodItem> foods = [
    FoodItem(
      id: 'food1',
      cookId: 'cook1',
      cookName: 'Sharmeen Kitchen',
      name: 'Chicken Tehari',
      imageUrl:
          'https://images.unsplash.com/photo-1512058564366-18510be2db19?auto=format&fit=crop&w=900&q=80',
      description: 'Aromatic rice cooked with tender chicken and warm spices.',
      ingredients: const ['Chicken', 'Basmati rice', 'Yogurt', 'Ghee'],
      price: 12,
      rating: 4.9,
      deliveryTime: '25-30 min',
      distanceKm: 1.8,
      category: 'Rice',
      isVegetarian: false,
      spiceLevel: 'Medium',
      isPopular: true,
      reviews: const [
        ReviewModel(
          userName: 'Maliha',
          rating: 5,
          comment: 'Tastes exactly like a festive homemade lunch.',
        ),
        ReviewModel(
          userName: 'Rafi',
          rating: 4.8,
          comment: 'Perfect portion and balanced spice.',
        ),
      ],
    ),
    FoodItem(
      id: 'food2',
      cookId: 'cook3',
      cookName: 'Village Spice Home',
      name: 'Beef Curry Plate',
      imageUrl:
          'https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=900&q=80',
      description: 'Slow-cooked beef curry served with fragrant rice.',
      ingredients: const ['Beef', 'Potato', 'Onion', 'House spices'],
      price: 15,
      rating: 4.7,
      deliveryTime: '30-35 min',
      distanceKm: 3.1,
      category: 'Curry',
      isVegetarian: false,
      spiceLevel: 'Spicy',
      isPopular: true,
      reviews: const [
        ReviewModel(
          userName: 'Tania',
          rating: 4.7,
          comment: 'Rich gravy and very comforting.',
        ),
      ],
    ),
    FoodItem(
      id: 'food3',
      cookId: 'cook2',
      cookName: 'Aunty Runa',
      name: 'Vegetable Chop',
      imageUrl:
          'https://images.unsplash.com/photo-1604908177522-429c730f39f4?auto=format&fit=crop&w=900&q=80',
      description: 'Crispy crumb-coated snack filled with spiced vegetables.',
      ingredients: const ['Beetroot', 'Potato', 'Carrot', 'Breadcrumbs'],
      price: 6,
      rating: 4.6,
      deliveryTime: '20-25 min',
      distanceKm: 2.4,
      category: 'Snacks',
      isVegetarian: true,
      spiceLevel: 'Mild',
      isPopular: false,
      reviews: const [],
    ),
    FoodItem(
      id: 'food4',
      cookId: 'cook2',
      cookName: 'Aunty Runa',
      name: 'Shemai Delight',
      imageUrl:
          'https://images.unsplash.com/photo-1519864600265-abb23847ef2c?auto=format&fit=crop&w=900&q=80',
      description: 'Creamy roasted vermicelli dessert finished with nuts.',
      ingredients: const ['Vermicelli', 'Milk', 'Cardamom', 'Cashew'],
      price: 7,
      rating: 4.8,
      deliveryTime: '18-22 min',
      distanceKm: 2.1,
      category: 'Desserts',
      isVegetarian: true,
      spiceLevel: 'Mild',
      isPopular: true,
      reviews: const [],
    ),
    FoodItem(
      id: 'food5',
      cookId: 'cook1',
      cookName: 'Sharmeen Kitchen',
      name: 'Paratha and Egg Bhuna',
      imageUrl:
          'https://images.unsplash.com/photo-1515003197210-e0cd71810b5f?auto=format&fit=crop&w=900&q=80',
      description: 'Flaky paratha served with spicy scrambled egg bhuna.',
      ingredients: const ['Eggs', 'Paratha', 'Onion', 'Green chili'],
      price: 8,
      rating: 4.8,
      deliveryTime: '15-20 min',
      distanceKm: 1.4,
      category: 'Breakfast',
      isVegetarian: false,
      spiceLevel: 'Medium',
      isPopular: false,
      reviews: const [],
    ),
    FoodItem(
      id: 'food6',
      cookId: 'cook1',
      cookName: 'Sharmeen Kitchen',
      name: 'Lunch Box Special',
      imageUrl:
          'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=900&q=80',
      description:
          'Rice, dal, chicken curry, and salad packed for a balanced lunch.',
      ingredients: const ['Rice', 'Dal', 'Chicken', 'Salad'],
      price: 13,
      rating: 4.9,
      deliveryTime: '25-28 min',
      distanceKm: 1.9,
      category: 'Lunch',
      isVegetarian: false,
      spiceLevel: 'Medium',
      isPopular: true,
      reviews: const [],
    ),
    FoodItem(
      id: 'food7',
      cookId: 'cook3',
      cookName: 'Village Spice Home',
      name: 'Dinner Khichuri',
      imageUrl:
          'https://images.unsplash.com/photo-1601050690597-df0568f70950?auto=format&fit=crop&w=900&q=80',
      description: 'Creamy lentil rice served with fried eggplant and achar.',
      ingredients: const ['Rice', 'Lentils', 'Eggplant', 'Mustard oil'],
      price: 10,
      rating: 4.7,
      deliveryTime: '28-32 min',
      distanceKm: 2.9,
      category: 'Dinner',
      isVegetarian: true,
      spiceLevel: 'Mild',
      isPopular: false,
      reviews: const [],
    ),
    FoodItem(
      id: 'food8',
      cookId: 'cook2',
      cookName: 'Aunty Runa',
      name: 'Custom Bento Starter',
      imageUrl:
          'https://images.unsplash.com/photo-1482049016688-2d3e1b311543?auto=format&fit=crop&w=900&q=80',
      description: 'A customizable homemade meal prepared around your taste.',
      ingredients: const ['Rice', 'Protein option', 'Seasonal vegetables'],
      price: 14,
      rating: 4.5,
      deliveryTime: '35-40 min',
      distanceKm: 2.7,
      category: 'Custom food',
      isVegetarian: false,
      spiceLevel: 'Medium',
      isPopular: false,
      reviews: const [],
    ),
  ];

  late final List<OrderModel> initialOrders = [
    OrderModel(
      id: 'order1',
      items: [
        CartItem(food: foods.first, quantity: 1),
        CartItem(food: foods[3], quantity: 2),
      ],
      address: addresses.first,
      paymentMethod: PaymentMethod.cashOnDelivery,
      status: OrderStatus.cooking,
      deliveryFee: 3,
      estimatedDeliveryTime: DateTime.now().add(const Duration(minutes: 24)),
      createdAt: DateTime.now().subtract(const Duration(minutes: 16)),
    ),
  ];

  late final List<CustomFoodRequest> initialCustomRequests = [
    CustomFoodRequest(
      id: 'req1',
      foodName: 'Low-oil chicken pulao',
      description: 'Lightly spiced and less oily, with extra raisins.',
      spiceLevel: 'Mild',
      quantity: 3,
      deliveryDateTime: DateTime.now().add(const Duration(days: 1, hours: 2)),
      specialInstructions: 'Please pack in separate lunch boxes.',
      referenceImageUrl: null,
      status: 'Pending',
    ),
    CustomFoodRequest(
      id: 'req2',
      foodName: 'Vegetarian breakfast platter',
      description: 'Paratha, mixed vegetables, and chutney.',
      spiceLevel: 'Medium',
      quantity: 2,
      deliveryDateTime: DateTime.now().add(const Duration(days: 2)),
      specialInstructions: 'No peanuts.',
      referenceImageUrl: null,
      status: 'Accepted',
    ),
  ];
}
