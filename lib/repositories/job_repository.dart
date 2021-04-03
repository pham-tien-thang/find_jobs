import 'package:find_jobs/helper/Preferences.dart';
import 'package:find_jobs/model/entity/apply_job_entity.dart';
import 'package:find_jobs/model/entity/job_detail_entity.dart';
import 'package:find_jobs/model/entity/my_apply_done.dart';
import 'package:find_jobs/model/entity/my_apply_job_entity.dart';
import 'package:find_jobs/model/param/apply_job_param.dart';
import 'package:find_jobs/model/param/job_detail_param.dart';
import 'package:find_jobs/model/response/array_response.dart';
import 'package:find_jobs/network/api_client.dart';

abstract class JobRepository{
 Future<JobDetailEntity> getJobDetail(JobDetailParam param);
 Future<ApplyJobEntity> applyJob(ApplyJobParam param);
 Future<MyApplyDone> getListMyApply();

}
class JobRepositoryIplm extends JobRepository{

  ApiClient _apiClient;


  JobRepositoryIplm({ApiClient apiClient}){
    _apiClient = apiClient;
  }

  @override
  Future<JobDetailEntity> getJobDetail(JobDetailParam param) async {
    return await _apiClient.getJobDetail(param.toJson());
  }

  @override
  Future<ApplyJobEntity> applyJob(ApplyJobParam param) async {
    return await _apiClient.applyJob(param.toJson());
  }

  @override
  Future<MyApplyDone> getListMyApply()async {
    String userID = SharedPrefs().user_id.toString();
    return await _apiClient.getListMyApply(userID);
  }

}