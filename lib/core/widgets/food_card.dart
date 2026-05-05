import 'package:flutter/material.dart';

import 'package:home_food/core/models/food_item.dart';
import 'package:home_food/core/utils/app_formatters.dart';

class FoodCard extends StatelessWidget {
  final FoodItem food;
  final VoidCallback onTap;
  final VoidCallback onAdd;

  const FoodCard({
    super.key,
    required this.food,
    required this.onTap,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 360;

        return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(isCompact ? 10 : 12),
              child: isCompact
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const _FoodThumbnail(size: 84, radius: 18),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    food.name,
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(food.cookName),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: onAdd,
                              visualDensity: VisualDensity.compact,
                              icon: const Icon(
                                Icons.add_circle,
                                color: Color(0xFFE67E22),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _Tag(
                              label: AppFormatters.price(food.price),
                              compact: isCompact,
                            ),
                            _Tag(
                              label: '${food.rating} star',
                              compact: isCompact,
                            ),
                            _Tag(label: food.deliveryTime, compact: isCompact),
                            _Tag(
                              label: '${food.distanceKm} km',
                              compact: isCompact,
                            ),
                          ],
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        const _FoodThumbnail(size: 96, radius: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                food.name,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(food.cookName),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  _Tag(label: AppFormatters.price(food.price)),
                                  _Tag(label: '${food.rating} star'),
                                  _Tag(label: food.deliveryTime),
                                  _Tag(label: '${food.distanceKm} km'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: onAdd,
                          icon: const Icon(
                            Icons.add_circle,
                            color: Color(0xFFE67E22),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}

class _FoodThumbnail extends StatelessWidget {
  final double size;
  final double radius;

  const _FoodThumbnail({required this.size, required this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFF0D9), Color(0xFFF7C67A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: const Icon(
        Icons.fastfood_outlined,
        color: Color(0xFFE67E22),
        size: 32,
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final bool compact;

  const _Tag({required this.label, this.compact = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 10,
        vertical: compact ? 5 : 6,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF7EFE5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
