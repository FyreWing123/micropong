import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF9110DC)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80, child: Akun()),
                ListTile(
                  leading: Icon(Icons.diamond, color: Colors.amber, size: 25),
                  title: Text(
                    'Penyedia Jasa',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Edit(),
          Settings(),
          Logout(),
        ],
      ),
    );
  }
}

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(leading: Icon(Icons.logout), title: Text('Logout'));
  }
}

class Edit extends StatelessWidget {
  const Edit({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.edit),
      title: Text('Edit Profile'),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.history),
      title: Text('Riwayat Pemesanan'),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}

class Akun extends StatelessWidget {
  const Akun({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(radius: 30, child: Icon(Icons.person)),
      title: Text('Ahmad Reza', style: TextStyle(color: Colors.white)),
      subtitle: Text(
        'Universitas Airlangga',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
