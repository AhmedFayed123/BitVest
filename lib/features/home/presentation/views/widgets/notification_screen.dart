import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/components/widgets/circle_loading.dart';
import '../../../data/models/notifications_model/notifications_response.dart';
import '../../controllers/home_controller/home_controller.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: controller.fetchNotifications,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.notifications.value == null) {
          return const Center(child: CircleLoading());
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return _ErrorBanner(message: controller.errorMessage.value);
        }

        final items = controller.notifications.value?.notifications ?? <NotificationItem>[];
        if (items.isEmpty) {
          return const _EmptyState();
        }

        return RefreshIndicator(
          color: Colors.tealAccent,
          backgroundColor: Colors.grey[900],
          onRefresh: () async => controller.fetchNotifications(),
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(12),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              return _NotificationTile(notification: items[index]);
            },
          ),
        );
      }),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.notification});

  final NotificationItem notification;
  bool get _isUnread => notification.readAt == null;

  @override
  Widget build(BuildContext context) {
    final bgColor = _isUnread ? const Color(0xFF111C20) : const Color(0xFF1C1F24);

    return Material(
      color: bgColor,
      elevation: _isUnread ? 2 : 0,
      borderRadius: BorderRadius.circular(12),
      child: Row(
        children: [
          // neon stripe for unread
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 4,
            height: 70,
            decoration: BoxDecoration(
              color: _isUnread ? Colors.tealAccent : Colors.transparent,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
          ),
          Expanded(
            child: ListTile(
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Icon(
                _isUnread
                    ? Icons.notifications_active_outlined
                    : Icons.notifications_none_outlined,
                color: _isUnread ? Colors.tealAccent : Colors.grey[500],
              ),
              title: Text(
                notification.data?.message ?? '—',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                  fontWeight:
                  _isUnread ? FontWeight.w700 : FontWeight.w400,
                ),
              ),
              subtitle: Text(
                _formattedDate(notification.createdAt),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.grey[400]),
              ),
              trailing: _pnlWidget(notification.data?.pnl),
            ),
          ),
        ],
      ),
    );
  }

  Widget? _pnlWidget(double? pnl) {
    if (pnl == null) return null;
    return Text(
      pnl.toStringAsFixed(2),
      style: TextStyle(
        color: pnl >= 0 ? Colors.greenAccent : Colors.redAccent,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  String _formattedDate(String? utcString) {
    if (utcString == null) return '';
    try {
      final dateTime = DateTime.parse(utcString).toLocal();
      return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')} · '
          '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return utcString;
    }
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.notifications_off_outlined,
              size: 56, color: Colors.grey[600]),
          const SizedBox(height: 12),
          Text('There are no notifications at the moment.',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.grey[400]),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.redAccent),
            ),
          ],
        ),
      ),
    );
  }
}