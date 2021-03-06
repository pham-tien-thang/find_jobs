import 'dart:async';

import 'package:find_jobs/common/app_color.dart';
import 'package:find_jobs/component/app_button.dart';
import 'package:find_jobs/helper/Toast.dart';
import 'package:find_jobs/item_app/Drawer_findjobs.dart';
import 'package:find_jobs/layout_home/Header_home.dart';
import 'package:find_jobs/model/entity/job_new_detail_entity.dart';
import 'package:find_jobs/model/entity/required_job_skills.dart';
import 'package:find_jobs/model/enum/apply_job_toast.dart';
import 'package:find_jobs/model/enum/load_status.dart';
import 'package:find_jobs/repositories/job_repository.dart';
import 'package:find_jobs/screen/job_detail/job_detail_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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
  StreamSubscription _showTrueToast;
  StreamSubscription _showFalseToast;

  @override
  void initState() {
    final jobRepository = RepositoryProvider.of<JobRepository>(context);
    _jobDetailCubit = JobDetailCubit(jobRepository);
    super.initState();
    _jobDetailCubit.getJobDetail(widget.id);
    _showTrueToast = _jobDetailCubit.trueToastController.listen((value) {
      showToast(value, context, Colors.blue, Icons.done);
    });
    _showFalseToast = _jobDetailCubit.falseToastController.listen((value) {
      showToast(value, context, Colors.redAccent, Icons.close);
    });
    // _showMessageSubcription = _jobDetailCubit.showMessageController.listen((value) {
    //   switch(value){
    //     case ApplyJobToast.SUCCESS:
    //       return showToast("???ng tuy???n th??nh c??ng", context, Colors.blue, Icons.done);
    //     case ApplyJobToast.FAILURE:
    //       return showToast("B???n ???? ???ng tuy???n c??ng vi???c n??y", context, Colors.red, Icons.close);
    //     case ApplyJobToast.ERROR:
    //       return showToast("???ng tuy???n th??nh c??ng", context, Colors.amber, Icons.error);
    //   }
    // });
  }

  @override
  void dispose() {
    _jobDetailCubit.close();
    _showTrueToast.cancel();
    _showFalseToast.cancel();
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
        title: Text("Chi ti???t c??ng vi???c"),
        centerTitle: false,
        backgroundColor: AppColor.main,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: BlocBuilder<JobDetailCubit, JobDetailState>(
                cubit: _jobDetailCubit,
                buildWhen: (previous, current) {
                  return previous.loadStatus != current.loadStatus;
                },
                builder: (context, state) {
                  if (state.loadStatus == LoadStatus.LOADING) {
                    return Center(
                      child: SpinKitCircle(
                        color: Colors.green,
                        size: 50,
                      ),
                    );
                  } else if (state.loadStatus == LoadStatus.FAILURE) {
                    return Center(
                      child: Text('Kh??ng c?? d??? li???u'),
                    );
                  }
                  return _buildDetail(state.jobNewDetailEntity);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            BlocBuilder<JobDetailCubit, JobDetailState>(
              cubit: _jobDetailCubit,
              buildWhen: (previous, current) {
                return previous.loadApply != current.loadApply ||
                    previous.loadStatus != current.loadStatus ||
                    previous.jobNewDetailEntity != current.jobNewDetailEntity;
              },
              builder: (context, state) {
                final isLoading = state.loadApply == LoadStatus.LOADING;
                if (state.jobNewDetailEntity?.status == '???? ph?? duy???t') {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: AppGreenButton(
                      borderRadius: 12,
                      height: 40,
                      width: double.infinity,
                      title: '????ng k??',
                      isLoading: isLoading,
                      onPressed: () {
                        _jobDetailCubit.applyJob(widget.id.toString());
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  String saraly(String luong) {
    String a = luong.substring(0, luong.length - 6);
    return a + " tri???u VN??";
  }

  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'could not launch $url';
    }
  }

  Widget _buildFieldJobDetail(String title, String content,
      {bool isPressed = false}) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Container(
                width: 130,
                alignment: Alignment.topLeft,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: isPressed == true
                      ? () {
                          _launchUrl(content);
                        }
                      : () {},
                  child: Container(
                    child: isPressed == true
                        ? Text(
                            content,
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                            ),
                          )
                        : Text(
                            content,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget _buildDetail(JobNewDetailEntity jobNewDetailEntity) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.all(Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 100,
              height: 100,
              child: jobNewDetailEntity?.avatarUrl != null
                  ? Image.network(jobNewDetailEntity?.avatarUrl)
                  : Image.asset("assets/user.png"),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              jobNewDetailEntity?.ownerName,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            // SizedBox(
            //   height: 8,
            // ),
            // Text(
            //   jobNewDetailEntity?.status ?? "",
            //   style: TextStyle(
            //     color: jobNewDetailEntity?.status == "???? ph?? duy???t"
            //         ? Colors.green
            //         : Colors.red,
            //     fontSize: 12,
            //     fontWeight: FontWeight.normal,
            //   ),
            // ),
            SizedBox(
              height: 30,
            ),
            _buildFieldJobDetail(
                'C??ng ty : ', jobNewDetailEntity.companyName.toUpperCase()),
            SizedBox(
              height: 10,
            ),
            _buildFieldJobDetail(
                'L??nh v???c : ', jobNewDetailEntity.jobShortDescription),
            SizedBox(
              height: 10,
            ),
            _buildFieldJobDetail('V??? tr?? : ', jobNewDetailEntity.jobTitleName),
            SizedBox(
              height: 10,
            ),
            _buildFieldJobDetail('M???c l????ng  : ',
                saraly(jobNewDetailEntity?.salaryInVnd.toString())),
            SizedBox(
              height: 10,
            ),
            _buildColumnField(
                'M?? t??? c??ng vi???c: ', jobNewDetailEntity?.jobDescription),

            SizedBox(
              height: 10,
            ),
            _buildColumnField('?????a ch??? : ',
                '${jobNewDetailEntity.detailAddress} , ${jobNewDetailEntity.subdistrictName} , ${jobNewDetailEntity.districtName} , ${jobNewDetailEntity.stateProvinceName}'),
            SizedBox(
              height: 10,
            ),
            _buildFieldJobDetail(
                'Y??u c???u kinh nghi???m : ',
                jobNewDetailEntity.requiredNumberYearsOfExperiences.toString() +
                    " N??m"),
            SizedBox(
              height: 10,
            ),
            _buildFieldJobDetail(
                'S??? l?????ng nh??n vi??n : ',
                jobNewDetailEntity.companySizeByNumberEmployees.toString() +
                    " Ng?????i"),
            SizedBox(
              height: 10,
            ),
            _buildFieldJobDetail(
                'Website : ', jobNewDetailEntity.companyWebsite,
                isPressed: true),
            SizedBox(
              height: 10,
            ),
            _buildFieldJobDetail('Email : ', jobNewDetailEntity?.companyEmail),
            SizedBox(
              height: 10,
            ),
            _buildFieldJobDetail(
                'S??? ??i???n tho???i : ', jobNewDetailEntity?.companyPhoneNumber),
            SizedBox(
              height: 10,
            ),
            _buildFieldJobDetail('Th???i gian ????ng tin: ',
                _convertDateTime(jobNewDetailEntity?.timeCreatedNewsMillis)),
            SizedBox(
              height: 10,
            ),
            _buildFieldJobDetail(
                'Y??u c???u b???t bu???c : ', jobNewDetailEntity?.requiredTechnologyText),
            SizedBox(
              height: 10,
            ),
            _buildListJobSkills(
                'K??? n??ng y??u c???u : ', jobNewDetailEntity?.requiredJobSkills),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  String _convertDateTime(int time) {
    var date = new DateTime.fromMicrosecondsSinceEpoch(time * 1000);
    String formattedDate = DateFormat('dd-MM-yyyy').format(date);
    return formattedDate;
  }

  _buildColumnField(String title, String content) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            content,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Divider(
          color: Colors.grey,
        ),
      ],
    );
  }

  _buildListJobSkills(String title, List<RequiredJobSkill> requiredJobSkills) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Container(
            width: 130,
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: requiredJobSkills.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      child: Text(
                        requiredJobSkills[index].skillName,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
