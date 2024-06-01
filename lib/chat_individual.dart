import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/Home.dart';
import 'package:test_app/UserProvider.dart';
import 'package:test_app/Usuario.dart';

import 'ChatGroupScreen.dart';
import 'ChatScreen.dart';

class ChatIndividual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Usuario? currentUser = Provider.of<UserManager>(context).currentUser;
    List<Usuario> usuarios = Provider.of<UserManager>(context).usuarios;

    List<Usuario> matches = currentUser?.matches ?? [];

    // Add matches to the list of matches if they are not already there and they are not the current user
    for (Usuario user in usuarios) {
      if (user != currentUser && !matches.contains(user)) {
        matches.add(user);
      }
    }

    List<String> ImagenesPreSets = [
      'assets/U1.jpg',
      'assets/U2.jpg',
      'assets/U3.jpg',
      'assets/U4.jpg',
    ];

    // Generate group chat list with unique matches and their friends
    Set<List<Usuario>> groupChatsSet = {};
    Set<String> seenPairs = {};
    for (var match in matches) {
      if (match.amigo != null) {
        // Exclude the group of current user and their friend
        if ((match == currentUser && match.amigo == currentUser?.amigo) ||
            (match.amigo == currentUser && match == currentUser?.amigo)) {
          continue;
        }

        var pair1 = '${match.nombre}-${match.amigo!.nombre}';
        var pair2 = '${match.amigo!.nombre}-${match.nombre}';
        // Ensure unique groups by adding only one direction of the pair
        if (!seenPairs.contains(pair1) && !seenPairs.contains(pair2)) {
          groupChatsSet.add([match, match.amigo!]);
          seenPairs.add(pair1);
          seenPairs.add(pair2);
        }
      }
    }
    List<List<Usuario>> groupChats = groupChatsSet.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Individual'),
        backgroundColor: Colors.pink,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PantallaPrincipal(),
              ),
            );
          },
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              color: Colors.pink[200],
              child: const TabBar(
                labelColor: Colors.black,
                indicatorColor: Colors.pink,
                tabs: [
                  Tab(text: 'Individual'),
                  Tab(text: 'Grupal'),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.pink[100],
                child: TabBarView(
                  children: [
                    // Contenido de la pestaña "Individual"
                    ListView.builder(
                      itemCount: matches.length,
                      itemBuilder: (context, index) {
                        String imageUrl;
                        if (index < ImagenesPreSets.length) {
                          imageUrl = ImagenesPreSets[index];
                        } else {
                          imageUrl = 'assets/icon.png';
                        }
                        return ListTile(
                          onTap: () {
                            Provider.of<UserManager>(context, listen: false).setChatUser(matches[index]);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(),
                              ),
                            );
                          },
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(imageUrl),
                            radius: 20,
                          ),
                          title: Text(matches[index].nombre),
                          subtitle: Text(matches[index].bio ?? 'No bio available'),
                        );
                      },
                    ),

                    // Contenido de la pestaña "Grupal"
                    ListView.builder(
                      itemCount: groupChats.length,
                      itemBuilder: (context, index) {
                        final group = groupChats[index];
                        final match = group[0];
                        final amigo = group[1];

                        // Get imageUrl for each user in the group
                        String imageUrl1;
                        String imageUrl2;
                        if (usuarios.indexOf(match) < ImagenesPreSets.length) {
                          imageUrl1 = ImagenesPreSets[usuarios.indexOf(match)];
                        } else {
                          imageUrl1 = 'assets/icon.png';
                        }
                        if (usuarios.indexOf(amigo) < ImagenesPreSets.length) {
                          imageUrl2 = ImagenesPreSets[usuarios.indexOf(amigo)];
                        } else {
                          imageUrl2 = 'assets/icon.png';
                        }

                        return ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GroupChatScreen(),
                              ),
                            );
                          },
                          leading: Stack(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(imageUrl1),
                                radius: 20,
                              ),
                              Positioned(
                                right: 0,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(imageUrl2),
                                  radius: 10,
                                ),
                              ),
                            ],
                          ),
                          title: Text('${match.nombre} & ${amigo.nombre}'),
                          subtitle: Text('Group chat'),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
