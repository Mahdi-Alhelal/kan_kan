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
    final userLayer = GetIt.I.get<UserDataLayer>();

  HomeCubit() : super(HomeInitial()) {
    call();
  }
  final dealLayer = GetIt.I.get<DealDataLayer>();

  call() async {
    await getAllDeals();
    await getAllDealsAndCategories();
  }

  getAllDeals() async {
    emit(LoadingHomeState());

    try {
      emit(SuccessHomeState());
      dealLayer.deals = await DataRepository().getAllDeals();

      return dealLayer.deals;
    } catch (e) {
      print(e);
    }
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
                emit(SuccessHomeState());
              })
          .subscribe();
      print(dealLayer.deals.first.dealTitle);
      return dealLayer.deals;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
