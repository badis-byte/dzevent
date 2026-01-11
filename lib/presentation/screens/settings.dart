import 'package:dzevent/logic/cubits/auth/auth_cubit.dart';
import 'package:dzevent/logic/cubits/auth/auth_states.dart';
import 'package:dzevent/logic/cubits/theme/theme_cubit.dart';
import 'package:dzevent/logic/cubits/theme/theme_state.dart';
import 'package:dzevent/presentation/screens/my_account_credentials.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => const SettingsPage());

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _pushNotifications = true;
  bool _newEventAlerts = true;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [primary, primary.withOpacity(0.7)],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // General Section
                  _buildSectionTitle('General'),
                  const SizedBox(height: 12),
                  _buildSettingItem(
                    icon: Icons.light_mode,
                    title: 'Light Mode',
                    subtitle: 'Toggle between light and dark themes',
                    trailing: _buildLightModeToggle(),
                    onTap: null,
                  ),
                  const SizedBox(height: 8),
                  _buildSettingItem(
                    icon: Icons.language,
                    title: 'Language',
                    subtitle: 'English',
                    trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                    onTap: () {
                      // TODO: Navigate to language selection
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Language selection coming soon')),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildSettingItem(
                    icon: Icons.person_outline,
                    title: 'Manage Account',
                    subtitle: 'Profile, password, and security',
                    trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                    onTap: () {
                      final accountState = context.read<AccountCubit>().state;
                      if (accountState is UserFetched) {
                        Navigator.push(context, Myaccountcredentials.route());
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please log in to manage your account')),
                        );
                      }
                    },
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Notifications Section
                  _buildSectionTitle('Notifications'),
                  const SizedBox(height: 12),
                  _buildSettingItem(
                    icon: Icons.notifications_outlined,
                    title: 'Push Notifications',
                    subtitle: 'Receive alerts for important updates',
                    trailing: Switch(
                      value: _pushNotifications,
                      onChanged: (value) {
                        setState(() {
                          _pushNotifications = value;
                        });
                      },
                      activeThumbColor: primary,
                    ),
                    onTap: null,
                  ),
                  const SizedBox(height: 8),
                  _buildSettingItem(
                    icon: Icons.campaign_outlined,
                    title: 'New Event Alerts',
                    subtitle: 'Notify me about new events',
                    trailing: Switch(
                      value: _newEventAlerts,
                      onChanged: (value) {
                        setState(() {
                          _newEventAlerts = value;
                        });
                      },
                      activeThumbColor: primary,
                    ),
                    onTap: null,
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Privacy Section
                  _buildSectionTitle('Privacy'),
                  const SizedBox(height: 12),
                  _buildSettingItem(
                    icon: Icons.visibility_outlined,
                    title: 'Who can see my profile',
                    subtitle: 'Everyone',
                    trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                    onTap: () {
                      // TODO: Navigate to privacy settings
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Privacy settings coming soon')),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildSettingItem(
                    icon: Icons.block_outlined,
                    title: 'Manage blocked users',
                    subtitle: "View and manage users you've blocked",
                    trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                    onTap: () {
                      // TODO: Navigate to blocked users
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Blocked users management coming soon')),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Data Section
                  _buildSectionTitle('Data'),
                  const SizedBox(height: 12),
                  _buildSettingItem(
                    icon: Icons.download_outlined,
                    title: 'Export my data',
                    subtitle: 'Download a copy of your personal data',
                    trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                    onTap: () {
                      // TODO: Implement data export
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Data export coming soon')),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildSettingItem(
                    icon: Icons.delete_outline,
                    title: 'Delete account',
                    subtitle: 'Permanently delete your account',
                    trailing: const Icon(Icons.chevron_right, color: Colors.red),
                    titleColor: Colors.red,
                    iconColor: Colors.red,
                    onTap: () {
                      // TODO: Implement account deletion
                      _showDeleteAccountDialog();
                    },
                  ),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurface,
        letterSpacing: 0.3,
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
    VoidCallback? onTap,
    Color? titleColor,
    Color? iconColor,
  }) {
    final defaultIconColor = iconColor ?? Theme.of(context).colorScheme.primary;
    final defaultTitleColor = titleColor ?? Theme.of(context).colorScheme.onSurface;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: defaultIconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: defaultIconColor,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: defaultTitleColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                trailing,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLightModeToggle() {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final isDark = state is ThemeDark;
        final primary = Theme.of(context).colorScheme.primary;
        
        // Switch OFF = Light mode active, Switch ON = Dark mode active
        return Switch(
          value: isDark,
          onChanged: (value) {
            context.read<ThemeCubit>().setTheme(value);
          },
          activeThumbColor: primary,
        );
      },
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text(
            'Are you sure you want to delete your account? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // TODO: Implement account deletion
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Account deletion coming soon')),
                );
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
