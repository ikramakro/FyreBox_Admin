import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fyrebox_admin/presentation/visitor_screen/provider/addorg_provider.dart';
import 'package:fyrebox_admin/widgets/custom_elevated_button.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../../theme/theme_helper.dart';

class AddOrganizationScreen extends StatefulWidget {
  const AddOrganizationScreen({super.key});

  @override
  _AddOrganizationScreenState createState() => _AddOrganizationScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddOrganizationProvider(),
      child: const AddOrganizationScreen(),
    );
  }
}

class _AddOrganizationScreenState extends State<AddOrganizationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController vatController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  String selectedType = 'Select Organization Type';
  bool isActive = true;
  XFile? logoFile;
  XFile? evacuationMapFile;

  // Image picker instance
  final ImagePicker _picker = ImagePicker();

  Future<void> pickLogo() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        logoFile = pickedFile;
      });
    }
  }

  Future<void> pickEvacuationMap() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        evacuationMapFile = pickedFile;
      });
    }
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      // Call Provider method to add organization
      Provider.of<AddOrganizationProvider>(context, listen: false)
          .addOrganization(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        type: selectedType,
        vat: vatController.text,
        logo: logoFile,
        evacuationMap: evacuationMapFile,
        address: addressController.text,
        status: isActive ? 1 : 0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Organization')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration:
                      const InputDecoration(labelText: 'Organization\'s Name'),
                  validator: (value) => value!.isEmpty ? 'Enter a name' : null,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email Address'),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter an email' : null,
                ),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter a phone number' : null,
                ),
                DropdownButtonFormField<String>(
                  value: selectedType,
                  style: const TextStyle(color: Colors.black),
                  onChanged: (newValue) =>
                      setState(() => selectedType = newValue!),
                  items: [
                    'Select Organization Type',
                    'Hospital',
                    'School',
                    'Universty',
                    'Office Building',
                    'Clinic',
                    'Hotel',
                    'Factory',
                    'Warehoouse',
                    'Shopping Center',
                    'Shopping Mall',
                    'Restaurant',
                  ]
                      .map((type) =>
                          DropdownMenuItem(value: type, child: Text(type)))
                      .toList(),
                  decoration: const InputDecoration(
                    labelText: 'Type',
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                ),
                TextFormField(
                  controller: vatController,
                  decoration: const InputDecoration(labelText: 'VAT Number'),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: pickLogo,
                      child: Text(
                          logoFile == null ? 'Choose Logo' : 'Logo Selected'),
                    ),
                    Text(logoFile != null ? 'File Selected' : 'No file chosen'),
                  ],
                ),
                // Display selected logo image
                if (logoFile != null)
                  Image.file(File(logoFile!.path), height: 100, width: 100),
                Row(
                  children: [
                    TextButton(
                      onPressed: pickEvacuationMap,
                      child: Text(evacuationMapFile == null
                          ? 'Choose Evacuation Map'
                          : 'Map Selected'),
                    ),
                    Text(evacuationMapFile != null
                        ? 'File Selected'
                        : 'No file chosen'),
                  ],
                ),
                // Display selected evacuation map image
                if (evacuationMapFile != null)
                  Image.file(File(evacuationMapFile!.path),
                      height: 100, width: 100),
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter an address' : null,
                ),
                // Replacing Switch with Checkbox
                CheckboxListTile(
                  title: const Text('Organization Status'),
                  value: isActive,
                  onChanged: (value) => setState(() => isActive = value!),
                  activeColor: Colors.green,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                const SizedBox(height: 20),
                CustomElevatedButton(
                  buttonStyle: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(appTheme.deepOrangeA100)),
                  onPressed: submitForm,
                  text: 'Add Organization',
                  height: 50,
                  width: double.infinity,
                ),
                // ElevatedButton(
                //   onPressed: submitForm,
                //   child: const Text('Add Organization'),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
