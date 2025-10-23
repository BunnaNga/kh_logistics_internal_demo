import 'package:flutter/material.dart';

class MoveItemFromVan extends StatefulWidget {
  const MoveItemFromVan({super.key});

  @override
  State<MoveItemFromVan> createState() => _MoveItemFromVanState();
}

class _MoveItemFromVanState extends State<MoveItemFromVan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Move Item from Van'),
      ),
      body: const Center(
        child: Text('Move Item from Van Screen'),
      ),
    );
  }
}