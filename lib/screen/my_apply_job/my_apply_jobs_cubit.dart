import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:find_jobs/helper/Preferences.dart';
import 'package:find_jobs/model/entity/apply_job_entity.dart';
import 'package:find_jobs/model/entity/job_detail_entity.dart';
import 'package:find_jobs/model/entity/my_apply_done.dart';
import 'package:find_jobs/model/entity/my_apply_job_entity.dart';
import 'package:find_jobs/model/enum/load_status.dart';
import 'package:find_jobs/model/response/array_response.dart';
import 'package:find_jobs/repositories/job_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'my_apply_jobs_state.dart';

class MyApplyJobsCubit extends Cubit<MyApplyJobsState> {
  JobRepository _jobRepository;

  MyApplyJobsCubit(this._jobRepository) : super(MyApplyJobsState());

  final trueToastController = PublishSubject<String>();
  final falseToastController = PublishSubject<String>();

  @override
  Future<void> close() {
    trueToastController.close();
    falseToastController.close();
    return super.close();

  }

  void getListMyApply() async {
    emit(state.copyWith(loadStatus: LoadStatus.LOADING));
    try {
      MyApplyDone response = await _jobRepository.getListMyApply();
      if (response.result == true) {
        emit(state.copyWith(
            loadStatus: LoadStatus.SUCCESS, list: response.appliedJobArr));
      } else {
        emit(state.copyWith(loadStatus: LoadStatus.FAILURE));
      }
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.FAILURE));
    }
  }

  void deleteMyApplyJob(String jobId) async {
    emit(state.copyWith(deleteApplyStatus: LoadStatus.LOADING));
    try {
      String userID = SharedPrefs().user_id.toString();
      ApplyJobEntity response =
          await _jobRepository.deleteMyApplyJob(userID, jobId);
      if (response.result == true) {
        emit(state.copyWith(deleteApplyStatus: LoadStatus.SUCCESS,message: response.message));
        trueToastController.sink.add(response.message);
      } else {
        emit(state.copyWith(deleteApplyStatus: LoadStatus.FAILURE,message: response.message));
        falseToastController.sink.add(response.message);
      }
    } catch (e) {
      emit(state.copyWith(deleteApplyStatus: LoadStatus.FAILURE));
      falseToastController.sink.add("Hủy thát bại");
    }
  }
}
