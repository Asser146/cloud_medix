import 'package:cloud_medix/core/routing/routes.dart';
import 'package:cloud_medix/core/theming/colors.dart';
import 'package:cloud_medix/core/widgets/loading_widget.dart';
import 'package:cloud_medix/features/auth/data/address.dart';
import 'package:cloud_medix/features/auth/presentation/screens/components/controllers_validators.dart';
import 'package:cloud_medix/features/auth/presentation/screens/components/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_medix/features/auth/data/register_body.dart';
import 'package:cloud_medix/features/auth/presentation/blocs/auth_cubit.dart';

class AddressScreen extends StatelessWidget {
  final RegisterBody registerBody;
  const AddressScreen({super.key, required this.registerBody});

  @override
  Widget build(BuildContext context) {
    final governmentController = TextEditingController();
    final cityController = TextEditingController();
    final streetController = TextEditingController();
    final buildingController = TextEditingController();
    final floorController = TextEditingController();
    final apartmentController = TextEditingController();

    List<String> validateAddress({
      required String government,
      required String city,
      required String street,
      required String building,
      String? floor,
      String? apartment,
    }) {
      final errors = <String>[];

      final govError = validateGovernment(government);
      if (govError.isNotEmpty) errors.add(govError);

      final cityError = validateCity(city);
      if (cityError.isNotEmpty) errors.add(cityError);

      final streetError = validateStreet(street);
      if (streetError.isNotEmpty) errors.add(streetError);

      final buildingError = validateBuildingNumber(building);
      if (buildingError.isNotEmpty) errors.add(buildingError);

      final floorError = validateFloor(floor ?? '');
      if (floorError != null) errors.add(floorError);

      final apartmentError = validateApartmentNumber(apartment ?? '');
      if (apartmentError != null) errors.add(apartmentError);

      return errors;
    }

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthregisterToLogin) {
          Navigator.of(context).pushReplacementNamed(Routes.login);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Stack(
          children: [
            Scaffold(
              body: Stack(
                children: [
                  SvgPicture.asset(
                    'assets/images/Register.svg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Card(
                        color: Colors.white.withAlpha(230),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Address Info',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: ColorsManager.primaryColor,
                                ),
                              ),
                              const SizedBox(height: 20),
                              buildTextField(
                                  governmentController, 'Government'),
                              buildTextField(cityController, 'City'),
                              buildTextField(streetController, 'Street'),
                              buildTextField(buildingController,
                                  'Building Number', TextInputType.number),
                              buildTextField(floorController,
                                  'Floor (optional)', TextInputType.number),
                              buildTextField(
                                  apartmentController,
                                  'Apartment Number (optional)',
                                  TextInputType.number),
                              const SizedBox(height: 24),
                              ElevatedButton(
                                onPressed: () {
                                  final errors = validateAddress(
                                    government: governmentController.text,
                                    city: cityController.text,
                                    street: streetController.text,
                                    building: buildingController.text,
                                    floor: floorController.text,
                                    apartment: apartmentController.text,
                                  );

                                  if (errors.isNotEmpty) {
                                    showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: const Text("Validation Errors"),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: errors
                                              .map((e) => Text("• $e"))
                                              .toList(),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: const Text("OK"),
                                          ),
                                        ],
                                      ),
                                    );
                                    return;
                                  }

                                  final address = Address(
                                    government: governmentController.text,
                                    city: cityController.text,
                                    street: streetController.text,
                                    buildingNumber:
                                        int.parse(buildingController.text),
                                    floor: int.tryParse(floorController.text),
                                    apartmentNumber:
                                        int.tryParse(apartmentController.text),
                                  );

                                  registerBody.address = address;

                                  context
                                      .read<AuthCubit>()
                                      .register(registerBody);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorsManager.primaryColor,
                                  minimumSize: const Size(double.infinity, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text('Register',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (isLoading)
              Container(
                color: ColorsManager.thirdColor.withAlpha((0.4 * 255).toInt()),
                child: const Center(child: LoadingWidget()),
              ),
          ],
        );
      },
    );
  }
}
