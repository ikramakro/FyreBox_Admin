// import 'package:flutter/material.dart';
// import 'package:flutter_switch/flutter_switch.dart';
import 'package:fyrebox_admin/core/app_export.dart';
import 'package:fyrebox_admin/widgets/custom_text_form_field1.dart';
// import 'package:intl/intl.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/custom_elevated_button.dart';

import 'provider/user_provider.dart'; // Assuming you have this widget

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();

  Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const AddEmployeeScreen(),
    );
  }
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Employee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Consumer<UserProvider>(builder: (context, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomDropDown(
                  hintText: '-- Select Employee Role --',
                  items: provider.employeeRole,
                  onChanged: (value) {
                    provider.setSelectedEmpType(value.id ?? 0);
                  },
                ),
                const SizedBox(height: 16.0),
                CustomTextFormField1(
                  controller: provider.userNameController,
                  hintText: 'Employee Name',
                ),
                const SizedBox(height: 16.0),
                CustomTextFormField1(
                  controller: provider.emailController,
                  hintText: 'Employee Email',
                ),
                const SizedBox(height: 16.0),
                CustomTextFormField1(
                  controller: provider.passwordController,
                  hintText: 'Password',
                ),
                const SizedBox(height: 16.0),
                CustomTextFormField1(
                  controller: provider.confirmPasswordController,
                  hintText: 'Confirm Password',
                ),
                const SizedBox(height: 16.0),
                CustomTextFormField1(
                  controller: provider.phoneController,
                  hintText: 'Phone Number',
                ),
                const SizedBox(height: 16.0),
                CustomTextFormField1(
                  controller: provider.addressController,
                  hintText: 'Address',
                ),
                const SizedBox(height: 16.0),
                const SizedBox(height: 24.0),
                CustomElevatedButton(
                  buttonStyle: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(appTheme.deepOrangeA100)),
                  onPressed: () {
                    provider.addUser();
                  },
                  text: 'Add Emplyee',
                  height: 50,
                  width: double.infinity,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
