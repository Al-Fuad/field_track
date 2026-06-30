import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/common/widgets/status_badge.dart';
import '../../../../core/constant/app_color.dart';
import '../bloc/locations_bloc.dart';
class LocationsPage extends StatefulWidget {
  const LocationsPage({super.key});
  @override
  State<LocationsPage> createState() => _LocationsPageState();
}
class _LocationsPageState extends State<LocationsPage> {
  final _searchController = TextEditingController();
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = isDark ? AppColor.primaryDark : AppColor.primaryLight;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Locations'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/locations/new'),
          ),
        ],
      ),
      body: BlocBuilder<LocationsBloc, LocationsState>(
        builder: (context, state) {
          if (state is LocationsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is LocationsLoaded) {
            return Column(
              children: [
                // Search Bar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (query) {
                      context.read<LocationsBloc>().add(SearchLocations(query));
                    },
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search locations',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                context.read<LocationsBloc>().add(const SearchLocations(''));
                              },
                            )
                          : null,
                    ),
                  ),
                ),
                // Locations List
                Expanded(
                  child: state.filteredLocations.isEmpty
                      ? Center(
                          child: Text(
                            'No locations found',
                            style: TextStyle(
                              color: isDark ? AppColor.textSecondaryDark : AppColor.textSecondaryLight,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: state.filteredLocations.length,
                          itemBuilder: (context, index) {
                            final loc = state.filteredLocations[index];
                            final badgeColor = loc.isActive 
                                ? primaryColor 
                                : (isDark ? AppColor.borderDark : AppColor.borderLight);
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: InkWell(
                                onTap: () {
                                  context.push('/locations/edit', extra: loc);
                                },
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: isDark ? AppColor.surfaceDark : AppColor.surfaceLight,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: isDark ? AppColor.borderDark : AppColor.borderLight,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      // Location Pin Icon Box
                                      Container(
                                        width: 52,
                                        height: 52,
                                        decoration: BoxDecoration(
                                          color: badgeColor.withOpacity(0.15),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.location_on,
                                          color: loc.isActive 
                                              ? primaryColor 
                                              : (isDark ? AppColor.textSecondaryDark : AppColor.textSecondaryLight),
                                          size: 26,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      // Location Details
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              loc.name,
                                              style: theme.textTheme.bodyLarge?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.explore_outlined,
                                                  size: 14,
                                                  color: isDark ? AppColor.textSecondaryDark : AppColor.textSecondaryLight,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  '${loc.latitude.toStringAsFixed(4)}, ${loc.longitude.toStringAsFixed(4)}',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: isDark ? AppColor.textSecondaryDark : AppColor.textSecondaryLight,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                  decoration: BoxDecoration(
                                                    color: isDark 
                                                        ? AppColor.borderDark.withOpacity(0.5) 
                                                        : AppColor.backgroundLight,
                                                    borderRadius: BorderRadius.circular(6),
                                                  ),
                                                  child: Text(
                                                    '${loc.radius.toInt()} m radius',
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight: FontWeight.w600,
                                                      color: isDark ? AppColor.textSecondaryDark : AppColor.textSecondaryLight,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                StatusBadge(
                                                  type: loc.isActive 
                                                      ? BadgeType.active 
                                                      : BadgeType.inactive,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Icon(
                                        Icons.chevron_right,
                                        color: isDark ? AppColor.textSecondaryDark : AppColor.textSecondaryLight,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/locations/new'),
        backgroundColor: primaryColor,
        foregroundColor: isDark ? AppColor.backgroundDark : Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
