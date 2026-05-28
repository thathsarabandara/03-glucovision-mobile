import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../services/api_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class RecordListScreen extends StatefulWidget {
  const RecordListScreen({super.key});

  @override
  State<RecordListScreen> createState() => _RecordListScreenState();
}

class _RecordListScreenState extends State<RecordListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final DataCollectApiService _apiService = DataCollectApiService();
  List<dynamic> _foodStats = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchStats();
  }

  Future<void> _fetchStats([String query = '']) async {
    setState(() => _isLoading = true);
    
    // Dummy list representing the stats endpoint response
    await Future.delayed(const Duration(milliseconds: 500));
    final dummyStats = [
      {'food_id': 'rice_samba', 'name': 'Samba Rice', 'count': 12, 'preview_uri': null},
      {'food_id': 'chicken_curry', 'name': 'Chicken Curry', 'count': 8, 'preview_uri': null},
      {'food_id': 'dhal_curry', 'name': 'Dhal Curry', 'count': 5, 'preview_uri': null},
    ];

    if (mounted) {
      setState(() {
        _foodStats = dummyStats
            .where((s) => s['name'].toString().toLowerCase().contains(query.toLowerCase()))
            .toList();
        _isLoading = false;
      });
    }
  }

  void _onSearchChanged(String query) {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_searchController.text == query) {
        _fetchStats(query);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? AppTheme.backgroundDark : const Color(0xFFF9FAFC);
    final textColor = isDark ? Colors.white : AppTheme.textPrimary;

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text('Recorded Foods', style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(LucideIcons.downloadCloud, size: 16, color: AppTheme.cyanAccent),
            label: const Text('Export CSV', style: TextStyle(color: AppTheme.cyanAccent, fontWeight: FontWeight.bold, fontSize: 12)),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              style: TextStyle(color: textColor, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Search captured foods...',
                hintStyle: TextStyle(color: AppTheme.textSecondary),
                prefixIcon: const Icon(LucideIcons.search, color: AppTheme.textSecondary, size: 18),
                suffixIcon: _isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(14.0),
                        child: SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.cyanAccent),
                        ),
                      )
                    : null,
                filled: true,
                fillColor: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.02),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: AppTheme.cyanAccent, width: 1.5),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
          Expanded(
            child: _foodStats.isEmpty && !_isLoading
                ? Center(
                    child: Text('No foods matching your search.', style: TextStyle(color: AppTheme.textSecondary)),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.85,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: _foodStats.length,
                    itemBuilder: (context, index) {
                      final stat = _foodStats[index];
                      return GlassCard(
                        padding: EdgeInsets.zero,
                        borderRadius: 20,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            // Navigate to record gallery for this food
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isDark ? Colors.white.withOpacity(0.03) : Colors.black.withOpacity(0.02),
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                                  ),
                                  child: Icon(LucideIcons.image, size: 32, color: AppTheme.textSecondary.withOpacity(0.5)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Text(
                                      stat['name'],
                                      style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 13),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: AppTheme.emeraldHealth.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        '${stat['count']} ${stat['count'] == 1 ? 'Image' : 'Images'}',
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.emeraldHealth,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
