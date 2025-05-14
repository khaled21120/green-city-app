import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'widgets/admin_drawer.dart';
import 'widgets/admin_home_body.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Green City'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => GoRouter.of(context).pushNamed('adminProfile'),
          ),
          BackButton(onPressed: () => GoRouter.of(context).pop()),
        ],
      ),
      drawer: const AdminDrawer(),
      body: const AdminHomeBody(),
    );
  }
}
