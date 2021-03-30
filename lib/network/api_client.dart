
import 'package:dio/dio.dart';
import 'package:find_jobs/model/entity/job_detail_entity.dart';
import 'package:retrofit/http.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://find-job-app.herokuapp.com")
abstract class ApiClient{
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/api/job-news/details")
  Future<JobDetailEntity> getJobDetail(@Body() Map<String, dynamic> data);
}