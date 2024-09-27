import 'package:chat_app/Pages/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';

  // CollectionReference messages =
  //     FirebaseFirestore.instance.collection(kMessagesCollection);
  final _controller = ScrollController();

  final TextEditingController _textController = TextEditingController();

  ChatPage({super.key});

  //final TextEditingController controller = TextEditingController();
  //List<MessageModel> messagesList = [];

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;
    // return StreamBuilder<QuerySnapshot>(
    //   stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       List<MessageModel> messagesList = [];
    //       for (int i = 0; i < snapshot.data!.docs.length; i++) {
    //         messagesList.add(
    //           MessageModel.fromjeson(
    //             snapshot.data!.docs[i],
    //           ),
    //         );
    //       }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimeryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLogo,
              height: 50,
            ),
            const Text(
              'Chat',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                var messagesList =
                    BlocProvider.of<ChatCubit>(context).messagesList;
                return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  physics: const BouncingScrollPhysics(),
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    if (messagesList[index].id == email) {
                      return ChatBubble(message: messagesList[index]);
                    } else {
                      return ChatBubbleFromFriend(message: messagesList[index]);
                    }
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _textController,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context)
                    .sendMessage(message: data, emailAddress: email);

                _textController.clear();
                _controller.jumpTo(0);
              },
              decoration: InputDecoration(
                hintText: 'Send Message',
                hintStyle: const TextStyle(color: Colors.grey),
                suffixIcon: IconButton(
                    onPressed: () {
                      String message = _textController.text;

                      BlocProvider.of<ChatCubit>(context)
                          .sendMessage(message: message, emailAddress: email);
                      _textController.clear();
                      _controller.jumpTo(0);
                    },
                    icon: const Icon(
                      Icons.send,
                      color: kPrimeryColor,
                    )),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: kPrimeryColor, width: 1),
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: kPrimeryColor, width: 1),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
