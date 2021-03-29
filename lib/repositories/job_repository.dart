import 'package:find_jobs/model/entity/job_detail_entity.dart';
import 'package:find_jobs/network/api_client.dart';

abstract class JobRepository{
 Future<JobDetailEntity> getJobDetail(int id);

}
class JobRepositoryIplm extends JobRepository{

  ApiClient _apiClient;


  JobRepositoryIplm(ApiClient apiClient){

  };

  @override
  Future<JobDetailEntity> getJobDetail(int id) {
    // TODO: implement getJobDetail
    throw UnimplementedError();
  }

}