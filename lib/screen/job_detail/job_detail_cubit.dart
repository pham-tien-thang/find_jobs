
import 'package:equatable/equatable.dart';
import 'package:find_jobs/model/entity/job_detail_entity.dart';
import 'package:find_jobs/model/entity/job_new_detail_entity.dart';
import 'package:find_jobs/model/enum/load_status.dart';
import 'package:find_jobs/model/param/job_detail_param.dart';
import 'package:find_jobs/repositories/job_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'job_detail_state.dart';

class JobDetailCubit extends Cubit<JobDetailState> {

  JobRepository _jobRepository;
  JobDetailCubit(this._jobRepository) : super(JobDetailState());

  void getJobDetail(int id)async{
    emit(state.copyWith(loadStatus: LoadStatus.LOADING));
    try{
      final param = JobDetailParam(jobNewsId: id);
      JobDetailEntity response = await _jobRepository.getJobDetail(param);
      if(response.result == true){
        emit(state.copyWith(jobNewDetailEntity: response.jobNewDetailEntity,loadStatus: LoadStatus.SUCCESS));
      }else{
        emit(state.copyWith(loadStatus: LoadStatus.FAILURE));
      }
    }catch(e){
      emit(state.copyWith(loadStatus: LoadStatus.FAILURE));
    }

  }
}
