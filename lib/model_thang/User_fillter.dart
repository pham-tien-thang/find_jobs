import 'package:find_jobs/model_thang/Skill_jobs.dart';

class User_fillter{
  String name;
  String avatar;
  int id;
  String gender;
  String level;
  String salary;
  String address;
  int tuoi;
  List<Skill_jobs> skill;
  User_fillter(this.name, this.avatar, this.id,this.gender,this.salary,this.address,this.level,this.tuoi,this.skill);
}