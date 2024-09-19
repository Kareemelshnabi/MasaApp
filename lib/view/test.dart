// import 'dart:developer';

// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:record/record.dart';
// import 'package:screen_go/extensions/responsive_nums.dart';
// import 'package:uuid/uuid.dart';

// class TestWidget extends StatefulWidget {
//   const TestWidget({super.key});

//   @override
//   State<TestWidget> createState() => _TestWidgetState();
// }

// class _TestWidgetState extends State<TestWidget> {
//   final record = AudioRecorder();
//   late AudioPlayer audioPlayer;
//   bool isPlayer = false;

//   String path = '';
//   String url = '';
//   bool isRecord = false;
//   startRecord() async {
//     final location = await getApplicationDocumentsDirectory();
//     String name = Uuid().v1();
//     if (await record.hasPermission()) {
//       await record.start(RecordConfig(), path: location.path + name + '.mp3');
//       print(path);
//     }
//     print("start record");
//   }

//   stopRecord() async {
//     String? final_path = await record.stop();
//     setState(() {
//       path = final_path!;
//     });
//     print(path);
//     print("stop record");
//   }

//   play(link) async {
//     isPlayer = true;

//     await audioPlayer.play(UrlSource(
//         "https://actions.google.com/sounds/v1/alarms/alarm_clock.ogg"));
//     audioPlayer.onPlayerComplete.listen((event) {
//       setState(() {
//         isPlayer = false; // Reset the player state when audio finishes
//       });
//       log("Audio finished playing");
//     });
//     setState(() {});
//     log("audio Play");
//   }

//   stop(url) async {
//     await audioPlayer.stop();
//     setState(() {
//       isPlayer = false;
//     });
//     log("audio stop");
//   }

//   @override
//   void dispose() {
//     audioPlayer.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     audioPlayer = AudioPlayer();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SizedBox(
//         height: 100.h,
//         width: 100.w,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             IconButton(
//                 onPressed: () {
//                   if (isRecord == true) {
//                     setState(() {
//                       stopRecord();
//                       log("11");
//                       isRecord = false;
//                     });
//                   } else {
//                     setState(() {
//                       startRecord();
//                       log("22");
//                       isRecord = true;
//                     });
//                   }
//                   setState(() {});
//                 },
//                 icon: Icon(isRecord == false ? Icons.mic : Icons.stop)),
//             IconButton(
//                 onPressed: () {
//                   if (isPlayer == true) {
//                     setState(() {
//                       stop(url);
//                       isPlayer = false;
//                     });
//                   } else {
//                     setState(() {
//                       play(url);
//                       isPlayer = true;
//                     });
//                   }
//                 },
//                 icon: Icon(isPlayer == true ? Icons.stop : Icons.play_arrow))
//           ],
//         ),
//       ),
//     );
//   }
// }
