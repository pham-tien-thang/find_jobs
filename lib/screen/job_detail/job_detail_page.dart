import 'package:find_jobs/common/app_color.dart';
import 'package:find_jobs/component/app_button.dart';
import 'package:find_jobs/item_app/Drawer_findjobs.dart';
import 'package:find_jobs/layout_home/Header_home.dart';
import 'package:find_jobs/model/entity/job_new_detail_entity.dart';
import 'package:find_jobs/model/entity/required_job_skills.dart';
import 'package:find_jobs/model/enum/load_status.dart';
import 'package:find_jobs/repositories/job_repository.dart';
import 'package:find_jobs/screen/job_detail/job_detail_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

  @override
  void initState() {
    final jobRepository = RepositoryProvider.of<JobRepository>(context);
    _jobDetailCubit = JobDetailCubit(jobRepository);
    super.initState();
    _jobDetailCubit.getJobDetail(widget.id);
  }

  @override
  void dispose() {
    _jobDetailCubit.close();
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
        title: Text("Chi tiết ngành nghề"),
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
                      child: Text('Không có dữ liệu'),
                    );
                  }
                  return _buildDetail(state.jobNewDetailEntity);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: AppGreenButton(
                title: 'Đăng kí',
              ),
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
    return a + " triệu VNĐ";
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
              child: Image.network(jobNewDetailEntity?.avatarUrl) ??
                  Image.asset("assets/user.png"),
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
            //     color: jobNewDetailEntity?.status == "Đã phê duyệt"
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
                'Công ty : ', jobNewDetailEntity.companyName.toUpperCase()),
            SizedBox(
              height: 10,
            ),
            _buildFieldJobDetail(
                'Lĩnh vực : ', jobNewDetailEntity.jobShortDescription),
            SizedBox(
              height: 10,
            ),
            _buildFieldJobDetail('Vị trí : ', jobNewDetailEntity.jobTitleName),
            SizedBox(
              height: 10,
            ),
            _buildFieldJobDetail('Mức lương  : ',
                saraly(jobNewDetailEntity?.salaryInVnd.toString())),
            SizedBox(
              height: 10,
            ),
            _buildColumnField(
                'Mô tả công việc: ', jobNewDetailEntity?.jobDescription),
            SizedBox(
              height: 10,
            ),
            _buildColumnField('Địa chỉ : ',
                '${jobNewDetailEntity.detailAddress} , ${jobNewDetailEntity.subdistrictName} , ${jobNewDetailEntity.districtName} , ${jobNewDetailEntity.stateProvinceName}'),
            SizedBox(
              height: 10,
            ),
            _buildFieldJobDetail('Số năm thành lập : ',
                jobNewDetailEntity.requiredNumberYearsOfExperiences.toString()),
            SizedBox(
              height: 10,
            ),
            _buildFieldJobDetail('Số lượng nhân viên : ',
                jobNewDetailEntity.companySizeByNumberEmployees.toString()),
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
                'Số điện thoại : ', jobNewDetailEntity?.companyPhoneNumber),
            SizedBox(
              height: 10,
            ),
            _buildListJobSkills(
                'Kỹ năng yêu cầu : ', jobNewDetailEntity?.requiredJobSkills),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
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
        SizedBox(height: 8,),
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
                    Divider(color: Colors.grey,),
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
