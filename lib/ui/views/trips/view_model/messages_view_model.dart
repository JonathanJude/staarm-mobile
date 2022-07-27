import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/models/message/message_model.dart';
import 'package:staarm_mobile/core/services/messages/message_service.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';

class MessageViewModel extends BaseViewModel {
  final String tripId;
  final _messageService = locator<MessageService>();

  List _messages;

  MessageViewModel(this.tripId);
  List get messages => _messages;
  set messages(List val) {
    _messages = val;
    notifyListeners();
  }

  Future<void> getMessages() async {
    var res = await _messageService.getMessages(tripId: tripId);
    if (res != null) {
      messages = res;
    }
    notifyListeners();
  }

  void init() async {
    isLoading = true;
    await getMessages();
    isLoading = false;
  }

  String _message = "";

  String get message => _message;

  set message(String val) {
    _message = val.trim();
    notifyListeners();
  }

  bool isSending = false;

  Future<void> sendMessage() async {
    isSending = true;
    await _messageService.sendMessage(
      tripId: tripId,
      message: _message,
    );
    isSending = false;
  }

  void addMessage(MessageModel pusherMessage) {
    _messages.add(pusherMessage);
    print("adding mesage");
    notifyListeners();
  }
}
