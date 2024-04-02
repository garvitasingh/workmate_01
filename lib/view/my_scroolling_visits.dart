// import 'package:flutter/material.dart';
// import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               //Example 03
//               const Text(
//                 '# Expample 03 : Vertical Scroll Direction',
//                 style: TextStyle(color: Colors.grey),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               SizedBox(
//                 height: 150,
//                 child: ScrollLoopAutoScroll(
//                   enableScrollInput: true,
//                   gap: 0,
//                   delayAfterScrollInput: Duration(seconds: 1),
                 
//                   scrollDirection: Axis.vertical,
//                   child: Column(
//                     children: [
//                       ListView.separated(
//                         separatorBuilder: (context, index) => SizedBox(
//                           height: 20,
//                         ),
//                         shrinkWrap: true,
//                         itemCount: 4,
//                         itemBuilder: (context, index) {
//                           return Container(
//                             height: 40,
//                             width: MediaQuery.of(context).size.width - 40,
//                             color: Colors.green,
//                             alignment: Alignment.center,
//                             child: Text(
//                               'ONE $index',
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           );
//                         },
//                       )
//                     ],
//                   ),
//                 ),
//               ),

//               //Example 04
//               const Text(
//                 '# Expample 04 : Horizontal Scroll Direction',
//                 style: TextStyle(color: Colors.grey),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width - 40,
//                 child: ScrollLoopAutoScroll(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: [
//                       Container(
//                         height: 80,
//                         width: MediaQuery.of(context).size.width / 2,
//                         color: Colors.green,
//                         alignment: Alignment.center,
//                         child: const Text(
//                           'ONE',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       Container(
//                         height: 80,
//                         width: MediaQuery.of(context).size.width / 2,
//                         color: Colors.red,
//                         alignment: Alignment.center,
//                         child: const Text(
//                           'FOR',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       Container(
//                         height: 80,
//                         width: MediaQuery.of(context).size.width / 2,
//                         color: Colors.blue,
//                         alignment: Alignment.center,
//                         child: const Text(
//                           'ALL',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       Container(
//                         height: 80,
//                         width: MediaQuery.of(context).size.width / 2,
//                         color: Colors.orange,
//                         alignment: Alignment.center,
//                         child: const Text(
//                           'AND',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       Container(
//                         height: 80,
//                         width: MediaQuery.of(context).size.width / 2,
//                         color: Colors.blue,
//                         alignment: Alignment.center,
//                         child: const Text(
//                           'ALL',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       Container(
//                         height: 80,
//                         width: MediaQuery.of(context).size.width / 2,
//                         color: Colors.red,
//                         alignment: Alignment.center,
//                         child: const Text(
//                           'FOR',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       Container(
//                         height: 80,
//                         width: MediaQuery.of(context).size.width / 2,
//                         color: Colors.green,
//                         alignment: Alignment.center,
//                         child: const Text(
//                           'ONE',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
