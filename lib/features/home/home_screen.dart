import 'dart:async';
import 'package:cloud_medix/core/routing/routes.dart';
import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/features/home/components/home_app_bar.dart';
import 'package:cloud_medix/features/home/components/home_option.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool hasInternet = false;
  bool showBanner = false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 0.34 * MediaQuery.of(context).size.height,
                child: HomeAppBar(
                  height: 0.34 * MediaQuery.of(context).size.height,
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
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
                      _buildOption(Routes.makeReservation, "Make Reservation",
                          "assets/images/make_reservation.svg"),
                      _buildOption(Routes.myReservations, "My Reservations",
                          "assets/images/my_reservations.svg",
                          isMyReservations: true),
                      _buildOption(Routes.diagnosisTreatments,
                          "Diagnosis/Treatments", "assets/images/protect.svg"),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Animated banner
          SafeArea(
            child: AnimatedSlide(
              offset: showBanner ? Offset(0, 0) : Offset(0, -1),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              child: AnimatedOpacity(
                opacity: showBanner ? 1 : 0,
                duration: const Duration(milliseconds: 400),
                child: Container(
                  width: double.infinity,
                  color: Colors.grey,
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.wifi_off, color: Colors.white),
                      SizedBox(width: 8.w),
                      Text(
                        "No internet connection",
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
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
