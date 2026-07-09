import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:botanisht/core/theme/app_theme.dart';
import 'package:botanisht/providers/settings_provider.dart';
import 'package:botanisht/screens/home_screen.dart';
import 'package:botanisht/widgets/app_logo.dart';

/// First-run onboarding tutorial.
///
/// A full-screen, high-visibility [PageView] carousel that introduces
/// Botanisht's privacy philosophy, multi-zone system, and smart cultivation
/// engines, then lets the user set their initial preferences before entering
/// the app. On completion it persists the choices (and flips
/// [AppSettings.isFirstRun] to `false`) and routes to the main dashboard.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

/// Theme choices surfaced on the final preferences slide.
enum _ThemeChoice { cream, evergreen, highContrast }

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  static const int _numPages = 4;

  int _currentPage = 0;

  // Slide 4 — user preferences (defaults match the AppSettings model).
  int _units = 0; // 0 = Metric, 1 = Imperial
  int _temperatureScale = 0; // 0 = Celsius, 1 = Fahrenheit
  int _themeMode = 1; // 1 = Natural Cream (light) by default
  bool _highContrast = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _applyThemeChoice(_ThemeChoice choice) {
    setState(() {
      switch (choice) {
        case _ThemeChoice.cream:
          _themeMode = 1;
          _highContrast = false;
          break;
        case _ThemeChoice.evergreen:
          _themeMode = 2;
          _highContrast = false;
          break;
        case _ThemeChoice.highContrast:
          _themeMode = 2;
          _highContrast = true;
          break;
      }
    });
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _finish() async {
    ref.read(settingsProvider.notifier).completeOnboarding(
          themeMode: _themeMode,
          highContrast: _highContrast,
          units: _units,
          temperatureScale: _temperatureScale,
        );
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Live preview: the whole screen adopts the theme the user is picking.
    final previewTheme = resolveTheme(
      themeMode: _themeMode,
      highContrast: _highContrast,
    );

    return Theme(
      data: previewTheme,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) => setState(() => _currentPage = index),
                  children: [
                    _welcomeSlide(context),
                    _zonesSlide(context),
                    _smartSlide(context),
                    _preferencesSlide(context),
                  ],
                ),
              ),
              _buildBottomBar(context),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Slides
  // ---------------------------------------------------------------------------

  Widget _welcomeSlide(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 24),
          Semantics(
            label: 'Botanisht logo',
            child: const AppLogo(fontSize: 58),
          ),
          const SizedBox(height: 28),
          Icon(
            Icons.eco_rounded,
            size: 72,
            color: theme.colorScheme.tertiary,
          ),
          const SizedBox(height: 28),
          Text(
            'Welcome to your garden',
            style: theme.textTheme.headlineMedium!.copyWith(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 18),
          Text(
            'Botanisht is a secure, local-first, privacy-focused garden '
            'tracker. Your plants, your data — everything stays on your '
            'device. No accounts, no cloud, no subscriptions.',
            style: theme.textTheme.bodyLarge!.copyWith(
              fontSize: 19,
              height: 1.55,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _zonesSlide(BuildContext context) {
    final theme = Theme.of(context);
    const zones = [
      _ZoneInfo(Icons.park_rounded, 'Indoor', 'Houseplants & tropicals'),
      _ZoneInfo(Icons.science_rounded, 'Hydro', 'Hydroponic systems'),
      _ZoneInfo(Icons.eco_rounded, 'Kitchen', 'Herbs & edibles'),
      _ZoneInfo(Icons.monitor_heart_rounded, 'Diagnostics', 'Health & alerts'),
    ];
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Text(
            'The Multi-Zone System',
            style: theme.textTheme.headlineMedium!.copyWith(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Botanisht organises your plants into four dedicated spaces. '
            'Each plant routes dynamically into the zone that fits it best '
            'by category, so your indoor jungle, hydroponic rig, and kitchen '
            'garden each get their own focused view.',
            style: theme.textTheme.bodyLarge!.copyWith(
              fontSize: 19,
              height: 1.55,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: zones
                .map(
                  (z) => SizedBox(
                    width: 140,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Icon(z.icon, size: 40,
                                color: theme.colorScheme.tertiary),
                            const SizedBox(height: 10),
                            Text(
                              z.label,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              z.subtitle,
                              style: theme.textTheme.bodyMedium!.copyWith(
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _smartSlide(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Text(
            'Smart Cultivation',
            style: theme.textTheme.headlineMedium!.copyWith(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          _featureRow(
            context,
            Icons.eco_rounded,
            'Companion Planting Engine',
            'Automatically checks plant pairings and alerts you to nutrient '
                'competition or beneficial synergies in the same zone.',
          ),
          const SizedBox(height: 20),
          _featureRow(
            context,
            Icons.thunderstorm_rounded,
            'Contextual Weather Alerts',
            'Watches the forecast and warns you to move outdoor crops inside '
                'before major storms or frost events put them at risk.',
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _featureRow(
    BuildContext context,
    IconData icon,
    String title,
    String body,
  ) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.tertiary.withOpacity(0.15),
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.all(12),
          child: Icon(icon, size: 30, color: theme.colorScheme.tertiary),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                body,
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontSize: 18,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _preferencesSlide(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Text(
            'Set Your Preferences',
            style: theme.textTheme.headlineMedium!.copyWith(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Choose your defaults now — you can change these anytime in '
                'Settings.',
            style: theme.textTheme.bodyLarge!.copyWith(
              fontSize: 18,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          _preferenceGroup(
            context,
            'Measurement System',
            [
              _ChipOption(label: 'Metric', value: 0),
              _ChipOption(label: 'Imperial', value: 1),
            ],
            selected: _units,
            onSelected: (v) => setState(() => _units = v),
          ),
          const SizedBox(height: 18),
          _preferenceGroup(
            context,
            'Temperature',
            [
              _ChipOption(label: 'Celsius', value: 0),
              _ChipOption(label: 'Fahrenheit', value: 1),
            ],
            selected: _temperatureScale,
            onSelected: (v) => setState(() => _temperatureScale = v),
          ),
          const SizedBox(height: 18),
          _preferenceGroup<_ThemeChoice>(
            context,
            'Theme Mode',
            [
              _ChipOption(label: 'Cream', value: _ThemeChoice.cream),
              _ChipOption(label: 'Evergreen', value: _ThemeChoice.evergreen),
              _ChipOption(
                label: 'High Contrast',
                value: _ThemeChoice.highContrast,
              ),
            ],
            selected: _currentThemeChoice(),
            onSelected: _applyThemeChoice,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  _ThemeChoice _currentThemeChoice() {
    if (_highContrast) return _ThemeChoice.highContrast;
    return _themeMode == 2 ? _ThemeChoice.evergreen : _ThemeChoice.cream;
  }

  Widget _preferenceGroup<T>(
    BuildContext context,
    String label,
    List<_ChipOption<T>> options, {
    required T selected,
    required ValueChanged<T> onSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: options
              .map(
                (o) => ChoiceChip(
                  label: Text(o.label),
                  selected: o.value == selected,
                  onSelected: (_) => onSelected(o.value),
                  labelStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Bottom navigation bar
  // ---------------------------------------------------------------------------

  Widget _buildBottomBar(BuildContext context) {
    final theme = Theme.of(context);
    final isLast = _currentPage == _numPages - 1;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_numPages, (i) => _dot(theme, i == _currentPage)),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              if (isLast)
                TextButton(
                  onPressed: () => _goToPage(_currentPage - 1),
                  child: const Text('Back', style: TextStyle(fontSize: 16)),
                )
              else
                TextButton(
                  onPressed: _finish,
                  child: const Text('Skip', style: TextStyle(fontSize: 16)),
                ),
              const Spacer(),
              ElevatedButton(
                onPressed: isLast ? _finish : () => _goToPage(_currentPage + 1),
                child: Text(
                  isLast ? 'Get Started' : 'Next',
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dot(ThemeData theme, bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: active ? 22 : 9,
      height: 9,
      decoration: BoxDecoration(
        color: active
            ? theme.colorScheme.tertiary
            : theme.colorScheme.tertiary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}

class _ZoneInfo {
  final IconData icon;
  final String label;
  final String subtitle;
  const _ZoneInfo(this.icon, this.label, this.subtitle);
}

class _ChipOption<T> {
  final String label;
  final T value;
  const _ChipOption({required this.label, required this.value});
}
