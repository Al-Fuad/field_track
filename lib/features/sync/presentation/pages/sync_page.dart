import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/common/widgets/status_badge.dart';
import '../../../../core/constant/app_color.dart';
import '../bloc/sync_bloc.dart';
class SyncPage extends StatefulWidget {
  const SyncPage({super.key});
  @override
  State<SyncPage> createState() => _SyncPageState();
}
class _SyncPageState extends State<SyncPage> {
  @override
  void initState() {
    super.initState();
    // Load initial sync status
    context.read<SyncBloc>().add(LoadSyncStatus());
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = isDark ? AppColor.primaryDark : AppColor.primaryLight;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sync'),
      ),
      body: BlocBuilder<SyncBloc, SyncState>(
        builder: (context, state) {
          bool isOffline = true;
          int pendingCount = 0;
          List<Map<String, String>> pendingChanges = [];
          bool isSyncing = false;
          if (state is SyncInitial) {
            isOffline = state.isOffline;
            pendingCount = state.pendingCount;
            pendingChanges = state.pendingChanges;
          } else if (state is Syncing) {
            isOffline = state.isOffline;
            pendingCount = state.pendingCount;
            pendingChanges = state.pendingChanges;
            isSyncing = true;
          } else if (state is SyncSuccess) {
            isOffline = state.isOffline;
            pendingCount = state.pendingCount;
            pendingChanges = state.pendingChanges;
          }
          final bannerBgColor = isOffline
              ? (isDark ? AppColor.offlineBgDark : AppColor.offlineBgLight)
              : (isDark ? AppColor.completedBgDark : AppColor.completedBgLight);
          final bannerTextColor = isOffline
              ? (isDark ? AppColor.offlineTextDark : AppColor.offlineTextLight)
              : (isDark ? AppColor.completedTextDark : AppColor.completedTextLight);
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Offline/Online Status Banner
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: bannerBgColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isOffline ? Icons.wifi_off_outlined : Icons.wifi_outlined,
                        color: bannerTextColor,
                        size: 24,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isOffline ? "You're offline" : "You're online",
                              style: TextStyle(
                                color: bannerTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              isOffline 
                                  ? "Changes are saved on this device"
                                  : "All changes are synchronized",
                              style: TextStyle(
                                color: bannerTextColor.withOpacity(0.8),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Pending Card
                Container(
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
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.sync,
                          color: primaryColor,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pendingCount > 0 
                                  ? "$pendingCount changes pending" 
                                  : "Up to date",
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              pendingCount > 0 
                                  ? "Last synced today, 9:45 AM"
                                  : "Synced just now",
                              style: TextStyle(
                                color: isDark ? AppColor.textSecondaryDark : AppColor.textSecondaryLight,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                if (pendingCount > 0) ...[
                  Text(
                    'WAITING TO UPLOAD',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: isDark ? AppColor.textSecondaryDark : AppColor.textSecondaryLight,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Waiting list
                  Expanded(
                    child: ListView.builder(
                      itemCount: pendingChanges.length,
                      itemBuilder: (context, index) {
                        final change = pendingChanges[index];
                        
                        // Decide icon based on type
                        IconData iconData = Icons.assignment_outlined;
                        if (change['title']!.contains('store')) {
                          iconData = Icons.location_on_outlined;
                        } else if (change['title']!.contains('manager')) {
                          iconData = Icons.description_outlined;
                        } else if (change['title']!.contains('inventory')) {
                          iconData = Icons.inventory_2_outlined;
                        }
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
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
                                // Icon box
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: isDark ? AppColor.backgroundDark : AppColor.backgroundLight,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    iconData,
                                    color: isDark ? AppColor.textSecondaryDark : AppColor.textSecondaryLight,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Text details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        change['title']!,
                                        style: theme.textTheme.bodyLarge?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        change['subtitle']!,
                                        style: TextStyle(
                                          color: isDark ? AppColor.textSecondaryDark : AppColor.textSecondaryLight,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Status badge
                                const StatusBadge(type: BadgeType.pending),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ] else ...[
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_done_outlined,
                            size: 64,
                            color: primaryColor.withOpacity(0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'All changes uploaded successfully',
                            style: TextStyle(
                              color: isDark ? AppColor.textSecondaryDark : AppColor.textSecondaryLight,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                // Sync now button
                CustomButton(
                  text: 'Sync now',
                  icon: Icons.sync,
                  isLoading: isSyncing,
                  onPressed: pendingCount > 0
                      ? () {
                          context.read<SyncBloc>().add(TriggerSync());
                        }
                      : null,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

