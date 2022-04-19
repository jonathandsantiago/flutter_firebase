import 'dart:ui';

import 'package:flutter_firebase/src/ui/financeiro/financeiro_detalhes.dart';
import 'package:flutter_firebase/src/ui/home/home_actions.dart';
import 'package:flutter_firebase/src/ui/home/home_perfil.dart';
import 'package:flutter/material.dart';

const double minTop = 110;
const double maxQuickActionsMargin = 50;
const double minQuickActionsMargin = -170;

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool _hideOptions = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _controller.value += (details.primaryDelta ?? 0) / minTop;

    if (_controller.value > .5) {
      _hideOptions = false;
    } else {
      _hideOptions = true;
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) return;

    if (_controller.value > 0.5) {
      _controller.fling(velocity: 2);
    } else {
      _controller.fling(velocity: -2);
    }
  }

  double? lerp(double min, double max) =>
      lerpDouble(min, max, _controller.value);

  @override
  Widget build(BuildContext context) {
    double maxTop = MediaQuery.of(context).size.height * .9;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: <Widget>[
            Positioned(
              height: MediaQuery.of(context).size.height * .60,
              left: 0,
              right: 0,
              top: minTop,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: _hideOptions == false
                    ? Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: HomePerfil())
                    : Container(),
              ),
            ),
            Positioned(
              height: MediaQuery.of(context).size.height * .45,
              left: 0,
              right: 0,
              top: lerp(minTop, maxTop),
              child: GestureDetector(
                onVerticalDragUpdate: _handleDragUpdate,
                onVerticalDragEnd: _handleDragEnd,
                child: FinanceiroDetalhes(),
              ),
            ),
            Positioned(
              height: 130,
              left: 0,
              right: 0,
              bottom: lerp(maxQuickActionsMargin, minQuickActionsMargin),
              child: const HomeActions(),
            )
          ],
        );
      },
    );
  }
}
