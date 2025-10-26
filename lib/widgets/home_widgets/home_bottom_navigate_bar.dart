import 'package:flutter/material.dart';
import 'package:ui_challenge_02/constant/my_color.dart';

class HomeBottomNavigateBar extends StatefulWidget {
  const HomeBottomNavigateBar({super.key});
  @override
  State<HomeBottomNavigateBar> createState() => _HomeBottomNavigateBarState();
}

class _HomeBottomNavigateBarState extends State<HomeBottomNavigateBar>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
         boxShadow: [
        //  BoxShadow(
        //     color: MyColor.primaryColor.withOpacity(0.15),
          //   blurRadius: 30,
          //   offset: const Offset(0, 8),
          //   spreadRadius: 0,
          // ),
          // BoxShadow(
          //   color: Colors.black.withOpacity(0.05),
          //   blurRadius: 15,
          //   offset: const Offset(0, 4),
          // ),
        ],
        border: Border.all(
          color: MyColor.primaryColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home_rounded, 0),
            _buildNavItem(Icons.search_rounded, 1),
            _buildCenterButton(),
            _buildNavItem(Icons.notifications_rounded, 3),
            _buildNavItem(Icons.people_rounded, 4),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color:
              isSelected ? MyColor.primaryColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Glow effect for selected item
            if (isSelected)
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: MyColor.primaryColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: MyColor.primaryColor.withOpacity(0.3),
                      blurRadius: 12,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            // Icon
            AnimatedScale(
              scale: isSelected ? 1.15 : 1.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Icon(
                icon,
                size: 26,
                color: isSelected ? MyColor.primaryColor : Colors.grey,
              ),
            ),
            // Active indicator dot
            if (isSelected)
              Positioned(
                bottom: -8,
                child: Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: MyColor.primaryColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: MyColor.primaryColor.withOpacity(0.6),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterButton() {
    final isSelected = _selectedIndex == 2;
    return GestureDetector(
      onTap: () => _onItemTapped(2),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: isSelected ? _scaleAnimation.value : 1.0,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isSelected
                      ? [MyColor.primaryColor, MyColor.primaryColor.withBlue(220)]
                      : [
                          MyColor.primaryColor.withOpacity(0.9),
                          MyColor.primaryColor.withBlue(220).withOpacity(0.9)
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: MyColor.primaryColor.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: const Offset(0, 6),
                  ),
                  BoxShadow(
                    color: MyColor.primaryColor.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 0,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(
                Icons.add_rounded,
                size: 32,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
