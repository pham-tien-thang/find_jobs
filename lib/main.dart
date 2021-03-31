import 'dart:async';

import 'package:dio/dio.dart';
import 'package:find_jobs/network/api_client.dart';
import 'package:find_jobs/repositories/auth_repository.dart';
import 'package:find_jobs/repositories/job_repository.dart';
import 'package:find_jobs/screen/HomeScreen.dart';
import 'package:find_jobs/screen/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'helper/Preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ApiClient _apiClient = MyApp.getApiClient();
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<JobRepository>(create: (context) {
          return JobRepositoryIplm(apiClient: _apiClient);
        }),
        RepositoryProvider<AuthRepository>(create: (context) {
          return AuthRepositoryIplm(apiClient: _apiClient);
        })
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => MyHomePage(title: 'Flutter Demo Home Page'),
          '/home': (context) => HomeScreen(),
        },
        title: 'Việc làm It',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }

  static ApiClient getApiClient() {
    final dio = Dio();
    dio.options.connectTimeout = 30000;
    // dio.interceptors.add(ApiInterceptors());
    final apiClient = ApiClient(dio, baseUrl: "https://find-job-app.herokuapp.com");
    return apiClient;
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ApiClient _apiClient;

  Timer _timer;

  void chuyen() {
    _timer = new Timer(const Duration(milliseconds: 3000), () {
      print(sharedPrefs.check.toString());
      sharedPrefs.check
          ? Navigator.pushReplacement(context,
              new MaterialPageRoute(builder: (context) => HomeScreen()))
          : Navigator.pushReplacement(context,
              new MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    chuyen();
    print('aaaa2');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sharedPrefs.init();
    return Scaffold(
      body: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<JobRepository>(create: (context) {
            return JobRepositoryIplm(apiClient: _apiClient);
          }),
          RepositoryProvider<AuthRepository>(create: (context) {
            return AuthRepositoryIplm(apiClient: _apiClient);
          })
        ],
        child: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Image.asset("assets/logo.png")),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
