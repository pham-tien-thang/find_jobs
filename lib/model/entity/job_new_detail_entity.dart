import 'package:find_jobs/model/entity/required_job_skills.dart';
import 'package:json_annotation/json_annotation.dart';

part 'job_new_detail_entity.g.dart';


@JsonSerializable()
class JobNewDetailEntity{

  @JsonKey()
  int jobNewsId;

  @JsonKey()
  String ownerName;

  @JsonKey(name: "statusName")
  String status;

  @JsonKey()
  String avatarUrl;

  @JsonKey()
  String typeOfWorkName;

  @JsonKey()
  String companyName;

  @JsonKey()
  String jobShortDescription;

  @JsonKey()
  int salaryInVnd;

  @JsonKey()
  int timeCreatedNewsMillis;

  @JsonKey()
  String jobDescription;

  @JsonKey()
  String subdistrictName;

  @JsonKey()
  String districtName;

  @JsonKey()
  String stateProvinceName;

  @JsonKey()
  String detailAddress;

  @JsonKey()
  int requiredNumberYearsOfExperiences;

  @JsonKey()
  String jobTitleName;

  @JsonKey()
  int companySizeByNumberEmployees;

  @JsonKey()
  String companyWebsite;

  @JsonKey()
  String companyEmail;

  @JsonKey()
  String companyPhoneNumber;

  @JsonKey()
  List<RequiredJobSkill> requiredJobSkills;

  JobNewDetailEntity(
      {this.jobNewsId,
      this.ownerName,
      this.avatarUrl,
      this.status,
      this.typeOfWorkName,
      this.companyName,
      this.jobShortDescription,
      this.salaryInVnd,
      this.jobDescription,
      this.subdistrictName,
      this.districtName,
      this.stateProvinceName,
      this.detailAddress,
      this.requiredNumberYearsOfExperiences,
      this.jobTitleName,
      this.companySizeByNumberEmployees,
      this.companyWebsite,
      this.timeCreatedNewsMillis,
      this.companyEmail,
      this.companyPhoneNumber,
      this.requiredJobSkills});


  factory JobNewDetailEntity.fromJson(Map<String, dynamic> json) => _$JobNewDetailEntityFromJson(json);

  Map<String, dynamic> toJson() => _$JobNewDetailEntityToJson(this);
}