import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/Chat.dart';
import 'package:test_app/Usuario.dart';
import 'package:test_app/UserProvider.dart';

class GroupChatScreen extends StatefulWidget {
  GroupChatScreen({Key? key}) : super(key: key);

  @override
  _GroupChatScreenState createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage(String text) {
    if (text.isNotEmpty) {
      Usuario? currentUser = Provider.of<UserManager>(context, listen: false).currentUser;
      if (currentUser != null) {
        // Prepare participants: the current user, their friend, and the other two users
        List<Usuario> participants = Provider.of<UserManager>(context, listen: false).usuarios
            .where((user) => user != currentUser).toList();
        participants.insert(0, currentUser);

        final message = MensajeGroup(emisor: currentUser, receptores: participants, texto: text);
        Provider.of<UserManager>(context, listen: false).enviarMensajeGroup(message);
        setState(() {
          // This forces the UI to refresh and show the new message
        });
        _controller.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Usuario? currentUser = Provider.of<UserManager>(context).currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Grupal '),
        backgroundColor: Colors.pink,
      ),
      body: Consumer<UserManager>(
        builder: (context, userManager, child) {
          List<Usuario> participants = userManager.usuarios.where((user) => user != currentUser).toList();
          participants.insert(0, currentUser!);
          List<MensajeGroup> messages = userManager.getGroupMessages(participants) ?? [];

          return Container(
            color: Colors.pink[100], // Background color for the whole body
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      bool isMe = message.emisor == currentUser;
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.pink[400] : Colors.blue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: isMe ? Radius.circular(10) : Radius.circular(0),
                              bottomRight: isMe ? Radius.circular(0) : Radius.circular(10),
                            ),
                          ),
                          child: Text(
                            message.texto ?? '',
                            style: TextStyle(color: isMe ? Colors.white : Colors.black),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  color: Colors.pink[200], // Background color for the text input area
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: 'Escribe aquí tu mensaje...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send, color: Colors.black),
                          onPressed: () => _sendMessage(_controller.text),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
