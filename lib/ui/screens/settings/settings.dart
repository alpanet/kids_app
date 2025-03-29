import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kids_app/theme.dart';
import 'package:kids_app/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isNotificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadNotificationPreference();
  }

  void _loadNotificationPreference() async {
    final notificationService = NotificationService();
    bool preference = await notificationService.getNotificationPreference();
    setState(() {
      isNotificationsEnabled = preference;
    });
  }

  void _saveNotificationPreference(bool value) async {
    final notificationService = NotificationService();
    await notificationService.saveNotificationPreference(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.secondBackgoundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_sharp,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        context.router.replaceNamed('mainpage');
                      },
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Ayarlar',
                    textAlign: TextAlign.center,
                    style: AppTheme.generalMenuTitle,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: AppTheme.primaryBackgoundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(0.0),
              child: Stack(
                children: [
                  ListView(
                    children: [
                      const SizedBox(height: 15.0),
                      ListTile(
                        leading: const Icon(Icons.notifications_active_outlined,
                            size: 34.0, color: AppTheme.secondBackgoundColor),
                        title:
                            Text('Bildirimler', style: AppTheme.settingsTitle),
                        trailing: Switch(
                          value: isNotificationsEnabled,
                          activeColor: AppTheme.secondBackgoundColor,
                          onChanged: (value) {
                            setState(() {
                              isNotificationsEnabled = value;
                            });
                            _saveNotificationPreference(value);
                          },
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.star_border_outlined,
                            size: 34.0, color: AppTheme.secondBackgoundColor),
                        title: Text('Uygulamayı Değerlendir',
                            style: AppTheme.settingsTitle),
                      ),
                      ListTile(
                        leading: const Icon(Icons.share_outlined,
                            size: 34.0, color: AppTheme.secondBackgoundColor),
                        title: Text('Uygulamayı Paylaş',
                            style: AppTheme.settingsTitle),
                      ),
                      ListTile(
                        leading: const Icon(Icons.lock_person_outlined,
                            size: 34.0, color: AppTheme.secondBackgoundColor),
                        title: Text('Şartlar ve Koşullar',
                            style: AppTheme.settingsTitle),
                      ),
                      ListTile(
                        leading: const Icon(Icons.mail_outline,
                            size: 34.0, color: AppTheme.secondBackgoundColor),
                        title: Text('İletişim', style: AppTheme.settingsTitle),
                      ),
                      ListTile(
                        leading: const Icon(Icons.logout_outlined,
                            size: 34.0, color: AppTheme.secondBackgoundColor),
                        title: Text('Çıkış Yap', style: AppTheme.settingsTitle),
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.remove('access_token');
                          await prefs.remove('refresh_token');

                          context.router.replaceNamed('login');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
