import 'package:find_jobs/model/News_model.dart';
import 'package:find_jobs/screen/New_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class new_lazy extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final New_model new_lz;
  const new_lazy(this.new_lz);


  @override
  Widget build(BuildContext context) {
    double mda = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //==============imgae
          Container(
            width: mda,
            child: GestureDetector(
              onTap:(){
                Navigator.push(context, new MaterialPageRoute(builder: (context)=>New_detail(title: new_lz.title,content: new_lz.content,img: new_lz.imageUrl,)));
              },
              child: Image.network(
                new_lz.imageUrl,
                fit: BoxFit.fitWidth,
                //fit: BoxFit.fitHeight,
                // height: 250,
              ),
            ),
          ),
          //===============title
          Padding(
            padding:
            const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: GestureDetector(
              onTap:(){

              },
              child: Text(
                new_lz.title,
                style: TextStyle(
                    fontSize: mda / 24,
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
              ),
            ),
          ),
          //=================des
          Container(
            // margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            // color: Colors.green,
            child:  new_lz.shortDescription.length>0?Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text(
                  new_lz.shortDescription
              ),
            ):null,
          ),
          //==============date
          Padding(
            padding:
            const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              crossAxisAlignment:
              CrossAxisAlignment.center,
              children: [
                Container(),
                GestureDetector(
                    onTap:(){
                      Navigator.push(context, new MaterialPageRoute(builder: (context)=>New_detail(title: new_lz.title,content: new_lz.content,img: new_lz.imageUrl,)));
                    },
                    child: Text(
                      "CHI TIẾT >>",
                      style: TextStyle(
                          fontSize: mda / 22,
                          color: Colors.blue.shade700),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
