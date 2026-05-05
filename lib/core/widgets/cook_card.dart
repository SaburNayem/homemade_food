import 'package:flutter/material.dart';

import 'package:home_food/core/models/home_cook.dart';

class CookCard extends StatelessWidget {
  final HomeCook cook;

  const CookCard({super.key, required this.cook});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.network(
              cook.imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Text(cook.name, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(cook.specialty),
          const SizedBox(height: 8),
          Text(
            '${cook.rating} ★  •  ${cook.distanceKm} km  •  ${cook.deliveryTime}',
          ),
        ],
      ),
    );
  }
}
