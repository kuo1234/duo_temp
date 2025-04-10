import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zhi_duo_duo/ui/pages/base_view.dart';
import 'package:zhi_duo_duo/viewmodels/start_view_model.dart';

@RoutePage()
class StartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(
        builder: (context, model, child) {
          return Scaffold(
            body: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Spacer(),
                  // 按鈕 : 開始
                  Container(
                    // 按鈕寬度、高度
                    // width: 200,
                    height: 50,
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text('開始', style: TextStyle(fontSize: 18, fontWeight: null, color: null),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red, // 按鈕背景顏色
                          foregroundColor: Colors.white, // 按鈕文字顏色
                          shadowColor: Colors.blue, // 按鈕陰影顏色
                          // elevation: 10, // 按鈕陰影大小

                          // 貝塞爾曲線形狀按鈕
                          shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(28),),
                        ),
                        onPressed: () {
                          model.onStartPressed(context);
                        },
                      ),
                    )
                  ),
                  Container(
                    // 按鈕寬度、高度
                    // width: 200,
                    height: 50,
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text('審核', style: TextStyle(fontSize: 18, fontWeight: null, color: null),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red, // 按鈕背景顏色
                          foregroundColor: Colors.white, // 按鈕文字顏色
                          shadowColor: Colors.blue, // 按鈕陰影顏色
                          // elevation: 10, // 按鈕陰影大小
                          //邊緣距離
                          
                          // 貝塞爾曲線形狀按鈕
                          shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(28),),
                        ),
                        onPressed: () {
                          model.onreviewPressed(context);
                        },
                      ),
                    )
                  ),
                  // 按鈕 : 稍後加入會員
                  Container(
                    height: 50,
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        child: Text('稍後加入會員', style: TextStyle(fontSize: 18, fontWeight: null, color: null),),
                        style: TextButton.styleFrom(
                          // 貝塞爾曲線形狀按鈕
                          shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(28),),
                        ),
                        onPressed: () {
                          // 點擊事件
                        },
                      ),
                    )
                  )
                ],
              ),
            )
          );
        },
        modelProvider: () => StartViewModel(),
    );
  }

}