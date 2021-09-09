import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class WindowsTopBar extends StatelessWidget {
  const WindowsTopBar({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return WindowBorder(
      color: Colors.white,
      width: 0,
      child: Stack(
        children: [
          child,
          SizedBox(
            height: 32,
            child: RightSide(),
          ),
        ],
      ),
    );
  }
}

class RightSide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
        child: Row(children: [Expanded(child: MoveWindow()), WindowButtons()]));
  }
}

final buttonColors = WindowButtonColors(
    iconNormal: Color(0xFF805306),
    mouseOver: Color(0xFFF6A00C),
    mouseDown: Color(0xFF805306),
    iconMouseOver: Color(0xFF805306),
    iconMouseDown: Color(0xFFFFD500));

final closeButtonColors = WindowButtonColors(
    mouseOver: Color(0xFFD32F2F),
    mouseDown: Color(0xFFB71C1C),
    iconNormal: Color(0xFF805306),
    iconMouseOver: Colors.white);

class WindowButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(),
        //MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(),
      ],
    );
  }
}
