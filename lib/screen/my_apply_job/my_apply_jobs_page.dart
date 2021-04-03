import 'dart:async';

import 'package:find_jobs/common/app_color.dart';
import 'package:find_jobs/component/app_button.dart';
import 'package:find_jobs/helper/Toast.dart';
import 'package:find_jobs/model/entity/my_apply_job_entity.dart';
import 'package:find_jobs/model/enum/load_status.dart';
import 'package:find_jobs/repositories/job_repository.dart';
import 'package:find_jobs/screen/job_detail/job_detail_page.dart';
import 'package:find_jobs/screen/my_apply_job/my_apply_jobs_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyApplyJobsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApplyJobsPageState();
  }
}

class _MyApplyJobsPageState extends State<MyApplyJobsPage> {
  MyApplyJobsCubit _cubit;

  // StreamSubscription _showTrueToast;
  // StreamSubscription _showFalseToast;

  @override
  void initState() {
    final jobRepository = RepositoryProvider.of<JobRepository>(context);
    _cubit = MyApplyJobsCubit(jobRepository);
    super.initState();
    _cubit.getListMyApply();
    // _showTrueToast = _cubit.trueToastController.listen((value) {
    //   showToast(value, context, Colors.blue, Icons.done);
    // });
    // _showFalseToast = _cubit.falseToastController.listen((value) {
    //   showToast(value, context, Colors.redAccent, Icons.close);
    // });
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Danh sách việc làm đã ứng tuyển"),
        centerTitle: false,
        backgroundColor: AppColor.main,
      ),
      body: BlocBuilder<MyApplyJobsCubit, MyApplyJobsState>(
        cubit: _cubit,
        buildWhen: (previous, current) {
          return previous.loadStatus != current.loadStatus;
        },
        builder: (context, state) {
          if (state.loadStatus == LoadStatus.LOADING) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              child: SpinKitPulse(
                size: 50,
                color: Colors.greenAccent,
              ),
            );
          } else if (state.loadStatus == LoadStatus.FAILURE) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              child: Text('Tải thất bại'),
            );
          } else {
            return ListView.builder(
              padding: EdgeInsets.all(20),
              itemCount: state.list.length,
              itemBuilder: (context, index) {
                return _buildItem(state.list[index]);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildItem(MyApplyJobEntity entity) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          _buildFieldInItem(
              "Tên công ty", entity?.companyName.toUpperCase() ?? ""),
          Divider(
            color: Colors.grey,
          ),
          _buildFieldInItem("Mô tả", entity?.jobShortDescription ?? ""),
          SizedBox(
            height: 12,
          ),
          // ///////////////////////////////////jfjshjhdjfhsj
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppSmallBlueButton(
                  borderRadius: 8,
                  height: 30,
                  width: 80,
                  title: "Chi tiết",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                JobDetailPage(id: entity.jobNewsId)));
                  },
                ),
                SizedBox(
                  width: 8,
                ),
                AppSmallRedButton(
                  borderRadius: 8,
                  height: 30,
                  width: 80,
                  title: "Xóa",
                  onPressed: () {
                    _showDialogError(
                        "Bạn có đồng ý hủy không ?", entity.jobNewsId);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDialogError(String message, int index) {
    showDialog(
        useRootNavigator: true,
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
              return BlocBuilder<MyApplyJobsCubit, MyApplyJobsState>(
                cubit: _cubit,
                buildWhen: (previous, current) =>
                    previous.deleteApplyStatus != current.deleteApplyStatus ||
                    previous.message != current.message,
                builder: (context, state) {
                  if (state.deleteApplyStatus == LoadStatus.LOADING) {
                    return Container(
                      color: Colors.transparent,
                      child: Center(
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    );
                  } else if (state.deleteApplyStatus == LoadStatus.INITIAL) {
                    return CupertinoAlertDialog(
                      title: Text("Xác nhận"),
                      content: Text(message),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          child: Text('Đồng ý',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.blue,
                              )),
                          onPressed: () =>
                              _cubit.deleteMyApplyJob(index.toString()),
                        ),
                        CupertinoDialogAction(
                          child: Text('Hủy',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.blue,
                              )),
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                      ],
                    );
                  } else {
                    return CupertinoAlertDialog(
                      title: Text(state.message),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          child: Text('Đồng ý',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.blue,
                              )),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                            _cubit.getListMyApply();
                          },
                        ),
                      ],
                    );
                  }
                },
              );
            } ??
            false);
  }

  _buildFieldInItem(String s, String t) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        children: [
          Text(
            "$s : ",
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              t,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildButton(String s) {}
}
