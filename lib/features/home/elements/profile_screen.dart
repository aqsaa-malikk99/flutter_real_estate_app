import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/image_paths.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String urlImage = "https://lh3.googleusercontent.com/pw/AP1GczN3B7jTk9NFtxKIYxJ55eDb8LoOqQ-X1EVomekBgp_-qSWWISdZN-ssNPMT73hHP9rXqqlSyriCDHJxiOmLAsqy2-qPNqvW5dGVMLUtkqvivDfSB64";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColorTransparent,
      appBar: AppBar(
        backgroundColor: kBlackColorTransparent,
        elevation: 0.9,
        foregroundColor: kPrimaryColor,
        title: Text("Profile"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: CachedNetworkImage(
                imageUrl: urlImage,
                errorWidget: (context, url, error) => Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(ImagesPaths.placeHolder),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Marina Smith',
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          Text(
            'Street 3, South Hampton, UK',
            style: TextStyle(
              color: kWhiteColor,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                _buildProfileOption(
                  icon: Icons.settings,
                  title: 'Settings',
                  onTap: () {
                    // Handle settings tap
                  },
                ),
                _buildProfileOption(
                  icon: Icons.person,
                  title: 'Account',
                  onTap: () {
                    // Handle account tap
                  },
                ),
                _buildProfileOption(
                  icon: Icons.notifications,
                  title: 'Notifications',
                  onTap: () {
                    // Handle notifications tap
                  },
                ),
                _buildProfileOption(
                  icon: Icons.security,
                  title: 'Privacy',
                  onTap: () {
                    // Handle privacy tap
                  },
                ),
                _buildProfileOption(
                  icon: Icons.help,
                  title: 'Help & Support',
                  onTap: () {
                    // Handle help & support tap
                  },
                ),
                _buildProfileOption(
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: () {
                    // Handle logout tap
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption({required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: kPrimaryColor),
      title: Text(
        title,
        style: TextStyle(
          color: kWhiteColor,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: kPrimaryColor, size: 16),
      onTap: onTap,
    );
  }
}
