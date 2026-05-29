import 'dart:ffi';

import 'package:flutter/material.dart';

class CustombottomsheetNavigation extends StatefulWidget {
  final int defaultIndex;
  final int bottomsheetlength;
  final List<IconData?> bottomsheetIcons;
  final List<String?>? iconNames;
  final Color? backgroundColor;
  final double? elevation;
  final Color? selectedIconColor;

  const CustombottomsheetNavigation({super.key, this.defaultIndex = 0,
    required this.bottomsheetlength,
    required this.bottomsheetIcons,
    this.iconNames,
    this.backgroundColor,
    this.elevation,
    this.selectedIconColor,
  });

  @override
  State<CustombottomsheetNavigation> createState() => _CustombottomsheetNavigationState();
}

class _CustombottomsheetNavigationState extends State<CustombottomsheetNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: widget.backgroundColor,
      elevation: widget.elevation,
      currentIndex: widget.defaultIndex,
      selectedIconTheme: IconThemeData(color: widget.selectedIconColor),
      items: List.generate(widget.bottomsheetlength, (index) {
        return BottomNavigationBarItem(icon: Icon(widget.bottomsheetIcons[index] ?? Icons.stop), label: widget.iconNames?[index] ?? "");
      },),
      type: BottomNavigationBarType.fixed
    );
  }
}
