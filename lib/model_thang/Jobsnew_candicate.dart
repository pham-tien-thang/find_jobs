class Jobnew_candicate{
  String company_name;
  String jobShortDescription;
  int jobNewsId;
  List<Item_candicate> candicate;
  Jobnew_candicate(this.company_name,this.jobShortDescription,this.jobNewsId,this.candicate);

}
class Item_candicate{
  String avatar;
  String name;
  int id;
  String gender;
  Item_candicate(
      this.id,
      this.avatar,
      this.name,
      this.gender
      );
}