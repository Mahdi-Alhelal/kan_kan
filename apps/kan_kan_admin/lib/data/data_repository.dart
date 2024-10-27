import 'package:kan_kan_admin/data/repositories/address_repository.dart';
import 'package:kan_kan_admin/data/repositories/auth_repository.dart';
import 'package:kan_kan_admin/data/repositories/category_repository.dart';
import 'package:kan_kan_admin/data/repositories/deal_repository.dart';
import 'package:kan_kan_admin/data/repositories/factory_repository.dart';
import 'package:kan_kan_admin/data/repositories/order_repository.dart';
import 'package:kan_kan_admin/data/repositories/payment_repository.dart';
import 'package:kan_kan_admin/data/repositories/product_repository.dart';
import 'package:kan_kan_admin/data/repositories/users_repository.dart';
import 'package:kan_kan_admin/integrations/supabase/supabase_client.dart';

class DataRepository extends KanSupabase
    with
        AddressRepository,
        AuthRepository,
        CategoryRepository,
        DealRepository,
        FactoryRepository,
        OrderRepository,
        PaymentRepository,
        ProductRepository,
        UsersRepository,
        ProductRepository {}
