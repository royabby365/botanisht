import 'package:flutter/material.dart';
import '../services/plant_api_service.dart';
import '../models/plant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final PlantApiService _apiService;
  late final TabController _tabController;

  bool _isLoading = true;
  List<Plant> _indoorPlants = [];
  List<Plant> _kitchenPlants = [];
  List<Plant> _pollinatorPlants = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadPlants();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _apiService.close();
    super.dispose();
  }

  Future<void> _loadPlants() async {
    setState(() => _isLoading = true);
    try {
      // For demo, fetch some plants and categorize by name keywords
      final List<Plant> allPlants = await _apiService.searchPlants('');
      // Take first 20 plants for demo
      final List<Plant> samplePlants = allPlants.take(20).toList();

      setState(() {
        _indoorPlants = samplePlants.where((p) {
              final name = p.name.toLowerCase();
              return name.contains('fern') ||
                  name.contains('pothos') ||
                  name.contains('spider') ||
                  name.contains('snake') ||
                  name.contains('peace') ||
                  name.contains('zanzibar') ||
                  name.contains('aloe') ||
                  name.contains('ivy') ||
                  name.contains('succulent') ||
                  name.contains('cactus');
            }).toList();

        _kitchenPlants = samplePlants.where((p) {
              final name = p.name.toLowerCase();
              return name.contains('tomato') ||
                  name.contains('lettuce') ||
                  name.contains('carrot') ||
                  name.contains('pepper') ||
                  name.contains('cucumber') ||
                  name.contains('zucchini') ||
                  name.contains('spinach') ||
                  name.contains('kale') ||
                  name.contains('broccoli') ||
                  name.contains('basil') ||
                  name.contains('parsley') ||
                  name.contains('cilantro') ||
                  name.contains('mint') ||
                  name.contains('thyme') ||
                  name.contains('rosemary') ||
                  name.contains('oregano') ||
                  name.contains('dill') ||
                  name.contains('chives');
            }).toList();

        _pollinatorPlants = samplePlants.where((p) {
              final name = p.name.toLowerCase();
              return name.contains('rose') ||
                  name.contains('lavender') ||
                  name.contains('sunflower') ||
                  name.contains('daisy') ||
                  name.contains('marigold') ||
                  name.contains('zinnea') ||
                  name.contains('cosmos') ||
                  name.contains('bee') ||
                  name.contains('butterfly') ||
                  name.contains('pollinator') ||
                  name.contains('blossom');
            }).toList();
      });
    } catch (e) {
      // If API fails, show empty lists but could show error.
      setState(() {
        _indoorPlants = [];
        _kitchenPlants = [];
        _pollinatorPlants = [];
      });
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Widget _buildLogo() {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: const [
          TextSpan(
            text: 'Botan',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          WidgetSpan(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.0),
              child: Icon(Icons.thumb_up, size: 24, color: Colors.green),
            ),
          ),
          TextSpan(
            text: 'ish',
            style: TextStyle(
              fontSize: 24,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          WidgetSpan(
            child: Padding(
              padding: EdgeInsets.only(left: 2.0),
              child: Icon(Icons.eco, size: 20, color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlantList(List<Plant> plants, String type) {
    if (plants.isEmpty) {
      return Center(
        child: Text(
          'No $type plants yet.\nAdd some to get started!',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: plants.length,
      itemBuilder: (context, index) {
        final plant = plants[index];
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              backgroundColor: Colors.green.shade50,
              radius: 28,
              child: Icon(
                _getIconForPlantType(type),
                size: 28,
                color: Colors.green.shade700,
              ),
            ),
            title: Text(
              plant.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  'Scientific name: ${plant.scientificName ?? 'N/A'}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Sun: ${plant.sunlight}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Water: ${plant.watering}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.add_circle_outline),
              color: Colors.green.shade400,
              onPressed: () {
                // TODO: Add plant to user's garden
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added ${plant.name} to your $type!'),
                    backgroundColor: Colors.green.shade700,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  IconData _getIconForPlantType(String type) {
    switch (type.toLowerCase()) {
      case 'indoor':
        return Icons.grass;
      case 'kitchen':
        return Icons.restaurant_menu;
      case 'pollinator':
        return Icons.nature_people; // Use nature_people for pollinator
      default:
        return Icons.grass;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildLogo(),
        centerTitle: true,
        backgroundColor: Colors.green.shade50,
        elevation: 0,
        foregroundColor: Colors.green.shade800,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.green))
          : Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                    ),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.green.shade800,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.green.shade400,
                    indicatorWeight: 3,
                    tabs: const [
                      Tab(text: 'Indoor Jungle'),
                      Tab(text: 'Kitchen Garden'),
                      Tab(text: 'Pollinator Yard'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildPlantList(_indoorPlants, 'Indoor'),
                      _buildPlantList(_kitchenPlants, 'Kitchen'),
                      _buildPlantList(_pollinatorPlants, 'Pollinator'),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
