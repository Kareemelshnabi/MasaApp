import 'package:get/get.dart';

class VoiceSearch extends GetxController {
 
}



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.red,
//         title: const Text(
//           'Speech Demo',
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(16),
//               child: Text(
//                 _speechToText.isListening
//                     ? "listening..."
//                     : _speechEnabled
//                         ? "Tap the microphone to start listening..."
//                         : "Speech not available",
//                 style: const TextStyle(fontSize: 20.0),
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 padding: const EdgeInsets.all(16),
//                 child: Text(
//                   _wordsSpoken,
//                   style: const TextStyle(
//                     fontSize: 25,
//                     fontWeight: FontWeight.w300,
//                   ),
//                 ),
//               ),
//             ),
//             if (_speechToText.isNotListening && _confidenceLevel > 0)
//               Padding(
//                 padding: const EdgeInsets.only(
//                   bottom: 100,
//                 ),
//                 child: Text(
//                   "Confidence: ${(_confidenceLevel * 100).toStringAsFixed(1)}%",
//                   style: const TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.w200,
//                   ),
//                 ),
//               )
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _speechToText.isListening ? _stopListening : _startListening,
//         tooltip: 'Listen',
//         backgroundColor: Colors.red,
//         child: Icon(
//           _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }
