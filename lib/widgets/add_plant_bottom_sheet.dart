import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:botanisht/models/plant.dart';
import 'package:botanisht/providers/plant_provider.dart';
import 'package:botanisht/services/plant_api_service.dart';

class AddPlantBottomSheet extends ConsumerStatefulWidget {
  const AddPlantBottomSheet();

  @override
  ConsumerState<AddPlantBottomSheet> createState() => _AddPlantBottomSheetState();
}

class _AddPlantBottomSheetState extends ConsumerState<AddPlantBottomSheet> {
  final _nameController = TextEditingController();
  final _customNameController = TextEditingController();
  final _locationController = TextEditingController();
  final _searchController = TextEditingController();
  final _api = PlantApiService();

  String? _selectedZone = 'indoor';
  bool _isSearching = false;
  List<Plant> _searchResults = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    // Rebuild when the name field changes so the Add button enables/disables.
    _nameController.addListener(() => setState(() {}));
  }

  void _onSearchChanged() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      _runSearch(_searchController.text);
    });
  }

  Future<void> _runSearch(String query) async {
    final q = query.trim();
    if (q.isEmpty) {
      if (mounted) {
        setState(() {
          _searchResults = [];
          _isSearching = false;
        });
      }
      return;
    }
    if (mounted) setState(() => _isSearching = true);
    try {
      final results = await _api.searchPlants(q);
      if (mounted) setState(() => _searchResults = results);
    } catch (_) {
      if (mounted) setState(() => _searchResults = []);
    } finally {
      if (mounted) setState(() => _isSearching = false);
    }
  }

  void _fillFromPlant(Plant plant) {
    _nameController.text = plant.name ?? '';
    _customNameController.text = '';
    if (plant.category != null &&
        ['indoor', 'hydro', 'kitchen'].contains(plant.category)) {
      _selectedZone = plant.category;
    }
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Filled details for ${plant.name ?? 'plant'}'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _nameController.dispose();
    _customNameController.dispose();
    _locationController.dispose();
    _searchController.dispose();
    _api.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      expand: false,
      builder: (context, scrollController) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF5F0E1),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                'Add Plant to Garden',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Search our database or create a custom entry',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF1B4332).withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search plants...',
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.mic_rounded),
                    tooltip: 'Voice search',
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Voice search coming soon.'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    ),
                  ),
                ),
                onSubmitted: _runSearch,
              ),
              const SizedBox(height: 8),
              if (_isSearching) const LinearProgressIndicator(),
              if (_searchResults.isNotEmpty)
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 240),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final plant = _searchResults[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: const Color(0xFF1B4332).withOpacity(0.1),
                          child: const Icon(
                            Icons.local_florist_rounded,
                            color: Color(0xFF1B4332),
                          ),
                        ),
                        title: Text(plant.name ?? 'Unknown'),
                        subtitle: Text(plant.scientificName ?? ''),
                        onTap: () => _fillFromPlant(plant),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 16),
              Text(
                'Or create custom',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Plant Name *',
                  hintText: 'e.g., Monstera Deliciosa',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _customNameController,
                decoration: const InputDecoration(
                  labelText: 'Custom Name (Optional)',
                  hintText: 'e.g., Living Room Monster',
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedZone,
                decoration: const InputDecoration(labelText: 'Zone'),
                items: const [
                  DropdownMenuItem(value: 'indoor', child: Text('Indoor')),
                  DropdownMenuItem(value: 'hydro', child: Text('Hydro')),
                  DropdownMenuItem(value: 'kitchen', child: Text('Kitchen')),
                ],
                onChanged: (value) => setState(() => _selectedZone = value),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location (Optional)',
                  hintText: 'e.g., Kitchen window, Balcony, Grow tent',
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _nameController.text.isNotEmpty
                      ? () {
                          ref
                              .read(userPlantNotifierProvider.notifier)
                              .addCustom(
                                name: _nameController.text,
                                customName: _customNameController.text.isNotEmpty
                                    ? _customNameController.text
                                    : null,
                                location: _locationController.text.isNotEmpty
                                    ? _locationController.text
                                    : null,
                                lightConditions:
                                    _selectedZone == 'hydro' ? 'Grow lights' : null,
                                temperatureRange:
                                    _selectedZone == 'hydro' ? '68-75°F' : null,
                              );
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Added ${_nameController.text} to garden!'),
                              backgroundColor: const Color(0xFF1B4332),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      : null,
                  icon: const Icon(Icons.add_rounded),
                  label: const Text('Add Custom Plant'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
