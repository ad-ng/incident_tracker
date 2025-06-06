import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:incident_tracker/features/auth/data/repository/auth_repo_impl.dart';
import 'package:incident_tracker/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:incident_tracker/features/home/data/repositories/incident_repo_impl.dart';
import 'package:incident_tracker/features/home/presentation/bloc/incidents_cubit.dart';
import 'package:incident_tracker/features/home/presentation/pages/landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('myIncidents');
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
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: LandingPage(),
      ),
    );
  }
}
