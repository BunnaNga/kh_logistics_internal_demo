import 'package:flutter/material.dart';

class MoveItemToVan extends StatefulWidget {
  const MoveItemToVan({super.key});

  @override
  State<MoveItemToVan> createState() => _MoveItemToVanState();
}

class _MoveItemToVanState extends State<MoveItemToVan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Move Item to Van'),
      ),
      body: const Center(
        child: Text('Move Item to Van Screen'),
      ),
    );
  }
}