import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/pokemon.dart';
import '../providers/pokemon_provider.dart';
import '../providers/battle_provider.dart';
import '../widgets/pokemon_card.dart';
import '../widgets/pokemon_stats_card.dart';
import '../widgets/placeholder_stats_card.dart';

class PokemonSelectionPage extends StatefulWidget {
  const PokemonSelectionPage({super.key});

  @override
  State<PokemonSelectionPage> createState() => _PokemonSelectionPageState();
}

class _PokemonSelectionPageState extends State<PokemonSelectionPage> {
  Pokemon? _selectedPokemon;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PokemonProvider>(context, listen: false).loadPokemons();
    });
  }

  Future<void> _startBattle() async {
    if (_selectedPokemon == null) return;
    
    final battleProvider = Provider.of<BattleProvider>(context, listen: false);
    battleProvider.selectPokemon(_selectedPokemon!);
    await battleProvider.startBattle();
  }

  void _resetBattle() {
    Provider.of<BattleProvider>(context, listen: false).reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Battle of Pokemon',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 32),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Select your pokemon',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Flexible(
                    flex: 2,
                    child: Consumer<PokemonProvider>(
                      builder: (context, provider, child) {
                        if (provider.state == PokemonLoadState.loading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (provider.state == PokemonLoadState.error) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Error loading pokemon list',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 8),
                                Text(provider.errorMessage),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () => provider.loadPokemons(),
                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
                          );
                        } else if (provider.pokemons.isEmpty) {
                          return const Center(
                            child: Text('No pokemons available'),
                          );
                        }
                    
                        return LayoutBuilder(builder: (context, constraints) {
                          final crossAxisCount = _getCrossAxisCount(constraints.maxWidth);
                    
                          return GridView.builder(
                            padding: const EdgeInsets.all(16),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 1,
                            ),
                            itemCount: provider.pokemons.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final pokemon = provider.pokemons[index];
                              return PokemonCard(
                                pokemon: pokemon,
                                isSelected: _selectedPokemon?.id == pokemon.id,
                                onTap: () {
                                  setState(() {
                                    _selectedPokemon = pokemon;
                                    _resetBattle();
                                  });
                                },
                              );
                            },
                          );
                        });
                      },
                    ),
                  ),
                  if (_selectedPokemon != null)
                    SizedBox(
                      child: Consumer<BattleProvider>(
                        builder: (context, battleProvider, child) {
                          if (battleProvider.state == BattleState.completed && battleProvider.battleResult != null) {
                            return Column(
                              children: [
                                TweenAnimationBuilder(
                                  duration: const Duration(milliseconds: 300),
                                  tween: Tween<double>(begin: 0, end: 1),
                                  builder: (context, value, child) => ConstrainedBox(
                                    constraints: BoxConstraints(maxHeight: value * 400),
                                    child: Opacity(
                                      opacity: value,
                                      child: Container(
                                        width: double.infinity,
                                        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                                        decoration: BoxDecoration(
                                          color: const Color(0XFFe4f8fe),
                                          borderRadius: BorderRadius.circular(4.0),
                                          border: Border.all(color: Colors.black, width: 1.0),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color.fromARGB(255, 146, 146, 146),
                                              offset: Offset(0, 3),
                                              blurRadius: 6,
                                              spreadRadius: 2,
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${battleProvider.battleResult?.winner.name} wins!',
                                              style: Theme.of(context).textTheme.titleLarge,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                _buildBattleArea(battleProvider),
                              ],
                            );
                          }
                          
                          return _buildBattleArea(battleProvider);
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBattleArea(BattleProvider battleProvider) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isVerticalLayout = constraints.maxWidth < 600;
          
          final battleButton = Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isVerticalLayout ? 0 : 16.0,
              vertical: isVerticalLayout ? 16.0 : 0,
            ),
            child: Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 146, 146, 146),
                    offset: Offset(0, 3),
                    blurRadius: 6,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF377638),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                onPressed: battleProvider.state == BattleState.battling ? null :
                  (battleProvider.state == BattleState.completed ? _resetBattle : _startBattle),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    battleProvider.state == BattleState.completed 
                      ? 'New Battle' 
                      : (battleProvider.state == BattleState.battling ? 'Fighting...' : 'Start Battle'),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: const Color(0xFFd6e4d9)
                    ),
                  ),
                ),
              ),
            ),
          );
          
          final userPokemonCard = ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 400, maxWidth: 300),
            child: PokemonStatsCard(pokemon: _selectedPokemon!),
          );
          
          final opponentPokemonCard = ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 400, maxWidth: 300),
            child: battleProvider.opponentPokemon != null 
              ? PokemonStatsCard(pokemon: battleProvider.opponentPokemon!)
              : const PlaceholderStatsCard(),
          );
          
          if (isVerticalLayout) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                userPokemonCard,
                battleButton,
                opponentPokemonCard,
              ],
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(child: userPokemonCard),
                battleButton,
                Flexible(child: opponentPokemonCard),
              ],
            );
          }
        },
      ),
    );
  }

  int _getCrossAxisCount(double width) {
    if (width <= 400) return 2;
    if (width <= 600) return 3;
    if (width <= 800) return 4;
    return 5;
  }
}
