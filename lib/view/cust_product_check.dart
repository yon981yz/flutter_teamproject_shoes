import 'package:flutter/material.dart';
import 'package:flutter_teamproject_shoes/vm/customer_handler.dart';

class CustProductCheck extends StatefulWidget {
  const CustProductCheck({super.key});

  @override
  State<CustProductCheck> createState() => _CustProductCheckState();
}

class _CustProductCheckState extends State<CustProductCheck> {
  CustomerHandler customerHandler = CustomerHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('수령'),
      ),
    );
  }
}