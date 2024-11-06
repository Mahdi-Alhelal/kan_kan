import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kan_kan/data/data_repository.dart';
import 'package:kan_kan/integrations/supabase/supabase_client.dart';
import 'package:kan_kan/layer/deal_data_layer.dart';
import 'package:kan_kan/layer/user_data_layer.dart';
import 'package:kan_kan/model/deal_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  List<DealModel> deals = [];
  int initDeal = -1;
  final userLayer = GetIt.I.get<UserDataLayer>();
  int isClicked = 0;

  HomeCubit() : super(HomeInitial());
  final dealLayer = GetIt.I.get<DealDataLayer>();

  call() async {
    await getAllDeals();
    await getAllDealsAndCategories();
    await getAllCategories();
  }

  getAllDeals() async {
    emit(LoadingHomeState());

    try {
      dealLayer.deals = await DataRepository().getDeals();

      dealLayer.allDeals = await DataRepository().getAllDeals();

      deals = dealLayer.deals;
      emit(SuccessHomeState());

      return dealLayer.deals;
    } catch (e) {
    }
  }

  filterDeals(int dealCategoryID) {
    if (dealCategoryID != -1) {
      deals = dealLayer.deals
          .where((deal) => deal.categoryId == dealCategoryID)
          .toList();
    } else {
      deals = dealLayer.deals;
    }
    if (!isClosed) emit(SuccessHomeState());
  }

  getAllActiveDeals() async {
    isClicked = 0;
    emit(LoadingHomeState());
   deals = dealLayer.getActiveDeals();
    emit(SuccessHomeState());
  }

  getAllPreviosDeals() async {
    isClicked = 1;
    emit(LoadingHomeState());

    deals = dealLayer.getPreviosDeals();
    emit(SuccessHomeState());
  }

  getAllDealsAndCategories() async {
    Future.delayed(Duration.zero);

    emit(LoadingHomeState());

    // Subscribe to the 'deals' table
    try {
      KanSupabase.supabase.client
          .channel('public:deals')
          .onPostgresChanges(
              event: PostgresChangeEvent.all,
              schema: 'public',
              table: 'deals',
              callback: (payload) async {
                dealLayer.deals =
                    await DataRepository().getAllDealsAndCategoriess();
                deals = dealLayer.deals;
                emit(SuccessHomeState());
              })
          .subscribe();
      return deals;
    } catch (e) {
      return null;
    }
  }

  getAllCategories() async {
    emit(LoadingHomeState());
    await Future.delayed(Duration.zero);
    try {
      dealLayer.categories = await DataRepository().getAllCategories();
      dealLayer.filterCategories =
          List.from(await DataRepository().getAllCategories());
      dealLayer.filterCategories
          .add({"category_id": -1, "category_name": "جميع الأقسام"});
      dealLayer.filterCategories = dealLayer.filterCategories.reversed.toList();
      emit(SuccessHomeState());
    } catch (e) {
      throw ("خطأ في تحميل الاقسام");
    }
  }

  updateChipCategory() {
    emit(UpdateCategoryHomeState());
  }
}
