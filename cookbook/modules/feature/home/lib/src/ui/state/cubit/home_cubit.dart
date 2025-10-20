import 'package:core_common/ui/state/cubit/app_cubit.dart';
import 'package:home/src/navigation/navigation.dart';
import 'package:home/src/ui/state/home_state.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._navigation) : super(HomeState());

  late AppCubit appCubit;
  final HomeNavigation _navigation;

  void initialize({required AppCubit appCubit}) {
    this.appCubit = appCubit;
    _initialize();
  }
  Future<void> _initialize() async {
    var session = await appCubit.getSession();
    emit(HomeState(session: session));
    return;
  }

  void refreshToken() async {
    await appCubit.refreshToken();
    _initialize();
  }

  void signOut() async {
    await appCubit.signOut();
    pop();
  }

  void pop() => _navigation.pop();
}
