// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ApiClient implements ApiClient {
  _ApiClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://find-job-app.herokuapp.com';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<JobDetailEntity> getJobDetail(data) async {
    ArgumentError.checkNotNull(data, 'data');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '/api/job-news/details',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = JobDetailEntity.fromJson(_result.data);
    return value;
  }

  @override
  Future<ApplyJobEntity> applyJob(data) async {
    ArgumentError.checkNotNull(data, 'data');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(data ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        '/api/job-applications/apply-job',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ApplyJobEntity.fromJson(_result.data);
    return value;
  }

  @override
  Future<MyApplyDone> getListMyApply(userId) async {
    ArgumentError.checkNotNull(userId, 'userId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'userId': userId};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        '/api/job-applications/get-applied-jobs-of-one-candidate',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MyApplyDone.fromJson(_result.data);
    return value;
  }

  @override
  Future<ApplyJobEntity> deleteMyApplyJob(candidateUserId, jobNewsId) async {
    ArgumentError.checkNotNull(candidateUserId, 'candidateUserId');
    ArgumentError.checkNotNull(jobNewsId, 'jobNewsId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'candidateUserId': candidateUserId, 'jobNewsId': jobNewsId};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        '/api/job-applications/cancel-job-application-from-candidate',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ApplyJobEntity.fromJson(_result.data);
    return value;
  }
}
