import 'package:flutter/material.dart';
import 'package:staarm_mobile/core/models/protection_plan.dart';
import 'package:staarm_mobile/styles/colors.dart';
import 'package:staarm_mobile/utils/staarm_formatter.dart';

class ProtectionPlanItem extends StatelessWidget {
  final ProtectionPlanModel plan;
  final bool selected;
  final Function(ProtectionPlanModel) onSelect;
  const ProtectionPlanItem({
    Key key,
    @required this.plan,
    this.selected = false, @required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelect(plan),
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? Color(0xFF824DFF) : Color(0xFFE1E3E6),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  plan?.name ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),

                Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selected ? AppColors.mainPurple : Colors.white,
                    border: Border.all(
                      color: selected ? AppColors.mainPurple : Color(0xFF757D8A),
                      width: 1,
                    )
                  ),

                  child: !selected ? SizedBox(height: 16, width: 16) : Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(right: 38.0),
              child: Text(
                plan?.summary ?? '',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey5,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text.rich(TextSpan(
                text: StaarmFormatter.formatCurrencyInput(plan?.price?.toString() ?? '0'),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: ' / day',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey5,
                    ),
                  ),
                ]))
          ],
        ),
      ),
    );
  }
}
