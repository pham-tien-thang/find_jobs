part of 'my_apply_jobs_cubit.dart';


class MyApplyJobsState extends Equatable {
  LoadStatus loadStatus;
  List<MyApplyJobEntity> list;


  MyApplyJobsState({this.loadStatus, this.list});

  MyApplyJobsState copyWith({
    LoadStatus loadStatus,
    List<MyApplyJobEntity> list,
  }) {
    return new MyApplyJobsState(
      loadStatus: loadStatus ?? this.loadStatus,
      list: list ?? this.list,
    );
  }

  @override
  List<Object> get props => [loadStatus,list];
}
