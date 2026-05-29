import 'package:flutter/material.dart';

class CustombottomsheetNavigation extends StatefulWidget {
  final int defaultIndex;
  final int bottomsheetlength;
  final List<IconData?> bottomsheetIcons;
  final List<String?>? iconNames;
  final Color? backgroundColor;
  final double? elevation;
  final Color? selectedIconColor;
  final Color? unselectedIconColor;
  final bool showSelectedLabel;
  final bool showUnselectedLabel;
  final double selectedFontSize;
  final double unselectedFontSize;
  final Color? selectedLabelColor;
  final Color? unselectedLabelColor;
  final String? fontFamily;
  final Function(int index)? onItemTap;

  const CustombottomsheetNavigation({
    super.key,
    this.defaultIndex = 0,
    required this.bottomsheetlength,
    required this.bottomsheetIcons,
    this.iconNames,
    this.backgroundColor,
    this.elevation,
    this.selectedIconColor,
    this.unselectedIconColor,
    this.showSelectedLabel = true,
    this.showUnselectedLabel = true,
    this.selectedFontSize = 15,
    this.unselectedFontSize = 13,
    this.selectedLabelColor,
    this.unselectedLabelColor,
    this.fontFamily,
    this.onItemTap,
  });

  @override
  State<CustombottomsheetNavigation> createState() =>
      _CustombottomsheetNavigationState();
}

class _CustombottomsheetNavigationState
    extends State<CustombottomsheetNavigation> {
  int selectedIndex = 0;

  @override
  void initState() {
    selectedIndex = widget.defaultIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      backgroundColor: widget.backgroundColor,
      elevation: widget.elevation,
      showSelectedLabels: widget.showSelectedLabel,
      showUnselectedLabels: widget.showUnselectedLabel,
      selectedFontSize: widget.selectedFontSize,
      unselectedFontSize: widget.unselectedFontSize,
      selectedItemColor: widget.selectedLabelColor,
      unselectedItemColor: widget.unselectedLabelColor,

      selectedIconTheme: IconThemeData(
        color: widget.selectedIconColor,
      ),

      unselectedIconTheme: IconThemeData(
        color: widget.unselectedIconColor,
      ),

      selectedLabelStyle: TextStyle(
        fontFamily: widget.fontFamily,
        fontSize: widget.selectedFontSize,
        color: widget.selectedLabelColor,
        fontWeight: FontWeight.w600,
      ),

      unselectedLabelStyle: TextStyle(
        fontFamily: widget.fontFamily,
        fontSize: widget.unselectedFontSize,
        color: widget.unselectedLabelColor,
      ),

      onTap: (value) {
        setState(() {
          selectedIndex = value;
        });
      },

      items: List.generate(
        widget.bottomsheetlength,
            (index) {
          return BottomNavigationBarItem(
            icon: Icon(
              widget.bottomsheetIcons[index] ?? Icons.stop,
            ),
            label: widget.iconNames?[index] ?? "",
          );
        },
      ),
    );
  }
}