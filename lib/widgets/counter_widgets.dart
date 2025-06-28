import 'package:flutter/material.dart';

class CounterDisplay extends StatelessWidget {
  final int value;
  final bool isLoading;
  final String label;

  const CounterDisplay({
    super.key,
    required this.value,
    this.isLoading = false,
    this.label = 'Counter',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 8),
          if (isLoading)
            const CircularProgressIndicator()
          else
            Text(
              '$value',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final VoidCallback? onReset;
  final bool isEnabled;

  const ActionButtons({
    super.key,
    this.onIncrement,
    this.onDecrement,
    this.onReset,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FloatingActionButton(
          onPressed: isEnabled ? onDecrement : null,
          heroTag: "decrement",
          tooltip: 'Decrease',
          child: const Icon(Icons.remove),
        ),
        FloatingActionButton.extended(
          onPressed: isEnabled ? onReset : null,
          heroTag: "reset",
          tooltip: 'Reset',
          label: const Text('Reset'),
          icon: const Icon(Icons.refresh),
        ),
        FloatingActionButton(
          onPressed: isEnabled ? onIncrement : null,
          heroTag: "increment",
          tooltip: 'Increase',
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String title;
  final List<String> features;
  final IconData icon;

  const FeatureCard({
    super.key,
    required this.title,
    required this.features,
    this.icon = Icons.info_outline,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...features.map(
              (feature) => Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(feature, style: const TextStyle(height: 1.5)),
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
