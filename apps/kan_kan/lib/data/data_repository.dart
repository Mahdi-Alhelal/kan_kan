import 'package:kan_kan/data/repository/auth_repository.dart';
import 'package:kan_kan/data/repository/category_repository.dart';
import 'package:kan_kan/data/repository/deal_repository.dart';
import 'package:kan_kan/data/repository/order_repository.dart';
import 'package:kan_kan/data/repository/payment_repository.dart';
import 'package:kan_kan/integrations/supabase/supabase_client.dart';

class DataRepository extends KanSupabase
    with
        AuthRepository,
        CategoryRepository,
        DealRepository,
        OrderRepository,
        PaymentRepository
       {}