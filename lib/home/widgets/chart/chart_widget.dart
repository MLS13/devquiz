import 'package:devquiz/core/core.dart';
import 'package:flutter/material.dart';

class CharWidget extends StatefulWidget {
  final double percent;

  const CharWidget({
    Key key,
    @required this.percent,
  }) : super(key: key);
  @override
  _CharWidgetState createState() => _CharWidgetState();
}

class _CharWidgetState extends State<CharWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    initAnimation();
  }

  void initAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation =
        Tween<double>(begin: 0, end: widget.percent).animate(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, _) => Stack(
          children: [
            Center(
              child: Container(
                height: 80,
                width: 80,
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                  value: _animation.value,
                  backgroundColor: AppColors.chartSecondary,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.chartPrimary,
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                "${(_animation.value * 100).toInt()}%",
                style: AppTextStyles.heading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
