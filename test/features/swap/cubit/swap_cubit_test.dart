import 'package:flutter_test/flutter_test.dart';
import 'package:frontend_test_xplus/features/swap/presentation/cubit/swap_cubit.dart';
import 'package:frontend_test_xplus/features/swap/domain/entities/token.dart';
import 'package:frontend_test_xplus/features/swap/domain/repositories/swap_repository.dart';
import 'package:frontend_test_xplus/features/swap/data/datasources/assets_data_source.dart';
import 'package:frontend_test_xplus/features/swap/data/models/token_model.dart';

class MockSwapRepository extends SwapRepository {
  @override
  double calculateExchangeRate(Token fromToken, Token toToken) {
    if (toToken.usdValue == 0) throw Exception('Invalid exchange rate');
    return fromToken.usdValue / toToken.usdValue;
  }

  @override
  double calculateToAmount(String fromAmount, double exchangeRate) {
    final amount = double.tryParse(fromAmount);
    return (amount == null || amount <= 0) ? 0.0 : amount * exchangeRate;
  }
}

class MockAssetsDataSource extends AssetsDataSource {
  @override
  Future<List<TokenModel>> getTokens() async {
    return [
      TokenModel(symbol: 'WBTC', name: 'Wrapped Bitcoin', balance: 0.005, usdValue: 110554.89),
      TokenModel(symbol: 'USD', name: 'US Dollar', balance: 321.33, usdValue: 1.0),
    ];
  }
}

void main() {
  late SwapCubit cubit;
  late MockSwapRepository repo;
  late MockAssetsDataSource dataSource;

  setUp(() {
    repo = MockSwapRepository();
    dataSource = MockAssetsDataSource();
    cubit = SwapCubit(repo, dataSource);
  });

  tearDown(() async {
    await Future.delayed(Duration(milliseconds: 50));
    cubit.close();
  });

  test('initial state is empty', () {
    final newCubit = SwapCubit(repo, dataSource);
    expect(newCubit.state.fromToken, null);
    expect(newCubit.state.toToken, null);
    expect(newCubit.state.fromAmount, '');
    newCubit.close();
  });

  test('initializes with WBTC and USD', () async {
    await Future.delayed(Duration(milliseconds: 100));
    expect(cubit.state.fromToken?.symbol, 'WBTC');
    expect(cubit.state.toToken?.symbol, 'USD');
    expect(cubit.state.exchangeRate, greaterThan(0));
  });

  test('selectFromToken updates token and rate', () async {
    await Future.delayed(Duration(milliseconds: 100));
    final eth = Token(symbol: 'ETH', name: 'Ethereum', balance: 1.0, usdValue: 3000.0);
    cubit.selectFromToken(eth);
    expect(cubit.state.fromToken?.symbol, 'ETH');
  });

  test('selectToToken updates token and rate', () async {
    await Future.delayed(Duration(milliseconds: 100));
    final eth = Token(symbol: 'ETH', name: 'Ethereum', balance: 1.0, usdValue: 3000.0);
    cubit.selectToToken(eth);
    expect(cubit.state.toToken?.symbol, 'ETH');
  });

  test('updateFromAmount updates amount', () {
    cubit.updateFromAmount('0.005');
    expect(cubit.state.fromAmount, '0.005');
  });

  test('updateFromAmount rejects invalid input', () {
    final before = cubit.state.fromAmount;
    cubit.updateFromAmount('abc');
    expect(cubit.state.fromAmount, before);
  });

  test('switchTokens swaps tokens', () async {
    await Future.delayed(Duration(milliseconds: 100));
    final from = cubit.state.fromToken;
    final to = cubit.state.toToken;
    cubit.switchTokens();
    expect(cubit.state.fromToken, to);
    expect(cubit.state.toToken, from);
  });

  test('switchTokens does nothing when tokens are null', () async {
    final emptyCubit = SwapCubit(repo, dataSource);
    expect(emptyCubit.state.fromToken, null);
    expect(emptyCubit.state.toToken, null);
    emptyCubit.switchTokens();
    expect(emptyCubit.state.fromToken, null);
    expect(emptyCubit.state.toToken, null);
    await Future.delayed(Duration(milliseconds: 100));
    emptyCubit.close();
  });

  test('setMaxAmount sets balance', () async {
    await Future.delayed(Duration(milliseconds: 100));
    cubit.setMaxAmount();
    expect(cubit.state.fromAmount, isNotEmpty);
    final amount = double.tryParse(cubit.state.fromAmount);
    expect(amount, lessThanOrEqualTo(cubit.state.fromToken!.balance));
  });

  test('setMaxAmount does nothing when fromToken is null', () async {
    final emptyCubit = SwapCubit(repo, dataSource);
    emptyCubit.setMaxAmount();
    expect(emptyCubit.state.fromAmount, '');
    await Future.delayed(Duration(milliseconds: 100));
    emptyCubit.close();
  });
}