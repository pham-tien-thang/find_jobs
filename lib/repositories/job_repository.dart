import 'package:find_jobs/model/entity/apply_job_entity.dart';
import 'package:find_jobs/model/entity/job_detail_entity.dart';
import 'package:find_jobs/model/param/apply_job_param.dart';
import 'package:find_jobs/model/param/job_detail_param.dart';
import 'package:find_jobs/network/api_client.dart';

abstract class JobRepository{
 Future<JobDetailEntity> getJobDetail(JobDetailParam param);
 Future<ApplyJobEntity> applyJob(ApplyJobParam param);

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

}