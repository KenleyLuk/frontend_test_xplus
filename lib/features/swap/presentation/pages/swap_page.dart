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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () => {},
        ),
        title: const Text('Swap', style: TextStyle(color: Color(0xFFDDE1E1)),),
        centerTitle: true,
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
    return SingleChildScrollView(
      padding: EdgeInsets.all(Responsive.getPadding(context)),
      child: Column(
        children: [
          const SwapCard(),
          const SizedBox(height: 24),
          const FeeSection(),
          const SizedBox(height: 16),
          const DisclaimerText(),
          const SizedBox(height: 24),
          const PreviewButton(),
        ],
      ),
    );
  }
}