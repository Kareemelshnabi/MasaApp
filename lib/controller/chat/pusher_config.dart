// import 'dart:developer';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

// class PusherConfig {
//   late PusherChannelsFlutter _pusher;
//   String appId = "1858364";
//   String apiKey = "0326af3741d783c83221";
//   String secret = "9face0f1ca1ceee8fa97";
//   String apiCluster = "eu";

//   Future<void> initPusher(Function(PusherEvent) onEvent, {String channelName = "chat.room", String? roomId}) async {
//     _pusher = PusherChannelsFlutter.getInstance();
//     try {
//       await _pusher.init(
//         apiKey: apiKey,
//         cluster: apiCluster,
//         onConnectionStateChange: onConnectionStateChange,
//         onError: onError,
//         onSubscriptionSucceeded: onSubscriptionSucceeded,
//         onEvent: onEvent,  // Passing the onEvent handler function here
//         onSubscriptionError: onSubscriptionError,
//         onDecryptionFailure: onDecryptionFailure,
//         onMemberAdded: onMemberAdded,
//         onMemberRemoved: onMemberRemoved,
//       );

//       final channel = roomId != null ? "$channelName.$roomId" : channelName;

//       try {
//         await _pusher.subscribe(channelName: channel);
//         log("Successfully subscribed to : $channel");
//       } catch (e) {
//         log("Subscription error: $e");
//       }

//       await _pusher.connect();
//     } catch (e) {
//       log("Error initializing Pusher: $e");
//     }
//   }

//   void disconnect() {
//     _pusher.disconnect();
//   }

//   void onConnectionStateChange(dynamic currentState, dynamic previousState) {
//     log("Connection state changed: $currentState (previous: $previousState)");
//   }

//   void onError(String message, int? code, dynamic e) {
//     log("Error: $message, Code: $code, Exception: $e");
//   }

//   void onSubscriptionSucceeded(String channelName, dynamic data) {
//     log("Subscription succeeded for channel: $channelName");
//     final me = _pusher.getChannel(channelName)?.me;
//     log("Me: $me");
//   }

//   void onSubscriptionError(String message, dynamic e) {
//     log("Subscription error: $message, Exception: $e");
//   }

//   void onDecryptionFailure(String event, String reason) {
//     log("Decryption failure: $event, Reason: $reason");
//   }

//   void onMemberAdded(String channelName, PusherMember member) {
//     log("Member added to channel: $channelName, User: $member");
//   }

//   void onMemberRemoved(String channelName, PusherMember member) {
//     log("Member removed from channel: $channelName, User: $member");
//   }

//   void connect() {
//     _pusher.connect();
//   }
// }
