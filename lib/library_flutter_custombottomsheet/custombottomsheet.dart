import 'package:flutter/material.dart';

class CustombottomsheetNavigation extends StatelessWidget {
  final int defaultIndex;
  final int bottomsheetlength;
  final List<IconData> bottomsheetIcons;
  final List<String>? iconNames;

  const CustombottomsheetNavigation({super.key, this.defaultIndex = 0,
    required this.bottomsheetlength,
    required this.bottomsheetIcons,
    this.iconNames
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: defaultIndex,
      items: List.generate(bottomsheetlength, (index) {
        return BottomNavigationBarItem(icon: Icon(bottomsheetIcons[index] ?? Icons.stop), label: iconNames![index] ?? '');
      },),
      type: BottomNavigationBarType.fixed,
    );
  }
}
