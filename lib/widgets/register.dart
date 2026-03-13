import 'package:flutter/material.dart';
import 'package:wedding/constants/app_colors.dart';

class RSVP extends StatefulWidget {
  const RSVP({super.key});

  @override
  State<RSVP> createState() => _RSVPState();
}

class _RSVPState extends State<RSVP> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryBackground,
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 40),
          Text(
            "Hãy đăng ký ở đây nếu bạn cần phương tiện di chuyển nhé!",
            textAlign: .center,
            style: TextStyle(
              fontStyle: .italic,
              fontSize: 12,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            width: double.infinity,
            constraints: BoxConstraints(
              maxWidth: 800
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15)
            ),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text("Will you be attending? *")
              ],
            ),
          )
        ],
      ),
    );
  }
}
