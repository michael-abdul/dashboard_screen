// lib/presentation/widgets/header/app_header.dart
import 'package:flutter/material.dart';
import 'package:flutter_ui/core/theme/app_color.dart';
import 'package:flutter_ui/core/theme/text_styles.dart';
// AppHeader klassi - asosiy header UI ni yaratadigan klass
class AppHeader extends StatelessWidget {
  const AppHeader({super.key}); // Konstruktor

  @override
  Widget build(BuildContext context) {
    return Container(  // Asosiy container - headerning asosi
      height: 70,     // Header balandligi 70px
      padding: const EdgeInsets.symmetric(horizontal: 24),  // Chapdan va o'ngdan 24px padding
      decoration: BoxDecoration(  // Container dekoratsiyasi
        color: AppColors.cardBackground,  // Orqa fon rangi
        border: Border(  // Pastki chiziq
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.2),  // Pastki chiziq rangi
          ),
        ),
        boxShadow: [  // Soya effekti
          BoxShadow(
            color: Colors.black.withOpacity(0.1),  // Soya rangi
            blurRadius: 4,  // Soya blur effekti
            offset: const Offset(0, 2),  // Soya pozitsiyasi
          ),
        ],
      ),
      child: Row(  // Barcha elementlarni gorizontal joylashtirish
        crossAxisAlignment: CrossAxisAlignment.center,  // Vertikalda markazga to'g'rilash
        children: [
          const Text('Dashboard', style: TextStyles.heading2),  // Dashboard yozuvi
          const SizedBox(width: 40),  // 40px bo'sh joy
          
          _buildSearchBar(),  // Qidiruv maydoni - pastda yaratilgan metoddan chaqiriladi
          _buildActionButtons(),  // Action tugmalar - bildirishnomalar va xabarlar
          _buildProfileMenu(),  // Profil menu - pastda yaratilgan metoddan chaqiriladi
        ],
      ),
    );
  }

  // Qidiruv maydonini yaratuvchi metod
  Widget _buildSearchBar() {
    return Expanded(  // Bo'sh joyni egallaydi
      child: Container(
        height: 40,  // Qidiruv maydoni balandligi
        constraints: const BoxConstraints(maxWidth: 500),  // Maksimal kenglik 500px
        decoration: BoxDecoration(  // Qidiruv maydoni dekoratsiyasi
          color: AppColors.background,  // Orqa fon
          borderRadius: BorderRadius.circular(8),  // Burchaklar radiusi
          border: Border.all(color: Colors.grey.withOpacity(0.2)),  // Chegarasi
        ),
        child: TextField(  // Qidiruv uchun text maydoni
          decoration: InputDecoration(  // TextField dekoratsiyasi
            hintText: 'Search...',  // Placeholder text
            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
            prefixIcon: Icon(Icons.search_rounded, color: Colors.grey[400], size: 20),
            border: InputBorder.none,  // Chegarani o'chirish
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          style: const TextStyle(color: Colors.white, fontSize: 14),  // Kiritilgan text stili
          cursorColor: AppColors.primary,  // Kursor rangi
          onChanged: (value) {}, // Qidiruv funksiyasi
        ),
      ),
    );
  }

  // Action tugmalarni yaratuvchi metod
  Widget _buildActionButtons() {
    return Row(  // Tugmalarni gorizontal joylashtirish
      children: [
        const SizedBox(width: 24),  // Oraliq masofa
        _buildNotificationButton(  // Bildirishnomalar tugmasi
          icon: Icons.notifications_none_rounded,
          badge: '3',  // Badge qiymati
          onTap: () {},  // Bosilgandagi funksiya
        ),
        const SizedBox(width: 16),
        _buildNotificationButton(  // Xabarlar tugmasi
          icon: Icons.email_outlined,
          badge: '5',
          onTap: () {},
        ),
        const SizedBox(width: 24),
      ],
    );
  }

  // Notification tugmasini yaratuvchi metod
  Widget _buildNotificationButton({
    required IconData icon,
    required String badge,
    required VoidCallback onTap,
  }) {
    return Material(  // Material widget inkwell effekti uchun
      color: Colors.transparent,
      child: InkWell(  // Bosish effekti
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Stack(  // Icon va badge ustma-ust joylashtirish
          children: [
            Container(  // Icon container
              width: 40,
              height: 40,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Icon(icon, color: Colors.grey[400], size: 22),
            ),
            if (badge.isNotEmpty)  // Badge bo'sh bo'lmasa ko'rsatiladi
              Positioned(  // Badge pozitsiyasi
                right: 4,
                top: 4,
                child: Container(  // Badge container
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.error,  // Badge rangi
                    shape: BoxShape.circle,  // Doira shakli
                    border: Border.all(color: AppColors.cardBackground, width: 2),
                  ),
                  child: Text(  // Badge raqami
                    badge,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Profil menusini yaratuvchi metod
  Widget _buildProfileMenu() {
    return PopupMenuButton<String>(  // Popup menu
      offset: const Offset(0, 56),  // Menu pozitsiyasi
      position: PopupMenuPosition.under,  // Menu pozitsiyasi
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.cardBackground,  // Menu orqa foni
      child: Container(  // Profile button
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        child: Row(  // Profile ma'lumotlari
          children: [
            CircleAvatar(  // Profil rasmi
              radius: 18,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: const Text(
                'JD',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(  // Ism va rol
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'John Doe',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Administrator',
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey[400], size: 20),
          ],
        ),
      ),
      itemBuilder: (context) => <PopupMenuEntry<String>>[  // Menu elementlari
        _buildPopupMenuItem('profile', Icons.person_outline_rounded, 'My Profile'),
        _buildPopupMenuItem('settings', Icons.settings_outlined, 'Settings'),
        _buildPopupMenuItem('help', Icons.help_outline_rounded, 'Help Center'),
        const PopupMenuDivider(height: 0.5),  // Ajratuvchi chiziq
        _buildPopupMenuItem('logout', Icons.logout_rounded, 'Log Out', isDestructive: true),
      ],
      onSelected: (value) {  // Menu element tanlanganda
        switch (value) {
          case 'profile': // Profile bosilganda
            break;
          case 'settings': // Settings bosilganda
            break;
          case 'help': // Help bosilganda
            break;
          case 'logout': // Logout bosilganda
            break;
        }
      },
    );
  }

  // Menu elementini yaratuvchi metod
  PopupMenuItem<String> _buildPopupMenuItem(
    String value,
    IconData icon,
    String title, {
    bool isDestructive = false,  // Logout uchun qizil rang
  }) {
    return PopupMenuItem<String>(  // Menu elementi
      value: value,
      height: 40,
      child: Row(
        children: [
          Icon(  // Menu element ikonkasi
            icon,
            size: 20,
            color: isDestructive ? AppColors.error : Colors.grey[400],
          ),
          const SizedBox(width: 12),
          Text(  // Menu element texti
            title,
            style: TextStyle(
              color: isDestructive ? AppColors.error : Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}