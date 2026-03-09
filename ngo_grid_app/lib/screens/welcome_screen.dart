import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await userProvider.loadUser(currentUser.uid);
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWeb = size.width > 900;

    return Scaffold(
      appBar: _buildNavBar(context, isWeb),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(context, size, isWeb),
            _buildFeaturesSection(context, isWeb),
            _buildAboutSection(context, isWeb),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildNavBar(BuildContext context, bool isWeb) {
    return AppBar(
      title: Row(
        children: [
          const Icon(Icons.grid_view_rounded, color: Color(0xFF2E7D32)),
          const SizedBox(width: 8),
          const Text("NGOGrid", style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0.5)),
        ],
      ),
      actions: isWeb 
        ? [
            TextButton(onPressed: () {}, child: const Text("Features")),
            TextButton(onPressed: () {}, child: const Text("About")),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/login'),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
              child: const Text("LOGIN"),
            ),
            const SizedBox(width: 20),
          ]
        : null,
    );
  }

  Widget _buildHeroSection(BuildContext context, Size size, bool isWeb) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: isWeb ? 100 : 60, horizontal: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.green.shade50.withOpacity(0.5), Colors.white],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: isWeb 
            ? Row(
                children: [
                  Expanded(child: _buildHeroText(context)),
                  const SizedBox(width: 48),
                  Expanded(child: _buildHeroImage()),
                ],
              )
            : Column(
                children: [
                  _buildHeroText(context),
                  const SizedBox(height: 48),
                  _buildHeroImage(),
                ],
              ),
        ),
      ),
    );
  }

  Widget _buildHeroText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Empower Your NGO,\nStreamline Coordination.",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 24),
        Text(
          "NGOGrid is a powerful, real-time platform designed to help NGOs manage volunteers, track relief tasks, and ensure maximum impact during emergency operations.",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 40),
        Row(
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/signup'),
              child: const Text("GET STARTED"),
            ),
            const SizedBox(width: 16),
            OutlinedButton(
              onPressed: () => Navigator.pushNamed(context, '/login'),
              child: const Text("EXPLORE"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeroImage() {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(24),
        image: const DecorationImage(
          image: NetworkImage("https://images.unsplash.com/photo-1593113630400-ea4288922497?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 30, offset: const Offset(0, 20)),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection(BuildContext context, bool isWeb) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Text("Key Features", style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 48),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: isWeb ? 3 : 1,
                crossAxisSpacing: 32,
                mainAxisSpacing: 32,
                childAspectRatio: 1.2,
                children: [
                  _buildFeatureCard(Icons.group_rounded, "Role-Based Access", "Separate dashboards for NGO managers and volunteers."),
                  _buildFeatureCard(Icons.sync_rounded, "Real-time Tracking", "Instant updates on task status and campaign progress."),
                  _buildFeatureCard(Icons.chat_bubble_outline_rounded, "Task Communication", "In-task comments to bridge coordination gaps."),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(IconData icon, String title, String desc) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: const Color(0xFF2E7D32)),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 12),
            Text(desc, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context, bool isWeb) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      color: Colors.grey.shade50,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              Text("Why NGOGrid?", style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 24),
              Text(
                "In emergency relief operations, time is critical. Manual coordination leads to delays and confusion. NGOGrid provides a structured workflow-based system that ensures transparency, accountability, and smooth execution for every relief campaign.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      width: double.infinity,
      color: const Color(0xFF1B5E20),
      child: Column(
        children: [
          const Text("NGOGrid", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text("Empowering Humanity through Coordination", style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 32),
          const Text("© 2026 NGOGrid Platform. All rights reserved.", style: TextStyle(color: Colors.white54, fontSize: 12)),
        ],
      ),
    );
  }
}
