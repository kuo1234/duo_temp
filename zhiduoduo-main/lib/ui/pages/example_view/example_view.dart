import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zhi_duo_duo/core/services/log_service.dart';
import 'package:zhi_duo_duo/ui/pages/base_view.dart';
import 'package:zhi_duo_duo/viewmodels/example_view_model/exmple_view_model.dart';

@RoutePage()
class ExampleView extends StatelessWidget {
  const ExampleView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
        builder: (context, model, child) {
          // return widget
          LogService.d('value : ' + model.exampleVariable.toString());
          return Scaffold(
            backgroundColor: Colors.red,
            appBar: AppBar(title: Text('appbar'),),
            body: Center(
              child: Text("example view"),
            ),
          );
        }, 
        modelProvider: () => ExampleViewModel(),
    );
  }
}