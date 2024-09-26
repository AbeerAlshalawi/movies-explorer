import 'package:movies/src/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class RatingChip extends StatelessWidget {
  const RatingChip(this.rating, {super.key});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.surfaceContainer.withOpacity(0.7),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star_rounded,
            color: Colors.amber,
            size: 16,
          ),
          gapW4,
          Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(fontSize: 14),
          )
        ],
      ),
    );
  }
}
