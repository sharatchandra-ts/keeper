import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keeper/models/user.dart';
import 'package:keeper/themes/app_typography.dart';
import 'package:keeper/widgets/app_text.dart';
import 'package:barcode/barcode.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key, required this.myUser});

  final MyUser myUser;
  final double spacing = 16.0;

  @override
  Widget build(BuildContext context) {
    final User user = context.watch<User>();

    final date = DateFormat(
      'MMMM d, yyyy',
    ).format(DateTime.parse(user.createdAt).toLocal());

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .max,
        children: [
          AppText('name:'),
          AppText(
            myUser.name,
            style: AppTextStyles.body.copyWith(fontSize: 22),
          ),
          SizedBox(height: spacing),

          AppText('email: \n${myUser.email}'),
          SizedBox(height: spacing),

          AppText('phone: \n${myUser.phone ?? 'not there'}'),
          SizedBox(height: spacing),

          AppText('uid: \n${myUser.uid}'),
          SvgPicture.string(
            Barcode.code128().toSvg(
              myUser.uid,
              width: 350,
              height: 60,
              drawText: false,
            ),
          ),
          SizedBox(height: spacing),

          AppText('created on: \n$date'),
        ],
      ),
    );
  }
}

Widget barcodeWidget(String data) {
  final barcode = Barcode.code128();

  final svg = barcode.toSvg(
    data,
    width: 300, // controls width
    height: 80, // controls height (independent!)
    drawText: false,
  );

  return SvgPicture.string(svg);
}
