import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:find_jobs/model/entity/my_apply_done.dart';
import 'package:find_jobs/model/entity/my_apply_job_entity.dart';
import 'package:find_jobs/model/enum/load_status.dart';
import 'package:find_jobs/model/response/array_response.dart';
import 'package:find_jobs/repositories/job_repository.dart';

part 'my_apply_jobs_state.dart';

class MyApplyJobsCubit extends Cubit<MyApplyJobsState> {
  JobRepository _jobRepository;
  MyApplyJobsCubit(this._jobRepository) : super(MyApplyJobsState());


  void getListMyApply()async{
    emit(state.copyWith(loadStatus: LoadStatus.LOADING));
    try{
      MyApplyDone response = await _jobRepository.getListMyApply();
      if(response.result == true){
        emit(state.copyWith(loadStatus: LoadStatus.SUCCESS,list: response.appliedJobArr));
      }else{
        emit(state.copyWith(loadStatus: LoadStatus.FAILURE));
      }
    }catch(e){
      emit(state.copyWith(loadStatus: LoadStatus.FAILURE));
    }
  }
}
