import 'package:find_jobs/item_app/Drawer_findjobs.dart';
import 'package:find_jobs/layout_home/Header_home.dart';
import 'package:find_jobs/screen/job_detail/job_detail_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobDetailPage extends StatefulWidget {
  final int id;

  const JobDetailPage({Key key, this.id}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _JobDetailPageState();
  }
}

class _JobDetailPageState extends State<JobDetailPage> {

  JobDetailCubit _jobDetailCubit;

  @override
  void initState() {
    final authRepo = RepositoryProvider.of(context);
    _jobDetailCubit = JobDetailCubit(authRepo);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer_findjobs(),
      body: SafeArea(
        child: Column(
          children: [
            header(),

          ],
        ),
      ),
    );
  }
}