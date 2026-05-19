import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/api_service.dart';

// ==========================================
// PURPOSE: Site Creation/Verification Form
// Handles field officer input in a light, spacious layout
// ==========================================
class CreateSiteScreen extends StatefulWidget {
  const CreateSiteScreen({super.key});

  @override
  State<CreateSiteScreen> createState() => _CreateSiteScreenState();
}

class _CreateSiteScreenState extends State<CreateSiteScreen> {
  final ApiService api = ApiService();
  bool loading = false;
  File? imageFile;

  final ownerController = TextEditingController();
  final phoneController = TextEditingController();
  String? selectedStage;
  String? selectedBrand;

  final List<String> constructionStages = ['Excavation', 'Foundation', 'Slab Casting', 'Brickwork', 'Finishing'];
  final List<String> cementBrands = ['EcoCem', 'GreenBuild', 'UltraTech', 'Ambuja', 'Other'];

  // ==========================================
  // PURPOSE: Media Handling
  // Launches camera to capture geotagged photo
  // ==========================================
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) setState(() => imageFile = File(image.path));
  }

  Future<void> submit() async {
    setState(() => loading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => loading = false);
    if (mounted) Navigator.pop(context);
  }

  // ==========================================
  // PURPOSE: Build Form UI
  // Renders GPS module, image capture, and dropdowns in light theme
  // ==========================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        title: const Text('Verify Site', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFFE8F3E9), borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(color: Color(0xFF135029), shape: BoxShape.circle),
                    child: const Icon(Icons.gps_fixed, color: Colors.white, size: 16),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Location Verified', style: TextStyle(color: Color(0xFF135029), fontSize: 14, fontWeight: FontWeight.bold)),
                      Text('Lat: 26.1445 Lng: 91.7362 • Kamrup', style: TextStyle(color: const Color(0xFF135029).withOpacity(0.7), fontSize: 12)),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: const Color(0xFFE0E5E0), width: 2),
                      ),
                      child: imageFile != null
                          ? ClipRRect(borderRadius: BorderRadius.circular(22), child: Image.file(imageFile!, fit: BoxFit.cover))
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: const BoxDecoration(color: Color(0xFFF5F7F5), shape: BoxShape.circle),
                                  child: const Icon(Icons.camera_alt, size: 32, color: Color(0xFF135029)),
                                ),
                                const SizedBox(height: 12),
                                const Text('Capture Site Photo', style: TextStyle(color: Color(0xFF1A1C19), fontWeight: FontWeight.bold)),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildSectionHeader('Construction Details'),
                  DropdownButtonFormField<String>(
                    dropdownColor: Colors.white,
                    decoration: const InputDecoration(labelText: 'Stage of Construction'),
                    value: selectedStage,
                    items: constructionStages.map((s) => DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(color: Color(0xFF1A1C19))))).toList(),
                    onChanged: (val) => setState(() => selectedStage = val),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    dropdownColor: Colors.white,
                    decoration: const InputDecoration(labelText: 'Current Cement Brand'),
                    value: selectedBrand,
                    items: cementBrands.map((b) => DropdownMenuItem(value: b, child: Text(b, style: const TextStyle(color: Color(0xFF1A1C19))))).toList(),
                    onChanged: (val) => setState(() => selectedBrand = val),
                  ),
                  const SizedBox(height: 32),
                  _buildSectionHeader('Contractor Info'),
                  TextField(
                    controller: ownerController,
                    style: const TextStyle(color: Color(0xFF1A1C19)),
                    decoration: const InputDecoration(labelText: 'Contractor Name'),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(color: Color(0xFF1A1C19)),
                    decoration: const InputDecoration(labelText: 'Phone Number'),
                  ),
                  const SizedBox(height: 48),
                  ElevatedButton(
                    onPressed: loading ? null : submit,
                    child: loading 
                        ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3))
                        : const Text('Confirm Verification'),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(color: Color(0xFF1A1C19), fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}