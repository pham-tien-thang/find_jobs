import 'package:equatable/equatable.dart';
import 'package:find_jobs/helper/Preferences.dart';
import 'package:find_jobs/model/entity/apply_job_entity.dart';
import 'package:find_jobs/model/entity/job_detail_entity.dart';
import 'package:find_jobs/model/entity/job_new_detail_entity.dart';
import 'package:find_jobs/model/enum/apply_job_toast.dart';
import 'package:find_jobs/model/enum/load_status.dart';
import 'package:find_jobs/model/param/apply_job_param.dart';
import 'package:find_jobs/model/param/job_detail_param.dart';
import 'package:find_jobs/repositories/job_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'job_detail_state.dart';


class JobDetailCubit extends Cubit<JobDetailState> {
  JobRepository _jobRepository;

  JobDetailCubit(this._jobRepository) : super(JobDetailState());

  final trueToastController = PublishSubject<String>();
  final falseToastController = PublishSubject<String>();

@override
  Future<void> close() {
  trueToastController.close();
  falseToastController.close();
    return super.close();

  }

  void getJobDetail(int id) async {
    emit(state.copyWith(loadStatus: LoadStatus.LOADING));
    try {
      final param = JobDetailParam(jobNewsId: id.toString());
      JobDetailEntity response = await _jobRepository.getJobDetail(param);
      if (response.result == true) {
        emit(state.copyWith(
            jobNewDetailEntity: response.jobNewDetailEntity,
            loadStatus: LoadStatus.SUCCESS));
      } else {
        emit(state.copyWith(loadStatus: LoadStatus.FAILURE));
      }
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.FAILURE));
    }
  }

  void applyJob(String id) async {
    emit(state.copyWith(loadApply: LoadStatus.LOADING));
    try {
      String userID = SharedPrefs().user_id.toString();
      final param = ApplyJobParam(userId: userID, jobNewsId: id);
      ApplyJobEntity response = await _jobRepository.applyJob(param);
      if (response.result == true && response.message != "") {
        emit(state.copyWith(loadApply: LoadStatus.SUCCESS));
        trueToastController.sink.add(response.message);
      }else{
        emit(state.copyWith(loadApply: LoadStatus.FAILURE));
        falseToastController.sink.add(response.message);
      }
    } catch (e) {
      emit(state.copyWith(loadApply: LoadStatus.FAILURE));
      falseToastController.sink.add("Đăng kí thất bại");
    }
  }
}
