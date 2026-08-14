import 'package:flutter/material.dart';

/// Compute level from XP using the same table as garden_score_card.
const List<int> _xpToLevel = [
  0, 50, 120, 220, 350, 520, 730, 980, 1280, 1630, 2030,
  2480, 2980, 3530, 4130, 4780, 5480, 6230, 7030, 7880,
];

int _computeLevel(int xp) {
  for (int i = _xpToLevel.length - 1; i >= 1; i--) {
    if (xp >= _xpToLevel[i]) return i + 1;
  }
  return 1;
}

int _xpForLevel(int level) {
  if (level <= 1) return 0;
  if (level <= _xpToLevel.length) return _xpToLevel[level - 1];
  // Progressive beyond table.
  final offset = _xpToLevel.last;
  final idx = level - _xpToLevel.length - 1;
  return offset + ((idx + 1) * 130);
}

/// A compact badge showing a plant's level and XP progress.
class PlantLevelBadge extends StatelessWidget {
  final int xp;
  final int level;
  final double size; // default 32px
  final bool showXpBar;

  const PlantLevelBadge({
    super.key,
    required this.xp,
    this.level = 1,
    this.size = 32,
    this.showXpBar = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveLevel = level > 0 ? level : _computeLevel(xp);
    final currentXp = xp;
    final currentThreshold = _xpForLevel(effectiveLevel);
    final nextThreshold = _xpForLevel(effectiveLevel + 1);
    final progress = nextThreshold > currentThreshold
        ? (currentXp - currentThreshold) / (nextThreshold - currentThreshold)
        : 0.0;

    final Color levelColor;
    if (effectiveLevel >= 15) {
      levelColor = const Color(0xFFFFD700); // Gold — master
    } else if (effectiveLevel >= 10) {
      levelColor = const Color(0xFFC0C0C0); // Silver — expert
    } else if (effectiveLevel >= 5) {
      levelColor = const Color(0xFFCD7F32); // Bronze — experienced
    } else {
      levelColor = theme.colorScheme.primary; // Green — growing
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Level circle
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: levelColor.withValues(alpha: 0.15),
            shape: BoxShape.circle,
            border: Border.all(color: levelColor, width: 1.5),
          ),
          alignment: Alignment.center,
          child: Text(
            '$effectiveLevel',
            style: TextStyle(
              fontSize: size * 0.45,
              fontWeight: FontWeight.bold,
              color: levelColor,
            ),
          ),
        ),
        if (showXpBar && nextThreshold > currentThreshold) ...[
          const SizedBox(height: 3),
          SizedBox(
            width: size + 8,
            height: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1.5),
              child: LinearProgressIndicator(
                value: progress.clamp(0.0, 1.0),
                backgroundColor: levelColor.withValues(alpha: 0.15),
                valueColor: AlwaysStoppedAnimation<Color>(levelColor),
                minHeight: 3,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// Streak flame icon with day count.
class StreakBadge extends StatelessWidget {
  final int streak;
  final double size;

  const StreakBadge({super.key, required this.streak, this.size = 14});

  @override
  Widget build(BuildContext context) {
    if (streak <= 0) return const SizedBox.shrink();

    final Color color;
    if (streak >= 30) {
      color = const Color(0xFFFF4500); // Blazing
    } else if (streak >= 14) {
      color = const Color(0xFFFF8C00); // Hot
    } else if (streak >= 7) {
      color = Colors.orange; // Warm
    } else {
      color = Colors.amber;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.local_fire_department, size: size, color: color),
        const SizedBox(width: 2),
        Text(
          '$streak',
          style: TextStyle(
            fontSize: size * 0.85,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}