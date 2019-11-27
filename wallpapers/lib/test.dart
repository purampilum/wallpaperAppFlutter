import 'package:flutter/material.dart';
import 'package:rubber/rubber.dart';

class SpringPage extends StatefulWidget {
  SpringPage({Key key}) : super(key: key);

  @override
  _SpringPageState createState() => _SpringPageState();
}

class _SpringPageState extends State<SpringPage> with SingleTickerProviderStateMixin {

  RubberAnimationController _controller;
  double _dampingValue = DampingRatio.LOW_BOUNCY;
  double _stiffnessValue = Stiffness.VERY_LOW;

  @override
  void initState()
  {
    _controller = RubberAnimationController(
        vsync: this,
        lowerBoundValue: AnimationControllerValue(pixel: 100),
        upperBoundValue: AnimationControllerValue(percentage: 0.9),
        springDescription: SpringDescription.withDampingRatio(
            mass: 1,
            stiffness: _stiffnessValue,
            ratio: _dampingValue
        ),
        duration: Duration(milliseconds: 300)
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: <Widget>[
          Expanded(
            child: RubberBottomSheet(
              lowerLayer: _getLowerLayer(),
              upperLayer: _getUpperLayer(),
              animationController: _controller,
            ),
          ),
        ],
      ),
    );
  }


  Widget _getLowerLayer() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.cyan[100]
      ),
    );
  }
  Widget _getUpperLayer() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.cyan
      ),
    );
  }

}