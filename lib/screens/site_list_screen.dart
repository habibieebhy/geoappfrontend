import 'package:flutter/material.dart';
import '../models/site_model.dart';
import '../services/api_service.dart';
import 'create_site_screen.dart';

// ==========================================
// PURPOSE: Site List Screen
// Displays active sites in a clean, eco-themed scrollable list
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
        title: const Text('Active Sites', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22)),
        actions: [
          IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {}),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF135029), // Deep green
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateSiteScreen()));
          loadSites();
        },
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Log Visit', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF135029)))
          : RefreshIndicator(
              color: const Color(0xFF135029),
              backgroundColor: Colors.white,
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
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: const Color(0xFFE8F3E9), shape: BoxShape.circle),
            child: const Icon(Icons.forest_outlined, size: 60, color: Color(0xFF135029)),
          ),
          const SizedBox(height: 24),
          const Text('No Active Sites', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A1C19))),
          const SizedBox(height: 8),
          Text('Tap "Log Visit" to record eco-friendly\nconstruction intelligence.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade600, height: 1.5)),
        ],
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: sites.length,
      itemBuilder: (context, index) {
        return const SizedBox.shrink(); // Mapping logic goes here
      },
    );
  }
}