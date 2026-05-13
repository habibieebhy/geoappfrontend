import 'package:flutter/material.dart';

import '../models/site_model.dart';
import '../services/api_service.dart';
import 'create_site_screen.dart';

class SiteListScreen extends StatefulWidget {
  const SiteListScreen({super.key});

  @override
  State<SiteListScreen> createState() =>
      _SiteListScreenState();
}

class _SiteListScreenState
    extends State<SiteListScreen> {

  final ApiService api = ApiService();

  bool loading = true;

  List<SiteModel> sites = [];

  @override
  void initState() {
    super.initState();
    loadSites();
  }

  Future<void> loadSites() async {

    setState(() {
      loading = true;
    });

    final response = await api.getSites();

    sites = response
        .map<SiteModel>(
          (e) => SiteModel.fromJson(e),
        )
        .toList();

    setState(() {
      loading = false;
    });
  }

  Future<void> deleteSite(int id) async {

    await api.deleteSite(id);

    await loadSites();
  }

  @override
  @override
Widget build(BuildContext context) {

  return Scaffold(

    backgroundColor: Colors.grey.shade100,

    appBar: AppBar(

      elevation: 0,

      title: const Text(

        'Brixta Sites',

        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    floatingActionButton:
        FloatingActionButton.extended(

      onPressed: () async {

        await Navigator.push(

          context,

          MaterialPageRoute(
            builder: (_) =>
                CreateSiteScreen(),
          ),
        );

        loadSites();
      },

      icon: const Icon(Icons.add),

      label: const Text('New Visit'),
    ),

    body: loading

        ? const Center(
            child: CircularProgressIndicator(),
          )

        : RefreshIndicator(

            onRefresh: loadSites,

            child: SingleChildScrollView(

              physics:
                  const AlwaysScrollableScrollPhysics(),

              padding: const EdgeInsets.all(16),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  const Text(

                    'Construction Intelligence',

                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(

                    '${sites.length} active site visits tracked',

                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 24),

                  if (sites.isEmpty)

                    Container(

                      width: double.infinity,

                      padding:
                          const EdgeInsets.all(32),

                      decoration: BoxDecoration(

                        color: Colors.white,

                        borderRadius:
                            BorderRadius.circular(24),
                      ),

                      child: Column(

                        children: [

                          Icon(
                            Icons.location_city,
                            size: 64,
                            color: Colors.grey.shade500,
                          ),

                          const SizedBox(height: 16),

                          const Text(

                            'No Site Visits Yet',

                            style: TextStyle(
                              fontSize: 20,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(

                            'Start capturing construction intelligence.',

                            textAlign: TextAlign.center,

                            style: TextStyle(
                              color:
                                  Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    )

                  else

                    ListView.builder(

                      itemCount: sites.length,

                      shrinkWrap: true,

                      physics:
                          const NeverScrollableScrollPhysics(),

                      itemBuilder:
                          (context, index) {

                        final site = sites[index];

                        return Container(

                          margin:
                              const EdgeInsets.only(
                            bottom: 20,
                          ),

                          decoration: BoxDecoration(

                            color: Colors.white,

                            borderRadius:
                                BorderRadius.circular(24),

                            boxShadow: [

                              BoxShadow(

                                color: Colors.black
                                    .withOpacity(0.05),

                                blurRadius: 12,

                                offset:
                                    const Offset(0, 4),
                              ),
                            ],
                          ),

                          child: Column(

                            crossAxisAlignment:
                                CrossAxisAlignment.start,

                            children: [

                              if (site.siteImageUrl != null)

                                ClipRRect(

                                  borderRadius:
                                      const BorderRadius.vertical(
                                    top:
                                        Radius.circular(24),
                                  ),

                                  child: Image.network(

                                    site.siteImageUrl!,

                                    height: 220,

                                    width: double.infinity,

                                    fit: BoxFit.cover,
                                  ),
                                ),

                              Padding(

                                padding:
                                    const EdgeInsets.all(18),

                                child: Column(

                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,

                                  children: [

                                    Row(

                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,

                                      children: [

                                        Expanded(

                                          child: Text(

                                            site.ownerName ?? '-',

                                            style:
                                                const TextStyle(

                                              fontSize: 22,

                                              fontWeight:
                                                  FontWeight.bold,
                                            ),
                                          ),
                                        ),

                                        Container(

                                          padding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),

                                          decoration:
                                              BoxDecoration(

                                            color:
                                                Colors.green.shade100,

                                            borderRadius:
                                                BorderRadius.circular(
                                              50,
                                            ),
                                          ),

                                          child: Text(

                                            'Verified',

                                            style: TextStyle(

                                              color:
                                                  Colors.green.shade800,

                                              fontWeight:
                                                  FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 16),

                                    Row(

                                      children: [

                                        Icon(
                                          Icons.store,
                                          color:
                                              Colors.grey.shade700,
                                        ),

                                        const SizedBox(width: 8),

                                        Expanded(

                                          child: Text(

                                            site.dealerName ?? '-',

                                            style:
                                                const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 12),

                                    Row(

                                      children: [

                                        Icon(
                                          Icons.business,
                                          color:
                                              Colors.grey.shade700,
                                        ),

                                        const SizedBox(width: 8),

                                        Expanded(

                                          child: Text(

                                            site.currentBrandUsing ?? '-',

                                            style:
                                                const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 20),

                                    Row(

                                      children: [

                                        Expanded(

                                          child: ElevatedButton.icon(

                                            onPressed: () async {

                                              if (site.id == null) {
                                                return;
                                              }

                                              await deleteSite(
                                                site.id!,
                                              );
                                            },

                                            icon:
                                                const Icon(Icons.delete),

                                            label:
                                                const Text('Delete'),

                                            style:
                                                ElevatedButton.styleFrom(

                                              backgroundColor:
                                                  Colors.red.shade50,

                                              foregroundColor:
                                                  Colors.red.shade700,

                                              elevation: 0,

                                              shape:
                                                  RoundedRectangleBorder(

                                                borderRadius:
                                                    BorderRadius.circular(
                                                  14,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
  );
}
}