

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget Regulations(double w, double h ,BuildContext context){
  return Dialog(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius:BorderRadius.circular(50),
    ), //this right here
    child: Container(
      width: w,
      height: h,
    //  color: Colors.red,
      decoration:  BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.green,
            Colors.blue,
          ],
        ),
      ),
child:Padding(
  padding: const EdgeInsets.all(15.0),
  child:   Container(
    decoration:  BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(22.5)),
      color: Colors.white
    ),
    child: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("NỘI QUY ĐĂNG BÀI",style: TextStyle(
              fontWeight: FontWeight.bold
            ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(noiquy),
                Text(quyen,style: TextStyle(fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Tôi đồng ý",
              style: TextStyle(color: Colors.white),
            ),
            color:Colors.green,
          ),
        ],
      ),
    ),
  ),
),
    ),
  );
}
String noiquy = "Để nhà tuyển dụng và các ứng viên có lợi ích tốt nhất khi sử dụng ứng dụng, chúng tôi xin yêu cầu nhà tuyển dụng cân nhắc những nội quy đăng bài sau đây:\n\n"+

" - Bài đăng viết đúng chính tả, và viết bằng tiếng Việt có dấu, không sử dụng tiếng Việt không dấu,tiếng nước ngoài hay teen code.\n"+
" - Tên công ty và địa chỉ viết đầy đủ, chính xác.\n"+
" - Website công ty viết bao gồm cả http:// hoặc https:// và còn hoạt động.\n"
" - Mô tả ngắn gọn rõ ràng\n"+
" - Không đăng những tin không phải VIỆC LÀM IT.\n"+
" - Ngôn ngữ phù hợp, không sử dụng những từ ngữ thô tục, thiếu văn hóa, xúc phạm người đọc, hoặc những từ ngữ không phù hợp với pháp luật.\n";

String quyen = " - Chúng tôi có quyền xóa hoặc không phê duyệt những bài viết vi phạm một trong những quy tắc trên và không cần thông báo trước, nếu chúng tôi nhận thấy việc này là vì lợi ích của người dùng.\n"+
    " - Tài khoản cố tình vi phạm có thể bị xóa tài khoản vĩnh viễn mà không được thông báo trước.";