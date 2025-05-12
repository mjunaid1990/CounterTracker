import 'package:flutter/material.dart';
import 'dart:math' as math;

class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> with SingleTickerProviderStateMixin {
  int _counter = 0;
  late AnimationController _animationController;
  late Animation<double> _animation;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _animationController.reset();
      _animationController.forward();
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
        _animationController.reset();
        _animationController.forward();
      }
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      _animationController.reset();
      _animationController.forward();
    });
  }

  Color _getCounterColor() {
    if (_counter > 10) return Colors.purple;
    if (_counter > 5) return Colors.blue;
    if (_counter > 0) return Colors.green;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Counter'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Current Count:',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 1.0 + (_animation.value * 0.2),
                    child: Text(
                      '$_counter',
                      style: TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        color: _getCounterColor(),
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
              LayoutBuilder(
                builder: (context, constraints) {
                  return constraints.maxWidth > 500
                      ? _buildDesktopButtons()
                      : _buildMobileButtons();
                },
              ),
              const SizedBox(height: 40),
              Text(
                _getCounterMessage(),
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey.shade700,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildActionButton(
          onPressed: _decrementCounter,
          icon: Icons.remove,
          label: 'Decrease',
          color: Colors.red,
        ),
        const SizedBox(width: 20),
        _buildActionButton(
          onPressed: _resetCounter,
          icon: Icons.refresh,
          label: 'Reset',
          color: Colors.grey,
        ),
        const SizedBox(width: 20),
        _buildActionButton(
          onPressed: _incrementCounter,
          icon: Icons.add,
          label: 'Increase',
          color: Colors.green,
        ),
      ],
    );
  }

  Widget _buildMobileButtons() {
    return Column(
      children: [
        _buildActionButton(
          onPressed: _incrementCounter,
          icon: Icons.add,
          label: 'Increase',
          color: Colors.green,
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildActionButton(
              onPressed: _decrementCounter,
              icon: Icons.remove,
              label: 'Decrease',
              color: Colors.red,
            ),
            const SizedBox(width: 20),
            _buildActionButton(
              onPressed: _resetCounter,
              icon: Icons.refresh,
              label: 'Reset',
              color: Colors.grey,
            ),
          ],
        ),
      ],
    );
  }

  String _getCounterMessage() {
    if (_counter >= 15) return "Wow! You're on fire! 🔥";
    if (_counter >= 10) return "Great job keeping count! 👏";
    if (_counter >= 5) return "You're getting good at this! 😊";
    if (_counter > 0) return "Just starting, keep going! 👍";
    return "Click '+' to start counting";
  }

  Widget _buildActionButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
            elevation: 5,
            shadowColor: color.withOpacity(0.5),
          ),
          child: Icon(icon, size: 30),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
