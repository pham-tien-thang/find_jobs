part of 'job_detail_cubit.dart';

class JobDetailState extends Equatable {
  LoadStatus loadStatus;
  LoadStatus loadApply;
  JobNewDetailEntity jobNewDetailEntity;

  JobDetailState({
    this.loadStatus,
    this.jobNewDetailEntity,
    this.loadApply,
  });

  JobDetailState copyWith({
    LoadStatus loadStatus,
    LoadStatus loadApply,
    JobNewDetailEntity jobNewDetailEntity,
  }) {
    return new JobDetailState(
      loadStatus: loadStatus ?? this.loadStatus,
      loadApply: loadApply ?? this.loadApply,
      jobNewDetailEntity: jobNewDetailEntity ?? this.jobNewDetailEntity,
    );
  }

  @override
  List<Object> get props => [jobNewDetailEntity, loadStatus,loadApply];
}
