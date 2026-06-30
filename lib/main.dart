import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/routes/app_router.dart';
import 'core/themes/app_theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/locations/presentation/bloc/locations_bloc.dart';
import 'features/sync/presentation/bloc/sync_bloc.dart';
import 'features/tasks/presentation/bloc/tasks_bloc.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<TasksBloc>(
          create: (context) => TasksBloc()..add(LoadTasks()),
        ),
        BlocProvider<LocationsBloc>(
          create: (context) => LocationsBloc()..add(LoadLocations()),
        ),
        BlocProvider<SyncBloc>(
          create: (context) => SyncBloc()..add(LoadSyncStatus()),
        ),
      ],
      child: MaterialApp.router(
        title: 'FieldTrack',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system, // Automatically switches based on device settings
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
