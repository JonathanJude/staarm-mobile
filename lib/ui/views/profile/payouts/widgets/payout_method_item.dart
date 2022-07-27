import 'package:flutter/material.dart';
import 'package:staarm_mobile/core/models/user_bank.dart';
import 'package:staarm_mobile/styles/colors.dart';
import 'package:staarm_mobile/widgets/dialogs/delete_dialog.dart';

class PayoutMethodItem extends StatelessWidget {
  final UserBankModel bank;
  final Function onTap;
  final Function(UserBankModel) onDelete;
  const PayoutMethodItem({
    Key key,
    this.bank,
    this.onTap, @required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 0,
            ),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              isThreeLine: true,
              title: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                child: Text(
                  bank.bankName ?? '',
                  style: TextStyle(
                    color: Color(0xFF231F20),
                    fontSize: 14,
                  ),
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: Text(
                      bank.accountNumber ?? '',
                      style: TextStyle(
                        color: Color(0xFF231F20),
                        fontSize: 14,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: Text(
                      bank.accountName.toUpperCase() ?? '',
                      style: TextStyle(
                        color: Color(0xFF231F20),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              trailing: GestureDetector(
                onTap: (){
                  DeleteBottomSheet.show(
                    context: context,
                    title: 'Remove payout method',
                    text:
                        'Are you sure you want to delete this payout method?',
                    onTap: () {
                      onDelete(bank);
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
