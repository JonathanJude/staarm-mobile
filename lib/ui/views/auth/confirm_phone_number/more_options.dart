import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../styles/colors.dart';
import '../../../../styles/textstyles.dart';
import '../../../../widgets/buttons/app_button.dart';

class MoreConfirmationOptions extends StatelessWidget {
  const MoreConfirmationOptions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: 'Choose another way to get a verification code to ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
            children: [
              TextSpan(
                text: ' 08028297955: ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text('Make sure it matches the name on your government ID.',
              style: AppTextStyles.toolInfo.copyWith(color: Color(0xFFB0B0B0))),
        ),
        SizedBox(height: 20),
        MoreOptionItem(
          icon: MdiIcons.locker,
          title: 'SMS',
          subtitle: 'Check your text messages',
          groupValue: 1,
          value: 1,
        ),

        MoreOptionItem(
          icon: MdiIcons.locker,
          title: 'Phone call',
          subtitle: 'Get an automated call',
          groupValue: 1,
          value: 2,
        ),

        MoreOptionItem(
          icon: MdiIcons.whatsapp,
          title: 'WhatsApp',
          subtitle: 'Check your WhatsApp messages',
          groupValue: 1,
          value: 3,
        ),

        SizedBox(height: 30),
        AppButton(
          color: Colors.black,
          textColor: Colors.white,
          text: 'Resend code',
          onPressed: () {
            //
          },
        ),
        SizedBox(height: 30),
      ],
    );
  }
}

class MoreOptionItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final int value;
  final int groupValue;
  const MoreOptionItem({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.icon,
    @required this.value,
    @required this.groupValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 0),
          controlAffinity: ListTileControlAffinity.trailing,
          activeColor: Colors.black,
          secondary: Icon(
            icon ?? Icons.phone_android,
            color: AppColors.grey5,
            size: 28,
          ),
          value: value,
          groupValue: groupValue,
          onChanged: (val) {},
          title: Text(
            title ?? '',
            style: AppTextStyles.cta,
          ),
          subtitle: Text(
            subtitle ?? '',
            style: AppTextStyles.toolInfo.copyWith(
              color: Color(0xFFB0B0B0),
            ),
          ),
        ),

        Divider(
          color: Color(0xFFE7E7E8),
          thickness: 1,
        )
      ],
    );
  }
}
