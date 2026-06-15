import 'package:flutter/material.dart';
class CustombottomsheetNavigation extends StatefulWidget {
  final List<IconData?> bottomsheetIcons;
  final List<Widget> screens;
  final List<IconData?>? selectedIcons;
  final List<int>? badgeCounts;
  final List<bool>? disabledTabs;
  final bool keepScreenState;
  final bool animateIcons;
  final Duration animationDuration;
  final bool showIndicator;
  final Color? indicatorColor;
  final double indicatorHeight;
  final int defaultIndex;
  final List<String?>? iconNames;
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
  final ValueChanged<int>? onItemTap;
  final bool hapticFeedback;
  final TextStyle? selectedLabelStyle;
  final TextStyle? unselectedLabelStyle;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? margin;
  final double navigationBarHeight;

  const CustombottomsheetNavigation({
    super.key,
    required this.bottomsheetIcons,
    required this.screens,
    this.selectedIcons,
    this.badgeCounts,
    this.disabledTabs,
    this.keepScreenState = true,
    this.animateIcons = true,
    this.animationDuration = const Duration(milliseconds: 250),
    this.showIndicator = false,
    this.indicatorColor,
    this.indicatorHeight = 4,
    this.defaultIndex = 0,
    this.iconNames,
    this.backgroundColor,
    this.elevation,
    this.hapticFeedback = false,
    this.selectedIconColor,
    this.unselectedIconColor,
    this.selectedLabelColor,
    this.unselectedLabelColor,
    this.showSelectedLabel = true,
    this.showUnselectedLabel = true,
    this.selectedFontSize = 25,
    this.unselectedFontSize = 12,
    this.onItemTap,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.borderRadius,
    this.boxShadow,
    this.margin,
    this.navigationBarHeight = 70,
  })  : assert(
          bottomsheetIcons.length >= 2 && bottomsheetIcons.length <= 6,
          "Bottom navigation supports only 2 to 6 tabs.",
        ),
        assert(
          bottomsheetIcons.length == screens.length,
          "Icons length and screens length must be same.",
        ),
        assert(
          selectedIcons == null || selectedIcons.length == bottomsheetIcons.length,
          "Selected icons length must match icons length.",
        ),
        assert(
          badgeCounts == null || badgeCounts.length == bottomsheetIcons.length,
          "Badge counts length must match icons length.",
        ),
        assert(
          disabledTabs == null || disabledTabs.length == bottomsheetIcons.length,
          "Disabled tabs length must match icons length.",
        ),
        assert(
          iconNames == null || iconNames.length == bottomsheetIcons.length,
          "Labels length must match icons length.",
        ),
        assert(
          defaultIndex >= 0 && defaultIndex < bottomsheetIcons.length,
          "Default index must be within range.",
        );

  @override
  State<CustombottomsheetNavigation> createState() =>
      _CustombottomsheetNavigationState();
}

class _CustombottomsheetNavigationState extends State<CustombottomsheetNavigation> {
  late int selectedIndex;

  @override
  void initState() {
    selectedIndex = widget.defaultIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.keepScreenState
          ? IndexedStack(
              index: selectedIndex,
              children: widget.screens,
            )
          : widget.screens[selectedIndex],
      bottomNavigationBar: Container(
        height: widget.navigationBarHeight,
        margin: widget.margin,
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? Theme.of(context).canvasColor,
          borderRadius: widget.borderRadius,
          boxShadow: widget.boxShadow,
        ),
        child: ClipRRect(
          borderRadius: widget.borderRadius ?? BorderRadius.zero,
          child: BottomNavigationBar(
            enableFeedback: widget.hapticFeedback,
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            backgroundColor: Colors.transparent,
            elevation: widget.borderRadius != null ? 0 : widget.elevation,
            showSelectedLabels: widget.showSelectedLabel,
            showUnselectedLabels: widget.showUnselectedLabel,
            unselectedFontSize: widget.unselectedFontSize,
            selectedItemColor: widget.selectedLabelColor,
            unselectedItemColor: widget.unselectedLabelColor,
            selectedIconTheme: IconThemeData(
              color: widget.selectedIconColor,
              size: widget.selectedFontSize,
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
            unselectedLabelStyle: widget.unselectedLabelStyle ??
                TextStyle(
                  fontSize: widget.unselectedFontSize,
                  color: widget.unselectedLabelColor,
                ),
            onTap: (index) {
              if (widget.disabledTabs != null &&
                  index < widget.disabledTabs!.length &&
                  widget.disabledTabs![index]) {
                return;
              }
              setState(() {
                selectedIndex = index;
              });
              widget.onItemTap?.call(index);
            },
            items: List.generate(
              widget.bottomsheetIcons.length,
              (index) {
                final isSelected = selectedIndex == index;
                final isDisabled = widget.disabledTabs != null &&
                    index < widget.disabledTabs!.length &&
                    widget.disabledTabs![index];

                final iconData = (isSelected && widget.selectedIcons != null)
                    ? widget.selectedIcons![index] ??
                        widget.bottomsheetIcons[index]
                    : widget.bottomsheetIcons[index];

                return BottomNavigationBarItem(
                  icon: _buildIcon(index, iconData, isSelected, isDisabled),
                  label: widget.iconNames != null
                      ? widget.iconNames![index] ?? ""
                      : "",
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(
      int index, IconData? iconData, bool isSelected, bool isDisabled) {
    Widget icon = Icon(
      iconData ?? Icons.stop,
      color: isDisabled
          ? Colors.grey.withOpacity(0.5)
          : (isSelected
              ? (widget.selectedIconColor ?? Theme.of(context).primaryColor)
              : (widget.unselectedIconColor ?? Colors.grey)),
    );

    if (widget.animateIcons) {
      icon = AnimatedScale(
        scale: isSelected ? 1.2 : 1.0,
        duration: widget.animationDuration,
        child: icon,
      );
    }

    final badgeCount =
        widget.badgeCounts != null && index < widget.badgeCounts!.length
            ? widget.badgeCounts![index]
            : 0;

    if (badgeCount > 0) {
      icon = Badge(
        backgroundColor: Colors.red,
        label: Text(
          badgeCount > 99 ? '99+' : badgeCount.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: icon,
      );
    }

    if (widget.showIndicator) {
      icon = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: widget.animationDuration,
            height: widget.indicatorHeight,
            width: isSelected ? 24 : 0,
            decoration: BoxDecoration(
              color: isSelected
                  ? (widget.indicatorColor ??
                      widget.selectedIconColor ??
                      Theme.of(context).primaryColor)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(widget.indicatorHeight / 2),
            ),
          ),
          const SizedBox(height: 4),
          icon,
        ],
      );
    }

    return Padding(
      padding: EdgeInsets.only(
        top: widget.iconNames != null ? 4 : 0,
      ),
      child: icon,
    );
  }
}
