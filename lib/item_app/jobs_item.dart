// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
//
// // ignore: camel_case_types
// class Domestic_Job extends StatefulWidget {
//   @override
//   _Domestic_JobState createState() => _Domestic_JobState();
// }
//
// // ignore: camel_case_types
// class _Domestic_JobState extends State<Domestic_Job> {
//   // ignore: non_constant_identifier_names
//
//   ScrollController scrollController = new ScrollController();
//
//   bool canCall;
//   @override
//   void initState() {
//     canCall = true;
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // Padding(
//         //   padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
//         //   child: TitleDivider(title: 'VIỆC LÀM TRONG NƯỚC'),
//         // ),
//         FutureBuilder(
//             future: canCall ? fetch_data_domestic_job.getJob() : null,
//             builder: (BuildContext context, AsyncSnapshot snapshot) {
//               if (snapshot.hasData) {
//                 canCall = false;
//                 return ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: snapshot.data.length,
//                     scrollDirection: Axis.vertical,
//                     controller: scrollController,
//                     itemBuilder: (BuildContext context, int index) {
//                       return ItemJob(snapshot.data[index]);
//                     });
//               }
//               canCall = true;
//               return Center(child: CircularProgressIndicator());
//             }),
//       ],
//     );
//   }
// }
