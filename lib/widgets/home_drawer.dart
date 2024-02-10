import 'package:emotion_chat/screens/chat_page.dart';
import 'package:emotion_chat/screens/user_list.dart';
import 'package:emotion_chat/service/auth/auth_service.dart';
import 'package:emotion_chat/screens/settings_page.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  void signOut() {
    // get auth service
    // final authService = Provider.of<AuthService>(context, listen: false);
    // authService.signOut();
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // logo
              DrawerHeader(
                  child: Center(
                child: Icon(Icons.message,
                    color: Theme.of(context).colorScheme.primary, size: 40),
              )),

              // home list tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: const Text("H O M E"),
                  leading: const Icon(Icons.home),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              // settings list tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: const Text("S E T T I N G S"),
                  leading: const Icon(Icons.settings),
                  onTap: () {
                    //pop the drawer
                    Navigator.pop(context);

                    //Navigate to settings page
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsPage(),
                        ));
                  },
                ),
              ),

              // home list tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: const Text("C H A T  P A G E"),
                  leading: const Icon(Icons.chat_bubble),
                  onTap: () {
                    //pop the drawer
                    Navigator.pop(context);

                    //Navigate to Chat page;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserList(),
                        ));
                  },
                ),
              ),
            ],
          ),

          // logout tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25),
            child: ListTile(
              title: const Text("L O G O U T"),
              leading: const Icon(Icons.logout),
              onTap: signOut,
            ),
          ),
        ],
      ),
    );
  }
}
