import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/Home.dart';
import 'package:test_app/UserProvider.dart';
import 'package:test_app/Usuario.dart';

import 'ChatScreen.dart';

class ChatIndividual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Usuario? currentUser = Provider.of<UserManager>(context).currentUser;
    List<Usuario> usuarios = Provider.of<UserManager>(context).usuarios;

    List<Usuario> matches = currentUser?.matches ?? [];

    //add matches to the list of matches if they are not already there and they are not the current user
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
              child:
            const TabBar(

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
                    const Center(
                      child: Text('Contenido Grupal'),
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
