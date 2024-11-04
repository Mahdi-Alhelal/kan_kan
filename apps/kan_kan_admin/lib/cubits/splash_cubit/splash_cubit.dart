import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan_admin/data/data_repository.dart';
import 'package:kan_kan_admin/layer/category_data_layer.dart';
import 'package:kan_kan_admin/layer/deal_data_layer.dart';
import 'package:kan_kan_admin/layer/factory_data_layer.dart';
import 'package:kan_kan_admin/layer/order_data_layer.dart';
import 'package:kan_kan_admin/layer/product_data_layer.dart';
import 'package:kan_kan_admin/layer/user_layer.dart';
import 'package:meta/meta.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final api = DataRepository();

  final userLayer = GetIt.I.get<UserLayer>();
  final productLayer = GetIt.I.get<ProductDataLayer>();
  final factoryLayer = GetIt.I.get<FactoryDataLayer>();
  final dealLayer = GetIt.I.get<DealDataLayer>();
  final orderLayer = GetIt.I.get<OrderDataLayer>();
  final categoryLayer = GetIt.I.get<CategoryDataLayer>();

  SplashCubit() : super(SplashInitial()) {
    call();
  }

  call() async {
    await getAllData();
  }

  Future<void> getAllData() async {
    await Future.delayed(Duration.zero);
    try {
      emit(LoadingState());
      await Future.wait([
        getProductData(),
        getDealData(),
        getOrderData(),
        getFactoryData(),
        getUsers(),
        getCategories()
      ]);
      print("here");
      emit(SuccessState());
    } catch (errorMessage) {
      print("error");
      if (!isClosed) emit(ErrorState(errorMessage: errorMessage.toString()));
    }
  }

  Future<void> getProductData() async {
    productLayer.products = await api.getAllProducts();
  }

  Future<void> getDealData() async {
    dealLayer.deals = await api.getAllDeals();
  }

  Future<void> getOrderData() async {
    orderLayer.orders = await api.getAllOrders();
  }

  Future<void> getFactoryData() async {
    factoryLayer.factories = await api.getAllFactories();
  }

  Future<void> getUsers() async {
    userLayer.usersList = await api.getAllUsers();
  }

  Future<void> getCategories() async {
    categoryLayer.categories = await api.getAllCategories();
  }
}
