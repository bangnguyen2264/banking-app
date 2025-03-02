import 'package:bankingapp/pages/home/home_body.dart';
import 'package:bankingapp/pages/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bankingapp/styles/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<HomeViewmodel>().fetchUser());
  }

  Future<void> _refresh() async {
    await context.read<HomeViewmodel>().fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<HomeViewmodel>(
        builder: (context, HomeViewmodel, child) {
          if (HomeViewmodel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColor.primaryColor_1,
              ),
            );
          }
          if (HomeViewmodel.errorMessage != null) {
            return Center(
              child: Text('Error: ${HomeViewmodel.errorMessage}'),
            );
          }
          final user = HomeViewmodel.user;
          if (user == null) {
            return const Center(
              child: Text('User not found'),
            );
          }
          return RefreshIndicator(
            onRefresh: _refresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: HomeBody(user: user),
            ),
          );
        },
      ),
    );
  }
}
