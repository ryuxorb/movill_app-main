import 'package:flutter/material.dart';

class ActiveHistory extends StatelessWidget {
  const ActiveHistory({Key? key}) : super(key: key);

  // 알림메시지 LayOut
  Widget activeitemOne() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          const Expanded(
            child: Text.rich(
              TextSpan(
                  text: 'OOO',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: '님이 차량을 예약하셨습니다.',
                        style: TextStyle(fontWeight: FontWeight.normal)),
                    TextSpan(
                        text: ' 00 전',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 13,
                            color: Colors.black54)),
                  ]),
            ),
          )
        ],
      ),
    );
  }

  Widget newRecentlyActiveView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Recently',
            style: TextStyle(fontSize: 15, color: Colors.black38),
          ),
          const SizedBox(
            height: 10,
          ),
          activeitemOne(),
          activeitemOne(),
          activeitemOne(),
          activeitemOne(),
          activeitemOne(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '알림',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            newRecentlyActiveView(),
          ],
        ),
      ),
    );
  }
}
