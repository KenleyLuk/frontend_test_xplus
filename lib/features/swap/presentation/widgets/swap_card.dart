import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart' as responsive;
import 'token_input_section.dart';
import '../../data/datasources/assets_data_source.dart';
import '../../domain/entities/token.dart';
import 'token_selector_modal.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/cubit/swap_cubit.dart';
import '../../presentation/cubit/swap_state.dart';

class SwapCard extends StatelessWidget {
  const SwapCard({Key? key}) : super(key: key);

  void _showTokenSelector(
    BuildContext context, {
    required bool isFromToken,
    Token? currentToken,
  }) async {
    final cubit = context.read<SwapCubit>();
    final state = cubit.state;

    final dataSource = AssetsDataSourceImpl();
    final tokens = await dataSource.getTokens();


    final availableTokens = tokens.where((token) {
      // Filter 走 current token
      if (token.symbol == currentToken?.symbol) {
        return false;
      }
      
      // 禁止 From Token 同 To Token 同一個
      if (isFromToken && state.toToken != null) {
        if (token.symbol == state.toToken!.symbol) {
          return false;
        }
      }
      
      if (!isFromToken && state.fromToken != null) {
        if (token.symbol == state.fromToken!.symbol) {
          return false;
        }
      }
      
      return true;
    }).toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      constraints: responsive.Responsive.isTablet(context)
          ? BoxConstraints(
              maxWidth: double.infinity,
              maxHeight: MediaQuery.of(context).size.height * 0.9,
            )
          : null,
      builder:
          (modalContext) => TokenSelectorModal(
            tokens: availableTokens,
            onTokenSelected: (token) {
              if (isFromToken) {
                cubit.selectFromToken(token);
              } else {
                cubit.selectToToken(token);
              }
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwapCubit, SwapState>(
      builder: (context, state) {
        final isTablet = responsive.Responsive.isTablet(context);
        
        return Card(
          color: const Color(0xFF0F1011),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isTablet ? 24 : 16),
            side: const BorderSide(color: Color(0xFF616363), width: 1),
          ),
          child: Padding(
            padding: EdgeInsets.all(responsive.Responsive.getCardPadding(context)),
            child: Column(
              children: [
                TokenInputSection(
                  label: 'From',
                  tokenSymbol: state.fromToken?.symbol,
                  balance: state.fromToken?.balance ?? 0.0,
                  amount: state.fromAmount,
                  showMaxButton: state.fromToken != null,
                  editable: true,
                  onTokenTap: () {
                    _showTokenSelector(
                      context,
                      isFromToken: true,
                      currentToken: state.fromToken,
                    );
                  },
                  onAmountChanged: (value) {
                    context.read<SwapCubit>().updateFromAmount(value);
                  },
                  onMaxPressed: () {
                    context.read<SwapCubit>().setMaxAmount();
                  },
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(height: 1, color: Color(0xFF2F3031)),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<SwapCubit>().switchTokens();
                        },
                        child: Container(
                          width: Responsive.isTablet(context) ? 48 : 32,
                          height: Responsive.isTablet(context) ? 48 : 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(0xFF6F7174),
                              width: 1,
                            ),
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Transform.rotate(
                              angle: 1.5708, // 90 度 = π/2 弧度
                              child: SvgPicture.asset(
                                'assets/switch.svg',
                                width: Responsive.isTablet(context) ? 24 : 16,
                                height: Responsive.isTablet(context) ? 24 : 16,
                                fit: BoxFit.contain,
                                colorFilter: const ColorFilter.mode(
                                  Color(0xFFDDE1E1),
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(height: 1, color: Color(0xFF2F3031)),
                      ),
                    ],
                  ),
                ),

                TokenInputSection(
                  label: 'To',
                  tokenSymbol: state.toToken?.symbol,
                  balance: state.toToken?.balance ?? 0.0,
                  amount: state.toAmount,
                  exchangeRate: state.exchangeRateText,
                  editable: false,
                  onTokenTap: () {
                    _showTokenSelector(
                      context,
                      isFromToken: false,
                      currentToken: state.toToken,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
