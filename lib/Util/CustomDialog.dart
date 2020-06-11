import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDialog extends StatelessWidget {
  String txt;
  Function pCallBack;
  Function calCallBack;

  CustomDialog({this.txt, this.pCallBack, this.calCallBack});

  @override
  Widget build(BuildContext context) {
    var _dialogWidth = MediaQuery.of(context).size.width * 0.65;

    Container center = Container(
      padding: EdgeInsets.fromLTRB(10,20,10,20),
      alignment: Alignment.center,
      child: Text(
        "$txt",
        style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.normal),
      ),
    );

    return Dialog(
      elevation: 1,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Container(
        width: _dialogWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            center,
            Divider(height: 1, color: Colors.grey),
            Container(
              height: 40,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        pCallBack();
                      },
                      child: Container(
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: Text(
                          "确认",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  ),
                  calCallBack == null
                      ? SizedBox()
                      : SizedBox(
                          width: 1,
                          height: double.infinity,
                          child: DecoratedBox(
                            decoration: BoxDecoration(color: Colors.grey),
                          ),
                        ),
                  calCallBack == null
                      ? SizedBox()
                      : Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                              calCallBack();
                            },
                            child: Container(
                              color: Colors.transparent,
                              alignment: Alignment.center,
                              child: Text(
                                "取消",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
