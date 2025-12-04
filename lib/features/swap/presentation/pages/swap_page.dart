// features/swap/presentation/pages/swap_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/swap_cubit.dart';
import '../widgets/swap_card.dart';
import '../../../../core/utils/responsive.dart';
import '../widgets/fee_section.dart';
import '../widgets/disclaimer_text.dart';
import '../widgets/preview_button.dart';
import '../../domain/repositories/swap_repository.dart';
import '../widgets/bottom_nav_bar.dart';
import '../../data/datasources/assets_data_source.dart';

class SwapPage extends StatefulWidget {
  const SwapPage({Key? key}) : super(key: key);
  
  @override
  State<SwapPage> createState() => _SwapPageState();
}

class _SwapPageState extends State<SwapPage> {
  int _currentNavIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);
    
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: Responsive.isTablet(context) ? 32 : 20,
                ),
                const SizedBox(width: 4),
                Text(
                  'Back',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Responsive.isTablet(context) ? 24 : 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        leadingWidth: 120,
        title: const SizedBox.shrink(), // 移除 AppBar 中的 title
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) => SwapCubit(
          SwapRepositoryImpl(),
          AssetsDataSourceImpl(),
        ),
        child: const SwapPageContent(),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          setState(() {
            _currentNavIndex = index;
          });
        },
      ),
    );
  }
}

class SwapPageContent extends StatelessWidget {
  const SwapPageContent({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);
    
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.getHorizontalPadding(context),
        vertical: Responsive.getPadding(context),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: Responsive.getMaxContentWidth(context),
          ),
          child: Column(
            children: [
              // Swap title 在 SwapCard 上方
              Text(
                'Swap',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Responsive.getTitleFontSize(context),
                  fontFamily: 'Baijam',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: isTablet ? 32 : 24),
              const SwapCard(),
              SizedBox(height: isTablet ? 40 : 24),
              const FeeSection(),
              SizedBox(height: isTablet ? 32 : 16),
              const DisclaimerText(),
              SizedBox(height: isTablet ? 40 : 24),
              const PreviewButton(),
            ],
          ),
        ),
      ),
    );
  }
}