import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staarm_mobile/core/providers/user_provider.dart';
import 'package:staarm_mobile/ui/base/base_view.dart';
import 'package:staarm_mobile/widgets/buttons/app_button.dart';
import 'package:staarm_mobile/widgets/buttons/auth_dob_button.dart';
import 'package:staarm_mobile/widgets/buttons/bottom_app_button_container.dart';
import 'package:staarm_mobile/widgets/textfields/normal_auth_textfield.dart';

import 'view_model.dart';

class PersonalInformation extends StatelessWidget {
  const PersonalInformation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<PersonalInformationViewModel>(
      model: PersonalInformationViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Color(0xFF717171),
          ),
          title: Text(
            'Personal Information',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ),
        body: Consumer<UserProvider>(
          builder: (context, userProvider, _) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 17,
              ),
              child: Column(
                children: [
                  NormalAuthTextField(
                    labelText: 'First name',
                    controller: model.firstNameTextController,
                    // validator: model.fieldValidator,
                    // onSave: model.saveFirstName,
                  ),
                  NormalAuthTextField(
                    labelText: 'Last name',
                    controller: model.lastNameTextController,
                    // validator: model.fieldValidator,
                    // onSave: model.saveLastName,
                  ),
                  NormalAuthTextField(
                    labelText: 'Email address',
                    controller: model.emailTextController,
                    // validator: model.emailValidator,
                    // onSave: model.saveEmail,
                  ),
                  NormalAuthTextField(
                    labelText: 'About',
                    controller: model.aboutTextController,
                    maxLines: 4,
                    // validator: model.emailValidator,
                    // onSave: model.saveEmail,
                  ),
                  AuthDOBButton(
                    text: model.formattedDOB,
                    onTap: model.showDatePicker,
                  ),
                  AppButton(
                    isLoading: model.isLoading,
                    onPressed: () {
                      model.updateProfile();
                    },
                    text: 'Save',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
