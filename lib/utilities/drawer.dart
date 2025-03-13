// drawer.dart
import 'package:app/screens/change_password.dart';
import 'package:app/screens/edit_profile.dart';
import 'package:app/modal/user_password.dart';
import 'package:app/service/user_service.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  User? user;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }
   
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadUserData(); 
  }

  void _loadUserData() async {
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() {
      user = getUser(); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF1F2F33),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.grey[200],
              backgroundImage: user?.profileImage != null && File(user!.profileImage!).existsSync()
                  ? FileImage(File(user!.profileImage!))
                  : const AssetImage('images/profile_icon.png') as ImageProvider,
            ),
            accountName: Text(user?.userName ?? "user"),
            accountEmail: const Text(''),
          ),
          ListTile(
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const EditProfile()),
              );
              _loadUserData(); 
            },
            title: const Text('Edit profile'),
          ),
          ListTile(
          
            title: const Text('Notification settings'),
          ),
          const ListTile(
            title: Text('Dark mode'),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) =>  ChangePassword()),
              );
            },
            title: const Text('Change password'),
          ),
        ],
      ),
    );
  }
}