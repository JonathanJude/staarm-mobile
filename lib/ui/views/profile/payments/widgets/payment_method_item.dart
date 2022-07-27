import 'package:flutter/material.dart';
import 'package:staarm_mobile/core/models/card.dart';
import 'package:staarm_mobile/styles/colors.dart';
import 'package:staarm_mobile/widgets/dialogs/delete_dialog.dart';

class PaymentMethodItem extends StatelessWidget {
  final CardModel card;
  final Function onTap;
  final Function(CardModel) onDelete;
  final Function(CardModel) onSelect;
  const PaymentMethodItem({
    Key key,
    this.card,
    this.onTap,
    this.onDelete, this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: onTap,
      onTap: onSelect == null ? null : (){
        onSelect(card);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 0,
            ),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Image.asset(
                'assets/icons/mastercard_icon.png',
                height: 19,
                width: 22,
              ),
              title: Text(
                "${card.cardType.toUpperCase()} ${card.last4}",
                style: TextStyle(
                  color: Color(0xFF231F20),
                  fontSize: 13,
                ),
              ),
              trailing: GestureDetector(
                onTap: () {
                  DeleteBottomSheet.show(
                    context: context,
                    title: 'Remove payment method',
                    text:
                        'Are you sure you want to delete this payment method?',
                    onTap: () {
                      onDelete(card);
                    },
                  );
                },
                child: Icon(
                  Icons.delete_forever_outlined,
                  color: AppColors.grey5,
                  size: 20,
                ),
              ),
            ),
          ),
          Divider(
            height: 0,
            thickness: 1.2,
            color: Color(0xFFF1F2F3),
          ),
        ],
      ),
    );
  }
}
