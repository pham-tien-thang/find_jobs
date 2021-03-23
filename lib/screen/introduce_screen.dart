import 'package:find_jobs/screen/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroduceScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IntroduceScreenPage();
  }
}

class _IntroduceScreenPage extends State<IntroduceScreen> {
  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: _controller,
              children: [
                _buildFirstPage(
                  image: 'assets/developer.png',
                  content:
                  '"Bạn là sinh viên mới ra trường đang cần tìm một chỗ để thực tập ? , hay là một developer muốn nhảy việc để tìm kiếm những cơ hội mới nhưng vẫn chưa tìm được một nơi thích hợp để thể hiện khả năng của mình   "',
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                ),
                _buildFirstPage(
                  image: 'assets/shuttle.png',
                  content:
                  '"Tham gia cộng đồng find Jobs để tìm được những công việc công nghệ phù hợp nhất với khả năng của bạn."',
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                ),
                _buildFirstPage(
                  image: 'assets/businessman.png',
                  content: '',
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  isLast: true,
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: SmoothPageIndicator(
                      controller: _controller,
                      count: 3,
                      effect: WormEffect(),
                      onDotClicked: (index) =>
                          _controller.animateToPage(
                            index,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.bounceOut,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFirstPage({String image,
    String content,
    Color backgroundColor,
    Color textColor,
    bool isLast = false}) {
    return Container(
      color: backgroundColor,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width / 2,
            height: MediaQuery
                .of(context)
                .size
                .width / 2,
            child: Image.asset(image),
          ),
          SizedBox(
            height: 30,
          ),
          isLast == true
              ? GestureDetector(
            onTap:(){
              Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => HomeScreen()));
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: MediaQuery
                  .of(context)
                  .size
                  .width / 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.orange,
              ),
              alignment: Alignment.center,
              child: Text(
                'Start',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontFamily: "Schyler",
                ),
              ),
            ),
          )
              : Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              // '"Thấp thoáng ánh mắt đôi môi mang theo hương mê say \n Em cho anh tan trong miên man quên luôn đi đêm ngày \n Chạm nhẹ vội vàng hai ba giây nhưng con tim đâu hay \n Bối rối khẽ lên ngôi yêu thương đong đầy thật đầy"',
              content,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontFamily: "Schyler",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
