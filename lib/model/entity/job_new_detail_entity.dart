import 'package:find_jobs/model/entity/required_job_skills.dart';
import 'package:json_annotation/json_annotation.dart';

part 'job_new_detail_entity.g.dart';


@JsonSerializable()
class JobNewDetailEntity{

  @JsonKey()
  int jobNewsId;

  @JsonKey()
  String ownerName;

  @JsonKey()
  String status;

  @JsonKey()
  String typeOfWorkName;

  @JsonKey()
  String companyName;

  @JsonKey()
  String jobShortDescription;

  @JsonKey()
  int salaryInVnd;

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
      this.companyEmail,
      this.companyPhoneNumber,
      this.requiredJobSkills});


  factory JobNewDetailEntity.fromJson(Map<String, dynamic> json) => _$JobNewDetailEntityFromJson(json);

  Map<String, dynamic> toJson() => _$JobNewDetailEntityToJson(this);
// "jobNewsId": 1,
  // "ownerName": "Trần Thị Bích Hạnh",
  // "statusName": "Đã phê duyệt",
  // "typeOfWorkName": "Full-time",
  // "companyName": "Công ty cổ phần Giao Hàng Tiết Kiệm",
  // "jobShortDescription": "Android Developer",
  // "salaryInVnd": 12000000,
  // "jobDescription": "– Xây dựng những sản phẩm hàng đầu với hệ điều hành Android trên nền tảng cơ sở dữ liệu người dùng lớn; làm việc cùng 1 đội ngũ chuyên nghiệp, dày dặn kinh nghiệm;\n\n– Đồng hành trực tiếp cùng Trưởng bộ phận, Quản lý dự án, đội ngũ Backend và UX trong môi trường linh hoạt, nhanh nhạy để tăng tiến độ phân phối sản phẩm;\n\n– Trực tiếp chủ động, tích cực tham gia vào quá trình triển khai dự án;\n\n– Đóng góp lớn vào lập trình mobile và chuyên môn kỹ thuật của toàn bộ tổ chức;",
  // "subdistrictName": "Phường Mễ Trì",
  // "districtName": "Quận Nam Từ Liêm",
  // "stateProvinceName": "Thành phố Hà Nội",
  // "detailAddress": "TÒA NHÀ GIAO HÀNG TIẾT KIỆM - SỐ 8 PHẠM HÙNG",
  // "requiredNumberYearsOfExperiences": 1,
  // "jobTitleName": "Nhân viên",
  // "companySizeByNumberEmployees": 10000,
  // "companyWebsite": "https://giaohangtietkiem.vn/",
  // "companyEmail": "tuyendung.hn@ghtk.vn",
  // "companyPhoneNumber": "02435720999",
  // "requiredJobSkills": [
  // {
  // "id": 1,
  // "skillName": "Lập trình di động"
  // }
  // ]
}