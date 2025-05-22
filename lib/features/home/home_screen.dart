import 'dart:async';
import 'package:cloud_medix/core/di/dependency_injection.dart';
import 'package:cloud_medix/core/routing/routes.dart';
import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/core/widgets/loading_widget.dart';
import 'package:cloud_medix/features/home/components/home_app_bar.dart';
import 'package:cloud_medix/features/home/components/home_option.dart';
import 'package:cloud_medix/features/home/components/internet_connection_message.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool hasInternet = false;
  bool showBanner = false;
  bool isLoading = true;
  String userName = "UserName";
  late StreamSubscription<List<ConnectivityResult>> subscription;

  @override
  void initState() {
    super.initState();
    _checkInternet();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      final hasConnection = results.contains(ConnectivityResult.wifi) ||
          results.contains(ConnectivityResult.mobile);
      setState(() {
        hasInternet = hasConnection;
        showBanner = !hasConnection;
      });
    });
    _getUserName();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  Future<void> _checkInternet() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    final isConnected = connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile);
    setState(() {
      hasInternet = isConnected;
      showBanner = !isConnected;
    });
  }

  Future<void> _getUserName() async {
    final FlutterSecureStorage storage = getIt<FlutterSecureStorage>();
    String? storedUserName = await storage.read(key: "user_name");

    setState(() {
      userName = storedUserName ?? "UserName";
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backgroundColor,
      body: isLoading
          ? Center(child: LoadingWidget())
          : Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 0.34 * MediaQuery.of(context).size.height,
                      child: HomeAppBar(
                        height: 0.34 * MediaQuery.of(context).size.height,
                        userName: userName,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 10.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildOption(
                                Routes.viewMedicalRecord,
                                "View Medical Record",
                                "assets/images/medical_record.svg"),
                            _buildOption(
                                Routes.testsScanResults,
                                "Tests/Scans Results",
                                "assets/images/home_container1.svg"),
                            _buildOption(
                                Routes.makeReservation,
                                "Make Reservation",
                                "assets/images/make_reservation.svg"),
                            _buildOption(
                                Routes.myReservations,
                                "My Reservations",
                                "assets/images/my_reservations.svg",
                                isMyReservations: true),
                            _buildOption(
                                Routes.diagnosisTreatments,
                                "Diagnosis/Treatments",
                                "assets/images/protect.svg"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Animated banner
                InternetConnectionMessage(showBanner: showBanner),
              ],
            ),
    );
  }

  Widget _buildOption(String route, String text, String assetPath,
      {bool isMyReservations = false}) {
    return GestureDetector(
      onTap: () => hasInternet ? Navigator.pushNamed(context, route) : {},
      child: HomeOption(
        text: text,
        path: assetPath,
        isInternet: hasInternet,
        isMyReservations: isMyReservations,
      ),
    );
  }
}
