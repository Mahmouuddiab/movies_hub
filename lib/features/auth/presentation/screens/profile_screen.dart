import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/di/di.dart';
import 'package:movies/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:movies/features/auth/presentation/cubit/auth_states.dart';

class ProfileScreen extends StatelessWidget {
   ProfileScreen({super.key});

   AuthCubit authCubit = getIt<AuthCubit>();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => authCubit..loadProfile(),

      child: BlocConsumer<AuthCubit, AuthStates>(

        listener: (context, state) {
          if (state is ProfileLoggedOut) {
            Navigator.pushReplacementNamed(context, '/login');
          }
        },

        builder: (context, state) {

          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProfileLoaded) {
            return Scaffold(
              appBar: AppBar(title: const Text('Profile')),

              body: Column(
                children: [

                  Text(state.user.name),
                  Text(state.user.email),
                  Text(state.user.role),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthCubit>().logout();
                    },
                    child: const Text('Logout'),
                  ),
                ],
              ),
            );
          }

          if (state is ProfileUnauthenticated) {
            return const Center(child: Text('Please login'));
          }

          if (state is ProfileError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox();
        },
      ),
    );
  }
}
