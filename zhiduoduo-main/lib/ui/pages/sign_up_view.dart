import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zhi_duo_duo/ui/pages/base_view.dart';
import 'package:zhi_duo_duo/viewmodels/sign_up_view_model.dart';

@RoutePage()
class SignUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(
        builder: (context, model, child) {
          return Scaffold(
            body: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Spacer(),
                  // 按鈕：信箱註冊
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: SizedBox(
                        width: double.infinity,
                        child: FloatingActionButton.extended(
                          icon: Icon(
                            Icons.email, // 設置 Icon
                            color: Colors.white, // 設置 Icon 顏色
                            // size: 20,
                          ),
                          label: Text('信箱註冊', style: TextStyle(fontSize: null, fontWeight: null, color: Colors.white),),
                          backgroundColor: Colors.blueGrey, // 按鈕背景顏色
                          onPressed: () {
                            // 點擊事件
                          },
                        ),
                      )
                  ),
                  // 按鈕：手機註冊
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: SizedBox(
                      width: double.infinity,
                      child: FloatingActionButton.extended(
                        icon: Icon(
                          Icons.phone, // 設置 Icon
                          color: Colors.white, // 設置 Icon 顏色
                          // size: 20,
                        ),
                        label: Text('手機註冊', style: TextStyle(fontSize: null, fontWeight: null, color: Colors.white),),
                        backgroundColor: Colors.blueGrey, // 按鈕背景顏色
                        onPressed: () {
                          // 點擊事件
                        },
                      ),
                    )
                  ),
                  // 文字：---或---
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Row(
                      children: [
                        Expanded(child: Divider()),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Text('或'),
                        ),
                        Expanded(child: Divider())
                      ],
                    ),
                  ),
                  // 按鈕 : 第三方登入按鈕
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 按鈕：Google 登入
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: IconButton(
                            icon: Image.asset('assets/images/google_icon.png', width: 40,), // 設置 Icon
                            tooltip: '長按不放會出現的文字',
                            style: IconButton.styleFrom(

                              // 圓角矩形按鈕, 設定圓角的半徑為20
                              // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),

                              // 圓形按鈕, 設定固定尺寸，以保證按鈕是圓形的
                              // shape: CircleBorder(), fixedSize: Size(70, 70),

                              // 貝塞爾曲線形狀按鈕
                              // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(28),),

                              // 帶邊框的按鈕
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(15), // 邊框圓滑程度
                              //   side: BorderSide(
                              //     color: Colors.blue, // 邊框顏色
                              //     width: 2, // 邊框寬度
                              //   ),
                              // ),
                            ),
                            onPressed: () {
                              // 點擊按鈕事件
                            },
                          ),
                        ),
                        // 按鈕：Facebook 登入
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: IconButton(
                            icon: Image.asset('assets/images/facebook_icon.png', width: 40,), // 設置 Icon
                            tooltip: '長按不放會出現的文字',
                            style: IconButton.styleFrom(

                              // 圓角矩形按鈕, 設定圓角的半徑為20
                              // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),

                              // 圓形按鈕, 設定固定尺寸，以保證按鈕是圓形的
                              // shape: CircleBorder(), fixedSize: Size(70, 70),

                              // 貝塞爾曲線形狀按鈕
                              // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(28),),

                              // 帶邊框的按鈕
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(15), // 邊框圓滑程度
                              //   side: BorderSide(
                              //     color: Colors.blue, // 邊框顏色
                              //     width: 2, // 邊框寬度
                              //   ),
                              // ),
                            ),
                            onPressed: () {
                              // 點擊按鈕事件
                            },
                          ),
                        ),
                        // 按鈕：LINE 登入
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: IconButton(
                            icon: Image.asset('assets/images/line_icon.png', width: 40,), // 設置 Icon
                            tooltip: '長按不放會出現的文字',
                            style: IconButton.styleFrom(

                              // 圓角矩形按鈕, 設定圓角的半徑為20
                              // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),

                              // 圓形按鈕, 設定固定尺寸，以保證按鈕是圓形的
                              // shape: CircleBorder(), fixedSize: Size(70, 70),

                              // 貝塞爾曲線形狀按鈕
                              // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(28),),

                              // 帶邊框的按鈕
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(15), // 邊框圓滑程度
                              //   side: BorderSide(
                              //     color: Colors.blue, // 邊框顏色
                              //     width: 2, // 邊框寬度
                              //   ),
                              // ),
                            ),
                            onPressed: () {
                              // 點擊按鈕事件
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  // 按鈕：登入
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('已經註冊？'),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: TextButton(
                            child: Text('登入', style: TextStyle(fontSize: null, fontWeight: null, color: null),),
                            style: TextButton.styleFrom(
                              // 貝塞爾曲線形狀按鈕
                              shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(28),),
                            ),
                            onPressed: () {
                              // 點擊事件
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
        modelProvider: () => SignUpViewModel(),
    );
  }

}