import 'package:flutter/material.dart';

class DeleteBottomSheet {
  DeleteBottomSheet._();

  static Future<T> show<T>({
    @required BuildContext context,
    @required String title,
    @required String text,
    @required Function onTap,
    String yesTitle,
    String noTitle,
    isLoading = false,
  }) {
    final size = MediaQuery.of(context).size;

    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        backgroundColor: Colors.white,
        builder: (BuildContext bc) {
          return Container(
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Container(
                      height: 5,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFFDDDDDD),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                      ),
                      child: Text(title ?? 'Remove payment method',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    Divider(
                      color: Color(0xFFE1E3E6),
                      thickness: 1.4,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 26,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                            ),
                            child: Text(
                              text ??
                                  'Are you sure you want to delete this Transaction?',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),

                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                              onTap();
                            },
                            child: Container(
                              width: size.width,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 20,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(.12),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text( yesTitle ?? 'Delete',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),


                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              width: size.width,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 20,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(noTitle ?? 'Cancel',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: size.height * .05),
                  ],
                )),
          );
        });
  }
}
