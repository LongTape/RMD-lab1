import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';
import 'package:lab2/data/repositories/user_repoisitory.dart';

class HomeScreen extends StatefulWidget {
  final UserRepository userRepository;

  HomeScreen({required this.userRepository});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late StreamSubscription _connectivitySubscription;
  bool _isOffline = false;

  @override
  void initState() {
    super.initState();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        _isOffline = result == ConnectivityResult.none;
      });

      if (_isOffline) {
        _showNoInternetDialog();
      }
    });
  }

  void _showNoInternetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('No Internet'),
        content: Text('You are offline. Some features may not be available.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildOfflineLayer() {
    if (_isOffline) {
      return Container(
        color: Colors.black.withOpacity(0.5),
        alignment: Alignment.center,
        child: Text(
          'Offline Mode',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      );
    }
    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Stack(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: _isOffline ? null : () => Navigator.pushNamed(context, '/profile'),
              child: Text('Go to Profile'),
            ),
          ),
          _buildOfflineLayer(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}