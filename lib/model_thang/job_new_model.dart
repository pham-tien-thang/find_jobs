import 'package:find_jobs/model_thang/Skill_jobs.dart';

class Job_mew_model{
  String company_name;
  String huyen;
  String title;
  int id;
  String address;
  String time;
  String saraly;
  String position;
  String language;
  List<Skill_jobs> skill;
  Job_mew_model(this.company_name,this.title,this.id,this.address,this.position,this.saraly,this.time,this.huyen,this.language,this.skill);
}