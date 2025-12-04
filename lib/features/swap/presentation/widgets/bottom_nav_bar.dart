import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/colors.dart';


class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  
  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                iconPath: 'assets/home.svg',
                highlightedIconPath: 'assets/homeHighlighted.svg',
                label: 'Home',
                index: 0,
                isSelected: currentIndex == 0,
              ),
              _buildNavItem(
                iconPath: 'assets/promotions.svg',
                highlightedIconPath: 'assets/promotionsHighlighted.svg',
                label: 'Promotions',
                index: 1,
                isSelected: currentIndex == 1,
              ),
              _buildNavItem(
                iconPath: 'assets/support.svg',
                highlightedIconPath: 'assets/supportHighlighted.svg',
                label: 'Support',
                index: 2,
                isSelected: currentIndex == 2,
              ),
              _buildNavItem(
                iconPath: 'assets/assets.svg',
                highlightedIconPath: 'assets/assetsHighlighted.svg',
                label: 'Assets',
                index: 3,
                isSelected: currentIndex == 3,
              ),
              _buildNavItem(
                iconPath: 'assets/profile.svg',
                highlightedIconPath: 'assets/profileHighlighted.svg',
                label: 'Profile',
                index: 4,
                isSelected: currentIndex == 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildNavItem({
    required String iconPath,
    required String highlightedIconPath,
    required String label,
    required int index,
    required bool isSelected,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 選中時用綠色正方形包住 highlighted SVG
            if (isSelected)
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Color(0xFFBFFC59),
                  borderRadius: BorderRadius.circular(6), 
                ),
                child: Center(
                  child: SvgPicture.asset(
                    highlightedIconPath,
                    width: 24,
                    height: 24,
                    colorFilter: null,
                  ),
                ),
              )
            else
              SvgPicture.asset(
                iconPath,
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            // 選中隱藏文字, 只顯示綠色正方形 ＋ icon
            if (!isSelected) ...[
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Baijam',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}