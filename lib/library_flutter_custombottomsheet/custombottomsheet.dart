import 'package:flutter/material.dart';

class CustombottomsheetNavigation extends StatelessWidget {
  final int defaultIndex;
  final int bottomsheetlength;
  final List<IconData> bottomsheetIcons;

  const CustombottomsheetNavigation({super.key, this.defaultIndex = 0,
    required this.bottomsheetlength,
    required this.bottomsheetIcons,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: defaultIndex,
      items: List.generate(bottomsheetlength, (index) {
        return BottomNavigationBarItem(icon: Icon(bottomsheetIcons[index]), label: '');
      },),
      type: BottomNavigationBarType.fixed,
    );
  }
}
