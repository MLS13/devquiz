import 'package:devquiz/core/core.dart';
import 'package:flutter/material.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  ProgressIndicatorWidget({@required this.value});
  final double value;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value,
      backgroundColor: AppColors.chartSecondary,
      valueColor: AlwaysStoppedAnimation<Color>(AppColors.chartPrimary),
    );
  }
}
