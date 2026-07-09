/// Internal companion-planting rules engine.
///
/// Holds the biological synergies and collisions used to warn or advise the
/// user when two incompatible (or beneficial) crops share the same zone.
///
/// Rules are stored as an ordered lookup table. [evaluate] is called with a
/// plant's display name and the names of the other plants in the same zone;
/// it returns the first matching advice (warnings take priority over tips).
class CompanionRules {
  const CompanionRules._();

  // Pairwise collision: BOTH crops must be present in the same zone.
  static final List<_CompanionRule> _rules = [
    _CompanionRule(
      isWarning: true,
      applies: (names) =>
          names.any((n) => n.contains('zucchini')) &&
          names.any((n) => n.contains('cucumber')),
      message:
          'Warning: High competition for space and nutrients. May cross-pollinate or attract matching pests.',
    ),
    _CompanionRule(
      isWarning: false,
      applies: (names) =>
          names.any((n) => n.contains('bean')) && names.length > 1,
      message:
          'Tip: Beans are nitrogen-fixers! They naturally enrich the soil profile for neighboring crops.',
    ),
    _CompanionRule(
      isWarning: false,
      applies: (names) =>
          names.any((n) => n.contains('tomato')) &&
          names.any((n) => n.contains('basil')),
      message:
          'Tip: Basil repels thrips and mosquitoes and is said to improve the flavour and growth of neighbouring tomatoes.',
    ),
    _CompanionRule(
      isWarning: true,
      applies: (names) =>
          names.any((n) => n.contains('tomato')) &&
          names.any((n) => n.contains('potato')),
      message:
          'Warning: Tomatoes and potatoes share blight-prone nightshade diseases — keep them apart.',
    ),
  ];

  /// Returns advice for [plantName] given the other plants [neighbors] sharing
  /// its zone, or `null` when no rule applies.
  static ({String message, bool isWarning})? evaluate(
    String plantName,
    List<String> neighbors,
  ) {
    final group = [plantName, ...neighbors]
        .map((e) => e.toLowerCase())
        .toList();
    for (final rule in _rules) {
      if (rule.applies(group)) {
        return (message: rule.message, isWarning: rule.isWarning);
      }
    }
    return null;
  }
}

class _CompanionRule {
  final bool isWarning;
  final bool Function(List<String> names) applies;
  final String message;

  const _CompanionRule({
    required this.isWarning,
    required this.applies,
    required this.message,
  });
}
