
import 'package:provider/provider.dart';
import 'package:staarm_mobile/core/models/protection_plan.dart';
import 'package:staarm_mobile/core/providers/vehicle_provider.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';

class SelectProtectionPlanViewModel extends BaseViewModel {
  
  ProtectionPlanModel _selectedPlan;
  ProtectionPlanModel get selectedPlan => _selectedPlan;
  set selectedPlan(ProtectionPlanModel val){
    _selectedPlan = val;
    notifyListeners();
  }

  List<ProtectionPlanModel> _plans;
  List<ProtectionPlanModel> get plans => _plans;
  set plans(List<ProtectionPlanModel> val){
    _plans = val;
    notifyListeners();
  }

  void init() async {
    //sync protection plans
    VehicleProvider _vehicleProviders = Provider.of<VehicleProvider>(appContext, listen: false);

    if(_vehicleProviders.protectionPlans.length == 0){
      await _vehicleProviders.syncProtectionPlans();
    }
  }
}