import 'package:find_jobs/model/entity/job_detail_entity.dart';
import 'package:find_jobs/model/param/job_detail_param.dart';
import 'package:find_jobs/network/api_client.dart';

abstract class AuthRepository{
  // Future<JobDetailEntity> getJobDetail(JobDetailParam param);

}
class AuthRepositoryIplm extends AuthRepository{

  ApiClient _apiClient;


  AuthRepositoryIplm({ApiClient apiClient}){
    _apiClient = apiClient;
  }

  // @override
  // Future<JobDetailEntity> getJobDetail(JobDetailParam param) async {
  //   return await _apiClient.getJobDetail(param.toJson());
  // }

}