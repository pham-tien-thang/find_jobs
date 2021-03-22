class New_model {
  int id;
  String imageUrl;
  String title;
  String shortDescription;
  String content;
  New_model({
    this.id,
    this.imageUrl,
    this.title,
    this.shortDescription,
    this.content,
  });


  // Map<String, dynamic> toMap() {
  //   return {
  //     'author':author,
  //     'detail': detail,
  //     'image': image,
  //     'title': title,
  //     'date': date,
  //     'content': content,
  //   };
  // }

  factory New_model.fromJson(Map<String, dynamic> json,int i) {
    return New_model(
      id: json['newsArr'][i]['id'],
      imageUrl: json['newsArr'][i]['imageUrl'].toString() as String,
      title: json['newsArr'][i]['title'] as String,
      content: json['newsArr'][i]['content'] as String,
      shortDescription: json['newsArr'][i]['shortDescription'] as String,
    );
  }
}
List<New_model> new_md=[];