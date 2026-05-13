import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/api_service.dart';

class CreateSiteScreen extends StatefulWidget {
  const CreateSiteScreen({super.key});

  @override
  State<CreateSiteScreen> createState() => _CreateSiteScreenState();
}

class _CreateSiteScreenState extends State<CreateSiteScreen> {
  final ApiService api = ApiService();

  // OWNER
  final ownerController = TextEditingController();

  final ownerPhoneController = TextEditingController();

  // MASON
  final masonNameController = TextEditingController();

  final masonPhoneController = TextEditingController();

  final totalMasonsController = TextEditingController();

  // MARKET
  final dealerController = TextEditingController();

  final dealerPhoneController = TextEditingController();

  final nearbyDealerController = TextEditingController();

  final brandController = TextEditingController();

  final logisticsController = TextEditingController();

  // CONSTRUCTION
  final stageController = TextEditingController();

  final activityController = TextEditingController();

  final completionDateController = TextEditingController();

  // POTENTIAL
  final totalBagsController = TextEditingController();

  final myBrandBagsController = TextEditingController();

  // LOCATION
  final latitudeController = TextEditingController();

  final longitudeController = TextEditingController();

  final distanceController = TextEditingController();

  // REMARKS
  final remarksController = TextEditingController();

  bool loading = false;

  File? imageFile;

  Future<void> pickImage() async {
    final picker = ImagePicker();

    final image = await picker.pickImage(source: ImageSource.camera);

    if (image == null) return;

    setState(() {
      imageFile = File(image.path);
    });
  }

  Future<void> createSite() async {
    setState(() {
      loading = true;
    });

    String? imageUrl;

    if (imageFile != null) {
      imageUrl = await api.uploadPhoto(imageFile!.path);
    }

    await api.createSite({
      'ownerName': ownerController.text,

      'ownerPhoneNumber': ownerPhoneController.text,

      'workingMasonName': masonNameController.text,

      'workingMasonPhoneNumber': masonPhoneController.text,

      'totalMasonsWorking': int.tryParse(totalMasonsController.text),

      'siteImageUrl': imageUrl,

      'latitude': latitudeController.text,

      'longitude': longitudeController.text,

      'distanceInMeters': distanceController.text,

      'activity': activityController.text,

      'stageOfConstruction': stageController.text,

      'expectedDateOfCompletion': completionDateController.text,

      'currentBrandUsing': brandController.text,

      'currentLogisticsPartner': logisticsController.text,

      'totalBagsPotential': int.tryParse(totalBagsController.text),

      'myBrandBagsPotential': int.tryParse(myBrandBagsController.text),

      'dealerName': dealerController.text,

      'dealerPhoneNumber': dealerPhoneController.text,

      'myBrandNearbyDealerName': nearbyDealerController.text,

      'additionalRemarks': remarksController.text,

      'isVerifiedSite': true,
    });

    setState(() {
      loading = false;
    });

    if (!mounted) return;

    Navigator.pop(context);
  }

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,

      initialDate: DateTime.now(),

      firstDate: DateTime(2020),

      lastDate: DateTime(2100),
    );

    if (picked == null) return;

    completionDateController.text = picked.toIso8601String().split('T')[0];

    setState(() {});
  }

  Widget buildField({
    required TextEditingController controller,

    required String label,

    IconData? icon,

    TextInputType? keyboardType,

    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),

      child: TextField(
        controller: controller,

        keyboardType: keyboardType,

        maxLines: maxLines,

        decoration: InputDecoration(
          labelText: label,

          prefixIcon: icon != null ? Icon(icon) : null,

          filled: true,

          fillColor: Colors.grey.shade100,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),

            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 16),

      child: Text(
        title,

        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(elevation: 0, title: const Text('New Site Visit')),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            buildSectionTitle('Owner Information'),

            buildField(
              controller: ownerController,
              label: 'Owner Name',
              icon: Icons.person,
            ),

            buildField(
              controller: ownerPhoneController,
              label: 'Owner Phone',
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
            ),

            buildSectionTitle('Mason Information'),

            buildField(
              controller: masonNameController,
              label: 'Mason Name',
              icon: Icons.engineering,
            ),

            buildField(
              controller: masonPhoneController,
              label: 'Mason Phone',
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
            ),

            buildField(
              controller: totalMasonsController,
              label: 'Total Masons',
              icon: Icons.groups,
              keyboardType: TextInputType.number,
            ),

            buildSectionTitle('Construction'),

            buildField(
              controller: stageController,
              label: 'Stage of Construction',
              icon: Icons.home_work,
            ),

            buildField(
              controller: activityController,
              label: 'Activity Score',
              icon: Icons.analytics,
              keyboardType: TextInputType.number,
            ),

            GestureDetector(
              onTap: pickDate,

              child: AbsorbPointer(
                child: buildField(
                  controller: completionDateController,

                  label: 'Expected Completion Date',

                  icon: Icons.calendar_month,
                ),
              ),
            ),

            buildSectionTitle('Market Intelligence'),

            buildField(
              controller: brandController,
              label: 'Current Brand',
              icon: Icons.business,
            ),

            buildField(
              controller: logisticsController,
              label: 'Logistics Partner',
              icon: Icons.local_shipping,
            ),

            buildField(
              controller: dealerController,
              label: 'Dealer Name',
              icon: Icons.store,
            ),

            buildField(
              controller: dealerPhoneController,
              label: 'Dealer Phone',
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
            ),

            buildField(
              controller: nearbyDealerController,
              label: 'Nearby Dealer',
              icon: Icons.location_city,
            ),

            buildSectionTitle('Potential'),

            buildField(
              controller: totalBagsController,
              label: 'Total Bags Potential',
              icon: Icons.inventory_2,
              keyboardType: TextInputType.number,
            ),

            buildField(
              controller: myBrandBagsController,
              label: 'My Brand Potential',
              icon: Icons.trending_up,
              keyboardType: TextInputType.number,
            ),

            buildSectionTitle('Location'),

            buildField(
              controller: latitudeController,
              label: 'Latitude',
              icon: Icons.my_location,
            ),

            buildField(
              controller: longitudeController,
              label: 'Longitude',
              icon: Icons.map,
            ),

            buildField(
              controller: distanceController,
              label: 'Distance in Meters',
              icon: Icons.social_distance,
            ),

            buildSectionTitle('Remarks'),

            buildField(
              controller: remarksController,
              label: 'Additional Remarks',
              icon: Icons.notes,
              maxLines: 4,
            ),

            buildSectionTitle('Site Photo'),

            GestureDetector(
              onTap: pickImage,

              child: Container(
                height: 220,

                width: double.infinity,

                decoration: BoxDecoration(
                  color: Colors.grey.shade200,

                  borderRadius: BorderRadius.circular(20),
                ),

                child: imageFile != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),

                        child: Image.file(imageFile!, fit: BoxFit.cover),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: const [
                          Icon(Icons.camera_alt, size: 52),

                          SizedBox(height: 12),

                          Text('Tap to capture photo'),
                        ],
                      ),
              ),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,

              height: 58,

              child: ElevatedButton(
                onPressed: loading ? null : createSite,

                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),

                child: loading
                    ? const CircularProgressIndicator()
                    : const Text(
                        'Save Site Visit',

                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
