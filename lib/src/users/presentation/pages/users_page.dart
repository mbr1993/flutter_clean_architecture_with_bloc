import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_with_bloc/dependencies_injection.dart';
import 'package:flutter_clean_architecture_with_bloc/src/auth/presentation/login/cubit/auth_cubit.dart';
import 'package:flutter_clean_architecture_with_bloc/src/users/domain/entities/user.dart';
import 'package:flutter_clean_architecture_with_bloc/src/users/domain/use_cases/get_users.dart';
import 'package:flutter_clean_architecture_with_bloc/src/users/presentation/cubit/users_cubit.dart';
import 'package:flutter_clean_architecture_with_bloc/src/users/presentation/cubit/users_state.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  List<User> _users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: const Text('Users Page'),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () => context.read<AuthCubit>().logout(),
          icon: const Icon(Icons.logout_outlined),
        ),
        const SizedBox(width: 16),
      ],
      automaticallyImplyLeading: false,
    );
  }

  BlocProvider<UsersCubit> _body() {
    return BlocProvider(
      create: (BuildContext context) => sl<UsersCubit>()..fetchUsers(UsersParam(page: 2)),
      child: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) {
          switch (state) {
            case UsersLoading():
              return const Center(child: CircularProgressIndicator());
            case UsersLoaded():
              _users = state.users.cast<User>();
              return ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey.shade100,
                      boxShadow: const [
                        BoxShadow(color: Colors.grey, spreadRadius: 1, blurRadius: 5),
                      ],
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 26),
                    padding: const EdgeInsets.all(12),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: CachedNetworkImage(
                            imageUrl: _users[index].avatar ?? '',
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _users[index].name ?? '',
                                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                              Text(
                                _users[index].email ?? '',
                                style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            case UsersError():
              return Center(child: Text(state.message));
            case UsersEmpty():
              return const Center(child: Text('Users-list is Empty'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
