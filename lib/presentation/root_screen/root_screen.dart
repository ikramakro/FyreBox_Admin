import 'package:fyrebox_admin/data/models/usermodel.dart';
import 'package:fyrebox_admin/presentation/device_screen/device_screen.dart';
import 'package:fyrebox_admin/presentation/root_screen/provider/root_provider.dart';
import '../../core/app_export.dart';
import '../alerts_screen/alerts_screen.dart';
import '../deshboard_screen/deshboard_screen.dart';
import '../emergency_screen/emergency_screen.dart';
import '../setting/setting_screen.dart';
import '../user_screen/user_screen.dart';
import '../visitor_screen/vistor_screen.dart';

class RootScreen extends StatefulWidget {
  final int? index;

  const RootScreen({super.key, this.index});

  @override
  RootScreenState createState() => RootScreenState();

  static Widget builder(BuildContext context, {int? index}) {
    return ChangeNotifierProvider(
      create: (context) => RootProvider(),
      child: RootScreen(index: index),
    );
  }
}

class RootScreenState extends State<RootScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late int _selectedIndex;
  PrefUtils? prefUtils;
  DBDATA? dbData;
  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.index ?? 0;
    prefUtils = PrefUtils();
    dbData = prefUtils!.getUserData();
  }

  List<Widget> _buildScreens() {
    return [
      const DeshboardScreen(),
      const UserScreen(),
      const DeviceScreen(),
      const AlertScreen().builder(context),
      const OrganizationScreen(),
      const RecycleBinScreen(),
      const SettingsScreen(),
    ];
  }

  void _onDrawerItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.pop(context); // Close the drawer after selecting an item
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(_selectedIndex == 0
              ? 'Dashboard Screen'
              : _selectedIndex == 1
                  ? 'Employee Screen'
                  : _selectedIndex == 2
                      ? 'Devices Screen'
                      : _selectedIndex == 3
                          ? 'Alerts Screen'
                          : _selectedIndex == 4
                              ? 'Organizations Screen'
                              : _selectedIndex == 5
                                  ? 'Recycle Bin Screen'
                                  : _selectedIndex == 6
                                      ? 'Setting Screen'
                                      : 'Contact FyreBox'),
          backgroundColor: const Color(0xffd61a21),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
          actions: [
            Container(
              width: 30.0,
              height: 30.0,
              decoration: BoxDecoration(
                color: Colors.transparent, // Background color inside the border
                border: Border.all(
                  color: Colors.white, // Border color
                  width: 2.0, // Border width
                ),
                borderRadius: BorderRadius.circular(7.0), // Rounded corners
              ),
              child: const Center(
                child: Icon(
                  Icons.notifications,
                  color: Colors.white, // Icon color
                  size: 15.0, // Icon size
                ),
              ),
            ),
            SizedBox(
              width: 10.h,
            ),
            PopupMenuButton<int>(
              icon: Container(
                width: 40.0.h,
                height: 40.0.v,
                decoration: BoxDecoration(
                  color:
                      Colors.transparent, // Background color inside the border
                  border: Border.all(
                    color: Colors.white, // Border color
                    width: 2.0.h, // Border width
                  ),
                  borderRadius: BorderRadius.circular(7.0), // Rounded corners
                ),
                child: CustomImageView(
                  imagePath:
                      'https://fyreboxhub.com/admin/assets/images/${dbData?.adminDp ?? ''}',
                  fit: BoxFit.contain,
                ),
              ),
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: 0,
                  child: ListTile(
                    leading: CustomImageView(
                      imagePath:
                          'https://fyreboxhub.com/admin/assets/images/${dbData?.adminDp ?? ''}',
                      fit: BoxFit.contain,
                      width: 40,
                      height: 40,
                    ),

                    //  Image.network(
                    //   'https://fyreboxhub.com/admin/assets/images/${dbData?.adminDp ?? ''}',

                    //   fit: BoxFit.contain,
                    // ),
                    title: Text(dbData?.adminFullName ?? 'Organization Name'),
                    subtitle:
                        Text(dbData?.adminOccupation ?? 'Organization Type'),
                  ),
                ),
                const PopupMenuDivider(),
                PopupMenuItem<int>(
                  value: 1,
                  child: ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text('Logout'),
                    onTap: () async {
                      PrefUtils prefUtils = PrefUtils();
                      // sp.saveToDisk('orgid', postLoginDeviceAuthResp.uSERDATA?.orgId ?? '');
                      await prefUtils.setUserData(DBDATA());
                      await prefUtils.setBoolValue('isLogin', false);
                      NavigatorService.pushNamedAndRemoveUntil(
                          AppRoutes.loginScreen);
                      // Handle logout functionality
                    },
                  ),
                ),
              ],
              onSelected: (item) {
                // Handle selection if needed
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: const Color(0xffd61a21).withOpacity(.6),
                ),
                child: Column(
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgFyreboxLogo,
                      height: 112.h,
                      width: double.maxFinite,
                      margin: EdgeInsets.only(right: 16.h),
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
              _buildDrawerItem(0, 'DashBoard'),
              _buildDrawerItem(1, 'Employee'),
              _buildDrawerItem(2, 'Devices'),
              _buildDrawerItem(3, 'Alerts'),
              _buildDrawerItem(4, 'Organizations'),
              _buildDrawerItem(5, 'Recycle Bin'),
              _buildDrawerItem(6, 'Settings'),
            ],
          ),
        ),
        body: _buildScreens()[_selectedIndex],
      ),
    );
  }

  Widget _buildDrawerItem(int index, String title) {
    return InkWell(
      onTap: () => _onDrawerItemTapped(index),
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageConstant.imgdeshboard),
            fit: BoxFit.contain,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: _selectedIndex == index ? Colors.red : Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
