import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/token.dart';
import '../../domain/repositories/swap_repository.dart';
import '../../../../core/utils/validators.dart';
import 'swap_state.dart';
import '../../data/datasources/assets_data_source.dart';

class SwapCubit extends Cubit<SwapState> {
  final SwapRepository _swapRepository;
  final AssetsDataSource _assetsDataSource;
  
    SwapCubit(this._swapRepository, this._assetsDataSource) : super(const SwapState()) {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      final tokens = await _assetsDataSource.getTokens();
      
      // 找到 WBTC 和 USD
      final wbtc = tokens.firstWhere((token) => token.symbol == 'WBTC');
      final usd = tokens.firstWhere((token) => token.symbol == 'USD');
      
      // 設置默認值
      final newState = state.copyWith(
        fromToken: wbtc,
        toToken: usd,
      );
      emit(newState);
      
      // 計算匯率
      _calculateExchangeRate(wbtc, usd);
    } catch (e) {
      print('Failed to initialize: $e');
    }
  }
  
  void selectFromToken(Token token) {
    final newState = state.copyWith(fromToken: token);
    emit(newState);
    
    if (newState.toToken != null) {
      _calculateExchangeRate(newState.fromToken!, newState.toToken!);
    }
    
    if (state.fromAmount.isNotEmpty) {
      _calculateToAmount(state.fromAmount);
    }
    
    _validate();
  }
  
  void selectToToken(Token token) {
    final newState = state.copyWith(toToken: token);
    emit(newState);
    
    if (newState.fromToken != null) {
      _calculateExchangeRate(newState.fromToken!, newState.toToken!);
    }
    
    if (state.fromAmount.isNotEmpty) {
      _calculateToAmount(state.fromAmount);
    }
    
    _validate();
  }
  
  void updateFromAmount(String amount) {
    if (amount.isNotEmpty && !SwapValidator.isValidNumber(amount)) {
      return;
    }
    
    emit(state.copyWith(
      fromAmount: amount,
      clearError: true,
    ));
    
    if (amount.isNotEmpty && state.fromToken != null && state.toToken != null) {
      _calculateToAmount(amount);
    } else {
      emit(state.copyWith(toAmount: ''));
    }
    
    _validate();
  }
  
  void switchTokens() {
    if (state.fromToken == null || state.toToken == null) {
      return;
    }
    
    final tempToken = state.fromToken;
    final tempAmount = state.fromAmount;
    
    emit(state.copyWith(
      fromToken: state.toToken,
      toToken: tempToken,
      fromAmount: state.toAmount,
      toAmount: tempAmount,
    ));
    
    _calculateExchangeRate(state.fromToken!, state.toToken!);
    _validate();
  }
  
  void setMaxAmount() {
    if (state.fromToken == null) {
      return;
    }
    
    final balance = state.fromToken!.balance;
    final maxAmount = balance.toStringAsFixed(8).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
    
    updateFromAmount(maxAmount);
  }
  
  void _calculateExchangeRate(Token fromToken, Token toToken) {
    try {
      final rate = _swapRepository.calculateExchangeRate(fromToken, toToken);
      emit(state.copyWith(exchangeRate: rate));
    } catch (e) {
      emit(state.copyWith(
        exchangeRate: 0.0,
        errorMessage: 'Failed to calculate exchange rate',
      ));
    }
  }
  
  void _calculateToAmount(String fromAmount) {
    if (state.fromToken == null || state.toToken == null) {
      return;
    }
    
    try {
      final amount = double.tryParse(fromAmount);
      if (amount == null || amount <= 0) {
        emit(state.copyWith(toAmount: ''));
        return;
      }
      
      final toAmount = _swapRepository.calculateToAmount(
        fromAmount,
        state.exchangeRate,
      );
      
      final formatted = _formatAmount(toAmount, state.toToken!.decimals);
      emit(state.copyWith(toAmount: formatted));
    } catch (e) {
      emit(state.copyWith(
        toAmount: '',
        errorMessage: 'Failed to calculate amount',
      ));
    }
  }
  
  void _validate() {
    if (state.fromToken == null || state.toToken == null) {
      emit(state.copyWith(isValid: false));
      return;
    }
    
    if (state.fromAmount.isEmpty) {
      emit(state.copyWith(isValid: false));
      return;
    }
    
    final validation = SwapValidator.validateSwap(
      amount: state.fromAmount,
      balance: state.fromToken!.balance,
      fromToken: state.fromToken!,
      toToken: state.toToken!,
    );
    
    emit(state.copyWith(
      isValid: validation.isValid,
      errorMessage: validation.errorMessage,
    ));
  }
  
  String _formatAmount(double amount, int decimals) {
    if (amount >= 1000) {
      return amount.toStringAsFixed(2);
    } else if (amount >= 1) {
      return amount.toStringAsFixed(4);
    } else {
      return amount.toStringAsFixed(decimals.clamp(4, 8));
    }
  }
}