import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/battle/presentation/pages/pokemon_selection_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const PokemonSelectionPage();
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Text('Error: ${state.uri}'),
      ),
    ),
  );
} 