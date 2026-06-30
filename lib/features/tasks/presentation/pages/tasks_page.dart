import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/widgets/status_badge.dart';
import '../../../../core/constant/app_color.dart';
import '../bloc/tasks_bloc.dart';
class TasksPage extends StatelessWidget {
  const TasksPage({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = isDark ? AppColor.primaryDark : AppColor.primaryLight;
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('My tasks'),
            SizedBox(height: 4),
            Text(
              'Monday, Jun 15',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          if (state is TasksLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TasksLoaded) {
            final progress = state.totalCount > 0 
                ? state.completedCount / state.totalCount 
                : 0.0;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress Card
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? AppColor.surfaceDark : AppColor.surfaceLight,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark ? AppColor.borderDark : AppColor.borderLight,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Today's progress",
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${state.completedCount} of ${state.totalCount} done",
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 8,
                            backgroundColor: isDark 
                                ? AppColor.borderDark 
                                : AppColor.borderLight.withOpacity(0.5),
                            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Filters
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: ['All', 'Pending', 'Completed'].map((filter) {
                      final isSelected = state.filter == filter;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: InkWell(
                          onTap: () {
                            context.read<TasksBloc>().add(FilterTasks(filter));
                          },
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected 
                                  ? primaryColor 
                                  : (isDark ? AppColor.surfaceDark : Colors.transparent),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: isSelected 
                                    ? primaryColor 
                                    : (isDark ? AppColor.borderDark : AppColor.borderLight),
                              ),
                            ),
                            child: Text(
                              filter,
                              style: TextStyle(
                                color: isSelected
                                    ? (isDark ? AppColor.backgroundDark : Colors.white)
                                    : (isDark ? AppColor.textPrimaryDark : AppColor.textSecondaryLight),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),
                // Tasks List
                Expanded(
                  child: state.filteredTasks.isEmpty
                      ? Center(
                          child: Text(
                            'No tasks found',
                            style: TextStyle(
                              color: isDark ? AppColor.textSecondaryDark : AppColor.textSecondaryLight,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: state.filteredTasks.length,
                          itemBuilder: (context, index) {
                            final task = state.filteredTasks[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: InkWell(
                                onTap: () {
                                  context.read<TasksBloc>().add(ToggleTaskCompletion(task.id));
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Custom Checkbox
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          color: task.isCompleted 
                                              ? primaryColor 
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.circular(6),
                                          border: Border.all(
                                            color: task.isCompleted 
                                                ? primaryColor 
                                                : (isDark ? AppColor.borderDark : AppColor.borderLight),
                                            width: 2,
                                          ),
                                        ),
                                        child: task.isCompleted
                                            ? Icon(
                                                Icons.check,
                                                size: 16,
                                                color: isDark 
                                                    ? AppColor.backgroundDark 
                                                    : Colors.white,
                                              )
                                            : null,
                                      ),
                                      const SizedBox(width: 16),
                                      // Task Content
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              task.title,
                                              style: theme.textTheme.bodyLarge?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                decoration: task.isCompleted
                                                    ? TextDecoration.lineThrough
                                                    : null,
                                                color: task.isCompleted
                                                    ? (isDark ? AppColor.textSecondaryDark : AppColor.textSecondaryLight)
                                                    : (isDark ? Colors.white : AppColor.textPrimaryLight),
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              task.description,
                                              style: TextStyle(
                                                color: isDark ? AppColor.textSecondaryDark : AppColor.textSecondaryLight,
                                                fontSize: 13,
                                                decoration: task.isCompleted
                                                    ? TextDecoration.lineThrough
                                                    : null,
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.access_time,
                                                  size: 14,
                                                  color: task.isCompleted
                                                      ? (isDark ? AppColor.completedTextDark : AppColor.completedTextLight)
                                                      : (isDark ? AppColor.textSecondaryDark : AppColor.textSecondaryLight),
                                                ),
                                                const SizedBox(width: 6),
                                                Text(
                                                  task.time,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: task.isCompleted
                                                        ? (isDark ? AppColor.completedTextDark : AppColor.completedTextLight)
                                                        : (isDark ? AppColor.textSecondaryDark : AppColor.textSecondaryLight),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Status Badge
                                      StatusBadge(
                                        type: task.isCompleted
                                            ? BadgeType.completed
                                            : BadgeType.pending,
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
    );
  }
}

