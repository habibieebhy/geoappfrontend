import 'package:flutter/material.dart';
import '../models/site_model.dart';
import '../services/api_service.dart';
import 'create_site_screen.dart';

// ==========================================
// PURPOSE: Site List Screen
// Displays active sites in a dark-themed scrollable list
// ==========================================
class SiteListScreen extends StatefulWidget {
  const SiteListScreen({super.key});

  @override
  State<SiteListScreen> createState() => _SiteListScreenState();
}

class _SiteListScreenState extends State<SiteListScreen> {
  final ApiService api = ApiService();
  bool loading = true;
  List<SiteModel> sites = [];

  // ==========================================
  // PURPOSE: Initialize State
  // Triggers the data fetch on screen load
  // ==========================================
  @override
  void initState() {
    super.initState();
    loadSites();
  }

  Future<void> loadSites() async {
    setState(() => loading = true);
    await Future.delayed(const Duration(seconds: 1)); // Mock fetch
    sites = []; 
    setState(() => loading = false);
  }

  // ==========================================
  // PURPOSE: Build List Layout
  // Constructs the Scaffold with floating action button and list content
  // ==========================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Sites', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF8A4FFF),
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateSiteScreen()));
          loadSites();
        },
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Log Visit', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF8A4FFF)))
          : RefreshIndicator(
              onRefresh: loadSites,
              child: sites.isEmpty ? _buildEmptyState() : _buildList(),
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.radar, size: 80, color: const Color(0xFF2D2D3F)),
          const SizedBox(height: 24),
          const Text('No Active Sites', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 8),
          Text('Tap "Log Visit" to record intelligence\nfrom the field.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade500)),
        ],
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: sites.length,
      itemBuilder: (context, index) {
        return const SizedBox.shrink(); // Replaced with actual card mapping based on your SiteModel
      },
    );
  }
}