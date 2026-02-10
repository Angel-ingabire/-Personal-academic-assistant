import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/alu_card.dart';

/// Announcements screen – list of announcement cards (title + description).
class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({super.key});

  static List<AnnouncementItem> get _sampleAnnouncements => [
        const AnnouncementItem(
          title: 'Reminder: Project Deadlines',
          description:
              'Department of Software Engineering: Reminder that deliverable deadlines are approaching. Please submit before the due date.',
        ),
        const AnnouncementItem(
          title: 'Upcoming Industry Talk',
          description:
              'Join us for an industry talk. Please ensure your coursework is up to date before attending.',
        ),
        const AnnouncementItem(
          title: 'Update for All Students',
          description:
              'See additional online resources for assistance in your coursework.',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text('Announcements'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.fromLTRB(
          16,
          8,
          16,
          MediaQuery.paddingOf(context).bottom + 80,
        ),
        itemCount: _sampleAnnouncements.length,
        itemBuilder: (context, index) {
          final item = _sampleAnnouncements[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AluCard(
              onTap: () => _onAnnouncementTap(context, item),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      color: AppColors.textDark,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.description,
                    style: const TextStyle(
                      color: AppColors.textDark,
                      fontSize: 14,
                      height: 1.4,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onAnnouncementTap(BuildContext context, AnnouncementItem item) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: const TextStyle(
                color: AppColors.textDark,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              item.description,
              style: const TextStyle(
                color: AppColors.textDark,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            SizedBox(height: MediaQuery.paddingOf(context).bottom + 16),
          ],
        ),
      ),
    );
  }
}

class AnnouncementItem {
  const AnnouncementItem({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;
}
