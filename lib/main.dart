import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:incident_tracker/conf/dio/dioservice.dart';
import 'package:incident_tracker/features/auth/data/datasources/local/tokenStore.dart';
import 'package:incident_tracker/features/auth/data/repository/auth_repo_impl.dart';
import 'package:incident_tracker/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:incident_tracker/features/auth/presentation/pages/loginPage.dart';
import 'package:incident_tracker/features/home/data/repositories/incident_repo_impl.dart';
import 'package:incident_tracker/features/home/presentation/bloc/incidents_cubit.dart';
import 'package:incident_tracker/features/home/presentation/pages/landing_page.dart';

var tokenValue;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioService.instance.setup();
  await Hive.initFlutter();
  await Hive.openBox('myIncidents');
  tokenValue = await TokenStore.getToken();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _authRepo = AuthRepoImpl();
  final incidentRepo = IncidentRepoImpl();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(_authRepo)),
        BlocProvider(create: (context) => IncidentCubit(incidentRepo)),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade700),
        ),
        routerConfig: _router,
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      name: '/',
      path: '/',
      builder:
          (context, state) =>
              (tokenValue == null) ? LogInPage() : LandingPage(),
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => LogInPage(),
    ),
    GoRoute(
      name: 'landingPage',
      path: '/landingPage',
      builder: (context, state) => LandingPage(),
    ),
  ],
);
