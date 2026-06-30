import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/constant/app_color.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../locations/presentation/bloc/locations_bloc.dart';
import '../../../tasks/presentation/bloc/tasks_bloc.dart';
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = isDark ? AppColor.primaryDark : AppColor.primaryLight;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated || state is AuthInitial) {
            context.go('/login');
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // User Info Card
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  String name = 'John Doe';
                  String email = 'john.doe@example.com';
                  if (state is AuthAuthenticated) {
                    name = state.name;
                    email = state.email;
                  }
                  // Get initials
                  final initials = name.split(' ').map((e) => e.isNotEmpty ? e[0] : '').take(2).join().toUpperCase();
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: isDark ? AppColor.surfaceDark : AppColor.surfaceLight,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isDark ? AppColor.borderDark : AppColor.borderLight,
                      ),
                    ),
                    child: Column(
                      children: [
                        // Avatar
                        CircleAvatar(
                          radius: 44,
                          backgroundColor: primaryColor.withOpacity(0.15),
                          child: Text(
                            initials.isEmpty ? 'JD' : initials,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Name
                        Text(
                          name,
                          style: theme.textTheme.headlineLarge?.copyWith(
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Email
                        Text(
                          email,
                          style: TextStyle(
                            color: isDark ? AppColor.textSecondaryDark : AppColor.textSecondaryLight,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: primaryColor.withOpacity(0.2),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.verified_user_outlined,
                                size: 14,
                                color: primaryColor,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Field User',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              // Stats Row (Dynamic)
              Row(
                children: [
                  // Tasks Stat
                  Expanded(
                    child: BlocBuilder<TasksBloc, TasksState>(
                      builder: (context, state) {
                        String tasksDone = '0/0';
                        if (state is TasksLoaded) {
                          tasksDone = '${state.completedCount}/${state.totalCount}';
                        }
                        return _buildStatCard(
                          context,
                          title: tasksDone,
                          subtitle: 'Tasks done today',
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Locations Stat
                  Expanded(
                    child: BlocBuilder<LocationsBloc, LocationsState>(
                      builder: (context, state) {
                        int activeCount = 0;
                        if (state is LocationsLoaded) {
                          activeCount = state.allLocations.where((loc) => loc.isActive).length;
                        }
                        return _buildStatCard(
                          context,
                          title: activeCount.toString(),
                          subtitle: 'Active locations',
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Settings List Card
              Container(
                decoration: BoxDecoration(
                  color: isDark ? AppColor.surfaceDark : AppColor.surfaceLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark ? AppColor.borderDark : AppColor.borderLight,
                  ),
                ),
                child: Column(
                  children: [
                    _buildSettingsItem(
                      context,
                      icon: Icons.person_outline,
                      title: 'Edit profile',
                    ),
                    _buildDivider(isDark),
                    _buildSettingsItem(
                      context,
                      icon: Icons.notifications_none_outlined,
                      title: 'Notifications',
                    ),
                    _buildDivider(isDark),
                    _buildSettingsItem(
                      context,
                      icon: Icons.settings_outlined,
                      title: 'Settings',
                    ),
                    _buildDivider(isDark),
                    _buildSettingsItem(
                      context,
                      icon: Icons.help_outline_outlined,
                      title: 'Help & support',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Sign Out Button
              CustomButton(
                text: 'Sign out',
                style: CustomButtonStyle.danger,
                icon: Icons.logout,
                onPressed: () {
                  context.read<AuthBloc>().add(AuthLogoutRequested());
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildStatCard(BuildContext context, {required String title, required String subtitle}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColor.surfaceDark : AppColor.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColor.borderDark : AppColor.borderLight,
        ),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDark ? AppColor.textSecondaryDark : AppColor.textSecondaryLight,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildSettingsItem(BuildContext context, {required IconData icon, required String title}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDark ? AppColor.backgroundDark : AppColor.backgroundLight,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: isDark ? AppColor.textSecondaryDark : AppColor.textSecondaryLight,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: isDark ? AppColor.textSecondaryDark : AppColor.textSecondaryLight,
        size: 20,
      ),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$title clicked')),
        );
      },
    );
  }
  Widget _buildDivider(bool isDark) {
    return Divider(
      height: 1,
      thickness: 1,
      color: isDark ? AppColor.borderDark : AppColor.borderLight,
      indent: 16,
      endIndent: 16,
    );
  }
}

