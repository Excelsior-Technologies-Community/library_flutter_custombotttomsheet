import 'package:flutter/material.dart';

class CustombottomsheetNavigation extends StatefulWidget {
  final int defaultIndex;
  final List<IconData?> bottomsheetIcons;
  final List<String?>? iconNames;
  final List<Widget> screens;
  final Color? backgroundColor;
  final double? elevation;
  final Color? selectedIconColor;
  final Color? unselectedIconColor;
  final Color? selectedLabelColor;
  final Color? unselectedLabelColor;
  final bool showSelectedLabel;
  final bool showUnselectedLabel;
  final double selectedFontSize;
  final double unselectedFontSize;
  final Function(int index)? onItemTap;
  final bool hapticFeedback;

  final TextStyle? selectedLabelStyle;
  final TextStyle? unselectedLabelStyle;

  const CustombottomsheetNavigation({
    super.key,
    this.defaultIndex = 0,
    required this.bottomsheetIcons,
    required this.screens,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.iconNames,
    this.backgroundColor,
    this.elevation,
    this.hapticFeedback=false,
    this.selectedIconColor,
    this.unselectedIconColor,
    this.selectedLabelColor,
    this.unselectedLabelColor,
    this.showSelectedLabel = true,
    this.showUnselectedLabel = true,
    this.selectedFontSize = 14,
    this.unselectedFontSize = 12,
    this.onItemTap,
  }) : assert(
  bottomsheetIcons.length >= 2 &&
      bottomsheetIcons.length <= 6,
  "Bottom navigation supports only 2 to 6 tabs.",
  ),assert(bottomsheetIcons.length == screens.length,
  "Icons length and screens length must be same.",
  ),
        assert(
        iconNames == null || iconNames.length == bottomsheetIcons.length,
        "Labels length must match icons length.",
        );

  @override
  State<CustombottomsheetNavigation> createState() =>
      _CustombottomsheetNavigationState();
}

class _CustombottomsheetNavigationState
    extends State<CustombottomsheetNavigation> {
  late int selectedIndex;

  @override
  void initState() {
    selectedIndex = widget.defaultIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: widget.hapticFeedback,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        backgroundColor: widget.backgroundColor,
        elevation: widget.elevation,
        showSelectedLabels: widget.showSelectedLabel,
        showUnselectedLabels: widget.showUnselectedLabel,
        unselectedFontSize: widget.unselectedFontSize,
        selectedItemColor: widget.selectedLabelColor,
        unselectedItemColor: widget.unselectedLabelColor,
        selectedIconTheme: IconThemeData(
          color: widget.selectedIconColor,
          size: widget.selectedFontSize
        ),

        unselectedIconTheme: IconThemeData(
          color: widget.unselectedIconColor,
        ),

        selectedLabelStyle: widget.selectedLabelStyle ??
            TextStyle(
              fontSize: widget.selectedFontSize,
              fontWeight: FontWeight.w600,
              color: widget.selectedLabelColor,
            ),

        unselectedLabelStyle:
        widget.unselectedLabelStyle ??
            TextStyle(
              fontSize: widget.unselectedFontSize,
              color: widget.unselectedLabelColor,
            ),

        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
          widget.onItemTap?.call(value);
        },

        items: List.generate(
          widget.bottomsheetIcons.length,
              (index) {
            return BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(
                  top: widget.iconNames != null ? 4 : 0,
                ),
                child: Icon(
                  widget.bottomsheetIcons[index] ?? Icons.stop,
                ),
              ),

              label: widget.iconNames != null
                  ? widget.iconNames![index] ?? ""
                  : "",
            );
          },
        ),
      ),
    );
  }
}