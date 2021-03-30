part of 'job_detail_cubit.dart';

class JobDetailState extends Equatable {

  LoadStatus loadStatus;
  JobNewDetailEntity jobNewDetailEntity;


  JobDetailState({this.loadStatus, this.jobNewDetailEntity});

  JobDetailState copyWith({
    LoadStatus loadStatus,
    JobNewDetailEntity jobNewDetailEntity,
  }) {
    return new JobDetailState(
      loadStatus: loadStatus ?? this.loadStatus,
      jobNewDetailEntity: jobNewDetailEntity ?? this.jobNewDetailEntity,
    );
  }

  @override
  List<Object> get props => [jobNewDetailEntity,loadStatus];

}
