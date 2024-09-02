import 'package:flutter/material.dart';

class MgtTransferapproval extends StatefulWidget {
  const MgtTransferapproval({super.key});

  @override
  State<MgtTransferapproval> createState() => _MgtTransferapprovalState();
}

class _MgtTransferapprovalState extends State<MgtTransferapproval> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),

      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('images/Rectangle.png'),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('최근 주문 및 수령 검색'),
                ),
              ],
            ),

            ElevatedButton(
              onPressed: () {
                ///
              }, 
              child: const Text('수령확인')
            )
          ],
        ),
      ),

    );
  }
}