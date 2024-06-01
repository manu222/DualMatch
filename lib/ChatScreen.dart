import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/Chat.dart';
import 'package:test_app/Usuario.dart';
import 'package:test_app/UserProvider.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage(String text) {
    if (text.isNotEmpty) {
      Usuario? currentUser = Provider.of<UserManager>(context, listen: false).currentUser;
      Usuario? chatUser = Provider.of<UserManager>(context, listen: false).chatUser;

      if (currentUser != null && chatUser != null) {
        final message = Mensaje(currentUser, chatUser, text);
        Provider.of<UserManager>(context, listen: false).enviarMensaje(message);
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
    Usuario? chatUser = Provider.of<UserManager>(context).chatUser;

    List<String> ImagenesPreSets = [
      'assets/U1.jpg',
      'assets/U2.jpg',
      'assets/U3.jpg',
      'assets/U4.jpg',
    ];

    String? chatUserImage;

    if(chatUser?.email == 'sandra@mail.com'){
      chatUserImage = ImagenesPreSets[0];
    } else if(chatUser?.email == 'maria@mail.com'){
      chatUserImage = ImagenesPreSets[1];
    } else if(chatUser?.email == 'carlos@mail.com'){
      chatUserImage = ImagenesPreSets[2];
    } else if(chatUser?.email == 'pedro@mail.com'){
      chatUserImage = ImagenesPreSets[3];
    }else{
      chatUserImage = 'assets/icon.png';
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: CircleAvatar(
                radius: 23,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage(chatUserImage),
              ),
            ),
            SizedBox(width: 10),
            Text(chatUser?.nombre ?? ''),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: Consumer<UserManager>(
        builder: (context, userManager, child) {
          List<Mensaje> messages = userManager.getMessages(currentUser, chatUser) ?? [];
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
                  color: Colors.pink[200], // Color de fondo para la parte de entrada de texto
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: 'Escribe aqui tu mensaje...',
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
