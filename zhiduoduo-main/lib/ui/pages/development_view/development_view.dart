import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zhi_duo_duo/ui/pages/base_view.dart';
import 'package:zhi_duo_duo/viewmodels/development_view_model/development_view_model.dart';

class DevelopmentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(
        builder: (context, model, child) {
          return Scaffold();
        },
        modelProvider: () => DevelopmentViewModel(),
    );
  }
}