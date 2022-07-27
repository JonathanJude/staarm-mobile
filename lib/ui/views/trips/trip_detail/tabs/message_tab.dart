import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_pusher/pusher.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/core/managers/pusher_manager.dart';
import 'package:staarm_mobile/core/models/booking_trip_model.dart';
import 'package:staarm_mobile/core/models/message/message_model.dart';
import 'package:staarm_mobile/core/providers/user_provider.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/ui/views/trips/shared/notification_item.dart';
import 'package:staarm_mobile/ui/views/trips/trips_empty_state.dart';
import 'package:staarm_mobile/ui/views/trips/view_model/messages_view_model.dart';
import 'package:staarm_mobile/widgets/chat/left_chat_bubble.dart';
import 'package:staarm_mobile/widgets/chat/right_chat_bubble.dart';
import 'package:staarm_mobile/widgets/indicators/staarm_shimmers.dart';

import '../accept_or_decline_trip_page.dart';

class MessageTab extends StatefulWidget {
  final TripModel trip;
  const MessageTab({Key key, this.trip}) : super(key: key);

  @override
  State<MessageTab> createState() => _MessageTabState();
}

class _MessageTabState extends State<MessageTab> {
  @override
  void dispose() {
    PusherManager.disconnect();
    super.dispose();
  }

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BaseView<MessageViewModel>(
      model: MessageViewModel(widget.trip.id.toString()),
      onModelReady: (model) {
        PusherManager.connect(
          tripId: widget.trip.id.toString(),
          onNewMessage: (message) async {
            Map<String, dynamic> decode = jsonDecode(message["data"]);
            MessageModel pusherMessage =
                MessageModel.fromJson(Map.from(decode["data"]));
            if (pusherMessage.tripId == widget.trip.id) {
              model.addMessage(pusherMessage);
              await Future.delayed(Duration(milliseconds: 500));
              scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }
          },
        );
        model.init();
      },
      builder: (context, model, _) {
        if (model.isLoading || model.messages == null) {
          return StaarmShimmers.loadCars();
        }

        List<MessageModel> messages = model.messages;

        return Column(
          children: [
            Expanded(
              child: Builder(
                builder: (_) {
                  if (messages.isEmpty) {
                    return Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Text(
                              'Say hello!',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color(0xFF231F20),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Introduce yourself and help ${widget.trip.vehicle.vehicleOwner.firstName} prepare for your trip by letting them know your travel plans.',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color(0xFF717171),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView(
                    controller: scrollController,
                    children: [
                      SizedBox(height: 20),
                      ...List.generate(
                        messages.length,
                        (index) {
                          print("id");
                          int uid =
                              (Provider.of<UserProvider>(context, listen: false)
                                  .user
                                  .id);
                          MessageModel message = messages[index];
                          if (message.from == uid) {
                            return RightChatBubble(
                              message: message.content.toString(),
                            );
                          }

                          return LeftChatBubble(
                              message: message.content.toString());
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: chat,
                      onChanged: (v) {
                        model.message = v;
                      },
                      decoration: InputDecoration(
                        hintText: 'Write your message here',
                        hintStyle: TextStyle(
                          color: Color(0xFFACB1B8),
                          fontSize: 14,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () async {
                            if (model.message.isNotEmpty) {
                              model.sendMessage();
                              model.message = "";
                              chat.clear();
                              await Future.delayed(Duration(seconds: 1));
                              scrollController.animateTo(
                                scrollController.position.maxScrollExtent,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          icon: Icon(
                            Icons.send_outlined,
                            color: model.message.isEmpty
                                ? Color(0xFF757D8A)
                                : Colors.purple,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            if (widget.trip.status == "Pending")
              GestureDetector(
                onTap: () async {
                  bool status = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AcceptOrDeclineTripPage(
                        trip: widget.trip,
                      ),
                    ),
                  );
                  if (status != null) {
                    setState(() {
                      if (status) {
                        widget.trip.status = "Accepted";
                      } else {
                        widget.trip.status = "Declined";
                      }
                    });
                  }
                },
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Text(
                    "Accept or Decline",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff824DFF),
                  ),
                ),
              )
          ],
        );
      },
    );
  }

  final TextEditingController chat = TextEditingController();
}
