
import 'package:dio/dio.dart';
import 'package:find_jobs/model/entity/apply_job_entity.dart';
import 'package:find_jobs/model/entity/job_detail_entity.dart';
import 'package:find_jobs/model/entity/my_apply_done.dart';
import 'package:find_jobs/model/entity/my_apply_job_entity.dart';
import 'package:find_jobs/model/response/array_response.dart';
import 'package:retrofit/http.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://find-job-app.herokuapp.com")
abstract class ApiClient{
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST("/api/job-news/details")
  Future<JobDetailEntity> getJobDetail(@Body() Map<String, dynamic> data);

  @POST("/api/job-applications/apply-job")
  Future<ApplyJobEntity> applyJob(@Body() Map<String, dynamic> data);

  @POST("/api/job-applications/get-applied-jobs-of-one-candidate")
  Future<MyApplyDone> getListMyApply(@Field() String userId);

  @POST("/api/job-applications/cancel-job-application-from-candidate")
  Future<ApplyJobEntity> deleteMyApplyJob(@Field() String candidateUserId,@Field() String jobNewsId);
}