import 'package:flutter/material.dart';

import '../../../../styles/colors.dart';
import '../../../../styles/textstyles.dart';

class SearchResultTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color color;
  final Function onTap;
  final bool isDense;

  const SearchResultTile({
    Key key,
    @required this.title,
    this.subtitle,
    this.icon,
    this.iconColor,
    this.color,
    this.onTap,
    this.isDense = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: isDense ? 40 : 50,
        padding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: color ?? Color(0xFF757D8A).withOpacity(.08),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon ?? Icons.location_on_outlined,
          color: iconColor ?? AppColors.grey5,
          size: isDense ? 20 : 29,
        ),
      ),
      title: Text(
        title ?? '',
        style: AppTextStyles.input
            .copyWith(color: Color(0xFF231F20), fontSize: 14),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle ?? '',
              style: AppTextStyles.label
                  .copyWith(color: Color(0xFFB0B0B0), fontSize: 12),
            )
          : null,
    );
  }
}
