import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/app/locator.dart';
import 'package:staarm_mobile/core/api/api_helpers.dart';
import 'package:staarm_mobile/core/models/user.dart';
import 'package:staarm_mobile/core/providers/user_provider.dart';
import 'package:staarm_mobile/core/services/auth_service/auth_service.dart';
import 'package:staarm_mobile/styles/colors.dart';
import 'package:staarm_mobile/ui/base/base_view_model.dart';
import 'package:staarm_mobile/utils/staarm_app_notification.dart';

class PersonalInformationViewModel extends BaseViewModel {
  final _authService = locator<AuthService>();
  final DateFormat dateRequestFormatter = DateFormat('yyyy/MM/dd');

  TextEditingController firstNameTextController;
  TextEditingController lastNameTextController;
  TextEditingController emailTextController;
  TextEditingController aboutTextController;

  // DateTime _selectedDate = DateTime.now();
  DateTime _selectedDate;
  DateTime get selectedDate => _selectedDate;
  set selectedDate(DateTime val) {
    _selectedDate = val;
    notifyListeners();
  }

  String get formattedDOB {
    if (selectedDate == null) return '--/--/----';
    return dateRequestFormatter.format(selectedDate);
  }

  void init() {
    UserProvider _userProvider =
        Provider.of<UserProvider>(appContext, listen: false);

    firstNameTextController =
        TextEditingController(text: _userProvider.user?.firstName ?? '');
    lastNameTextController =
        TextEditingController(text: _userProvider.user?.lastName ?? '');
    emailTextController =
        TextEditingController(text: _userProvider.user?.email ?? '');
    aboutTextController =
        TextEditingController(text: _userProvider.user?.about ?? '');

    //handle DOB

    String _userDOB = _userProvider.user?.dob;

    print("user dob --- $_userDOB");

    if (_userDOB != null || _userDOB.isNotEmpty) {
      List<String> _formattedDobs = _userDOB.split(' ');
      List<String> _dobs = _formattedDobs.first.split('-');

      if (_dobs.length >= 3) {
        int year = int.tryParse(_dobs[2]) ?? 2000;
        int month = int.tryParse(_dobs[1]) ?? 01;
        int day = int.tryParse(_dobs[0]) ?? 01;
        print("user dob - year --- $year");
        print("user dob - month --- $month");
        print("user dob - day --- $day");

        DateTime _date = DateTime(year, month, day);
        selectedDate = _date;
      }
    }
  }

  //// show date picker
  void showDatePicker() async {
    final today = DateTime.now();
    final pastDate = DateTime(today.year - 80, 1, 1);

    final DateTime picked = await DatePicker.showDatePicker(
      appContext,
      showTitleActions: true,
      maxTime: DateTime(today.year, today.month, today.day),
      minTime: DateTime(pastDate.year, pastDate.month, pastDate.day),
      currentTime: _selectedDate,
      locale: LocaleType.en,
      theme: DatePickerTheme(
        doneStyle: TextStyle(
          color: AppColors.mainPurple,
        ),
      ),
    );

    if (picked != null && picked != selectedDate) selectedDate = picked;
  }

  void updateProfile() async {
    if (selectedDate == null) {
      StaarmAppNotification.error(message: 'Select date of birth');
      return;
    }

    String _dobFormatted = dateRequestFormatter.format(selectedDate);
    List<String> date = _dobFormatted.split('/');
    _dobFormatted = '${date[2]}-${date[1]}-${date[0]}';

    print("Date formatted --- $_dobFormatted");

    isLoading = true;
    dynamic res = await _authService.updateUserProfile(
      email: emailTextController.text,
      firstName: firstNameTextController.text,
      lastName: lastNameTextController.text,
      dob: _dobFormatted,
      about: aboutTextController.text,
    );
    isLoading = false;

    APIHelpers.handleResponse(res, onSuccess: (response) async {
      UserProvider _userProvider =
          Provider.of<UserProvider>(appContext, listen: false);

      UserModel _userModel = _userProvider.user;
      _userModel.firstName = firstNameTextController.text;
      _userModel.lastName = lastNameTextController.text;
      _userModel.email = emailTextController.text;
      _userModel.about = aboutTextController.text;
      _userModel.dob = _dobFormatted;

      _userProvider.saveUser(_userModel);

      StaarmAppNotification.success(message: 'Profile successfully updated');
      Navigator.of(appContext).pop();

      // Navigator.push(
      //   appContext,
      //   StaarmPageRoute.routeTo(
      //     builder: (context) => SelectCar3View(
      //       draftId: vehicleDraftId,
      //     ),
      //   ),
      // );
    });
  }
}
