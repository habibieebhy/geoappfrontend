import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/api_service.dart';

// ==========================================
// PURPOSE: Site Creation/Verification Form
// Handles field officer input in a dark-themed step process
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
  final List<String> cementBrands = ['UltraTech', 'Ambuja', 'ACC', 'Shree', 'Dalmia', 'Other'];

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
  // Renders GPS module, image capture, and dropdowns
  // ==========================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Site Verification', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              color: const Color(0xFF1F1F2E),
              child: Row(
                children: [
                  const Icon(Icons.gps_fixed, color: Color(0xFF00E676)),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('GPS LOCATION ACQUIRED', style: TextStyle(color: Color(0xFF00E676), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1)),
                      Text('Lat: 26.1445  Lng: 91.7362 • Kamrup, Assam', style: TextStyle(color: Colors.grey.shade300, fontFamily: 'monospace', fontSize: 13)),
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
                  _buildSectionHeader('1. Visual Verification'),
                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F1F2E),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFF8A4FFF).withOpacity(0.3), width: 2),
                      ),
                      child: imageFile != null
                          ? ClipRRect(borderRadius: BorderRadius.circular(18), child: Image.file(imageFile!, fit: BoxFit.cover))
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.camera_alt, size: 48, color: Color(0xFF8A4FFF)),
                                SizedBox(height: 12),
                                Text('Capture Geotagged Photo', style: TextStyle(color: Color(0xFF8A4FFF), fontWeight: FontWeight.bold)),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildSectionHeader('2. Site Details'),
                  DropdownButtonFormField<String>(
                    dropdownColor: const Color(0xFF2D2D3F),
                    decoration: const InputDecoration(labelText: 'Stage of Construction', prefixIcon: Icon(Icons.architecture, color: Color(0xFF8B8B9D))),
                    value: selectedStage,
                    items: constructionStages.map((s) => DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(color: Colors.white)))).toList(),
                    onChanged: (val) => setState(() => selectedStage = val),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    dropdownColor: const Color(0xFF2D2D3F),
                    decoration: const InputDecoration(labelText: 'Current Cement Brand', prefixIcon: Icon(Icons.business, color: Color(0xFF8B8B9D))),
                    value: selectedBrand,
                    items: cementBrands.map((b) => DropdownMenuItem(value: b, child: Text(b, style: const TextStyle(color: Colors.white)))).toList(),
                    onChanged: (val) => setState(() => selectedBrand = val),
                  ),
                  const SizedBox(height: 32),
                  _buildSectionHeader('3. Contractor Info'),
                  TextField(
                    controller: ownerController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: 'Contractor / Owner Name', prefixIcon: Icon(Icons.person, color: Color(0xFF8B8B9D))),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(labelText: 'Phone Number', prefixIcon: Icon(Icons.phone, color: Color(0xFF8B8B9D))),
                  ),
                  const SizedBox(height: 48),
                  ElevatedButton(
                    onPressed: loading ? null : submit,
                    child: loading 
                        ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3))
                        : const Text('SUBMIT VERIFICATION'),
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
        title.toUpperCase(),
        style: const TextStyle(color: Color(0xFF8B8B9D), fontSize: 13, fontWeight: FontWeight.w800, letterSpacing: 1.2),
      ),
    );
  }
}