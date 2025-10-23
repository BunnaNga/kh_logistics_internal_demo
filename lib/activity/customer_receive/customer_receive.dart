import 'package:flutter/material.dart';

class CustomerReceive extends StatefulWidget {
  const CustomerReceive({super.key});

  @override
  State<CustomerReceive> createState() => _CustomerReceiveState();
}

class _CustomerReceiveState extends State<CustomerReceive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Receive'),
      ),
      body: const Center(
        child: Text('Customer Receive Screen'),
      ),
    );
  }
}
