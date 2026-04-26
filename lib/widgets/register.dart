import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wedding/constants/app_colors.dart';
import 'package:wedding/cubit/wedding_cubit.dart';

import '../constants/app_assets.dart';

enum AttendingState {
  yes,
  no;

  String get message => switch (this) {
    AttendingState.yes => 'yes',
    AttendingState.no => 'no',
  };

  String get toast => switch (this) {
    AttendingState.yes => 'Cám ơn nha, bọn mình rất vui vì bạn sẽ tham dự!',
    AttendingState.no => 'Tiếc quá, cám ơn phản hồi của bạn!',
  };
}

enum TransportationState {
  yes,
  no;

  String get message => switch (this) {
    TransportationState.yes => 'yes',
    TransportationState.no => 'no',
  };
}

class RSVP extends StatefulWidget {
  const RSVP({super.key});

  @override
  State<RSVP> createState() => _RSVPState();
}

class _RSVPState extends State<RSVP> {
  AttendingState _attending = AttendingState.yes;
  TransportationState _transportation = TransportationState.yes;
  final TextEditingController _editingNameController = TextEditingController();
  final TextEditingController _editingNoteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryBackground,
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 60),
          Text(
            "Hãy đăng ký ở đây nếu bạn cần phương tiện di chuyển nhé!",
            textAlign: .center,
            style: TextStyle(
              fontStyle: .italic,
              fontSize: 12,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: .center,
              children: [
                Container(width: 120, height: 1, color: AppColors.line),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text("♥", style: TextStyle(color: AppColors.line)),
                ),
                Container(width: 120, height: 1, color: AppColors.line),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            width: double.infinity,
            constraints: BoxConstraints(maxWidth: 600),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text("Họ và tên *", style: TextStyle(fontWeight: .w600)),
                const SizedBox(height: 8),
                TextField(
                  controller: _editingNameController,
                  decoration: InputDecoration(
                    hintText: "Aa...",
                    hintStyle: TextStyle(color: AppColors.line),
                    filled: true,
                    fillColor: AppColors.secondaryBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.line),
                    ),
                  ),
                  onChanged: (v) {
                    setState(() {});
                  },
                ),

                const SizedBox(height: 20),
                Text(
                  "Bạn sẽ tham dự chứ? *",
                  style: TextStyle(fontWeight: .w600),
                ),
                const SizedBox(height: 8),
                RadioGroup<AttendingState>(
                  groupValue: _attending,
                  onChanged: (AttendingState? value) {
                    setState(() {
                      _attending = value ?? AttendingState.yes;
                    });
                  },

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const ListTile(
                        title: Text('Có, tôi sẽ đến'),
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        leading: Radio<AttendingState>(
                          value: AttendingState.yes,
                        ),
                      ),
                      const ListTile(
                        title: Text('Rất tiếc, tôi không thể đến được'),
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        leading: Radio<AttendingState>(
                          value: AttendingState.no,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                AnimatedSwitcher(
                  duration: Duration(seconds: 1),
                  child: _attending == AttendingState.yes
                      ? Column(
                          key: const ValueKey('transport_yes'),
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              "Bạn có cần xe đưa đón không? *",
                              style: TextStyle(fontWeight: .w600),
                            ),
                            const SizedBox(height: 8),
                            RadioGroup<TransportationState>(
                              groupValue: _transportation,
                              onChanged: (TransportationState? value) {
                                setState(() {
                                  _transportation =
                                      value ?? TransportationState.yes;
                                });
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const ListTile(
                                    title: Text('Có, tôi cần xe đưa đón'),
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                    leading: Radio<TransportationState>(
                                      value: TransportationState.yes,
                                    ),
                                  ),
                                  const ListTile(
                                    title: Text('Không, tôi sẽ tự đi'),
                                    contentPadding: EdgeInsets.zero,
                                    dense: true,
                                    leading: Radio<TransportationState>(
                                      value: TransportationState.no,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        )
                      : SizedBox.shrink(key: const ValueKey('transport_no')),
                ),
                Text(
                  "Lời nhắn gửi đến cô dâu và chú rể",
                  style: TextStyle(fontWeight: .w600),
                ),
                const SizedBox(height: 8),
                TextField(
                  maxLines: 3,
                  controller: _editingNoteController,
                  decoration: InputDecoration(
                    hintText: "Nhập lời chúc của bạn...",
                    hintStyle: TextStyle(color: AppColors.line),
                    filled: true,
                    fillColor: AppColors.secondaryBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.line),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                BlocBuilder<WeddingCubit, WeddingState>(
                  buildWhen: (p, c) => p.isRegistering != c.isRegistering,
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: _editingNameController.text.isNotEmpty
                          ? () async {
                              if (state.isRegistering) return;
                              await context
                                  .read<WeddingCubit>()
                                  .registerAttendance(
                                    _editingNameController.text,
                                    _attending,
                                    _transportation,
                                    _editingNoteController.text,
                                  );
                              setState(() {
                                _editingNameController.clear();
                                _editingNoteController.clear();
                              });
                            }
                          : null,
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.resolveWith<Color?>((
                              Set<WidgetState> states,
                            ) {
                              if (states.contains(WidgetState.disabled)) {
                                return Colors.grey.shade300;
                              }
                              return AppColors.primaryBackground;
                            }),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10,
                            ), // Set the desired radius
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: state.isRegistering
                            ? Row(
                                mainAxisAlignment: .center,
                                mainAxisSize: .max,
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: .center,
                                mainAxisSize: .max,
                                children: [
                                  SvgPicture.asset(
                                    AppAssets.icSend,
                                    width: 14,
                                    height: 14,
                                    colorFilter: const ColorFilter.mode(
                                      Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "GỬI",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
