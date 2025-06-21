import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../data/models/edit/edit_request/Edit_request.dart';
import '../../controller/p2p_controller.dart';

class MyAdsScreen extends StatelessWidget {
  MyAdsScreen({super.key});

  final RxBool showAllBuy = false.obs;
  final RxBool showAllSell = false.obs;

  @override
  Widget build(BuildContext context) {
    final P2pController controller = Get.put(P2pController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Ads'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.userBuyAds.isEmpty && controller.userSellAds.isEmpty) {
          return const Center(
            child: Text(
              'No ads available.',
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(title: 'Buy Ads'),
              const SizedBox(height: 12),
              AdsList(
                ads: showAllBuy.value
                    ? controller.userBuyAds
                    : controller.userBuyAds.take(4).toList(),
              ),
              if (controller.userBuyAds.length > 4)
                TextButton(
                  onPressed: () {
                    showAllBuy.value = !showAllBuy.value;
                  },
                  child: Text(
                    showAllBuy.value ? 'Show Less' : 'Show More',
                    style: const TextStyle(color: Colors.blueAccent),
                  ),
                ),
              const SizedBox(height: 40),
              const SectionTitle(title: 'Sell Ads'),
              const SizedBox(height: 12),
              AdsList(
                ads: showAllSell.value
                    ? controller.userSellAds
                    : controller.userSellAds.take(4).toList(),
              ),
              if (controller.userSellAds.length > 4)
                TextButton(
                  onPressed: () {
                    showAllSell.value = !showAllSell.value;
                  },
                  child: Text(
                    showAllSell.value ? 'Show Less' : 'Show More',
                    style: const TextStyle(color: Colors.blueAccent),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 1.1,
      ),
    );
  }
}

class AdsList extends StatelessWidget {
  final List ads;
  const AdsList({required this.ads, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: ads.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final ad = ads[index];
        return Dismissible(
          key: ValueKey(ad.id),

          // الاتجاهات المسموحة للسحب
          direction: DismissDirection.horizontal,

          // مؤشر السحب يمين (للحذف)
          background: Container(
            color: Colors.redAccent,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),

          // مؤشر السحب شمال (للتعديل)
          secondaryBackground: Container(
            color: Colors.blueAccent,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.edit, color: Colors.white),
          ),

          // دالة عند اكتمال السحب
          onDismissed: (direction) {
            final P2pController controller = Get.put(P2pController());
            if (direction == DismissDirection.startToEnd) {
              if (ad.tradeType.toLowerCase() == 'buy') {
                controller.deleteBuyAd(ad.id);
              } else if (ad.tradeType.toLowerCase() == 'sell') {
                controller.deleteSellAd(ad.id);
              }
            }
            else if (direction == DismissDirection.endToStart) {
              // سحب شمال => تعديل
              _showEditDialog(context, ad);
              // بما إننا لم نحذف العنصر، لازم نعيده للعرض لأنه Dismissible يزيله تلقائيًا
              // لذا تحتاج تعمل استرجاع أو تستخدم طريقة مختلفة (مثل عدم إزالة العنصر عند تعديل)
            }
          },

          // لمنع إزالة العنصر عند السحب شمال (تعديل)
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.endToStart) {
              // لا نمسح العنصر عند السحب شمال (تعديل)
              _showEditDialog(context, ad);
              return false; // لمنع الحذف التلقائي
            }
            return true; // السماح بالحذف عند السحب يمين
          },

          child: Card(
            color: Colors.grey[850],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            shadowColor: Colors.blueAccent.withOpacity(0.3),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              title: Text(
                '${ad.currency} - ${ad.amount}',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                'Price: ${ad.fiatAmount} ${ad.fiatCurrency}\nPayment: ${ad.paymentMethod}',
                style: const TextStyle(color: Colors.white70, fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: _getStatusColor(ad.transferStatus),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  (ad.transferStatus ?? '').toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'in_progress':
        return Colors.blueAccent;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }
}

void _showEditDialog(BuildContext context, ad) {
  final currencyController = TextEditingController(text: ad.currency);
  final amountController = TextEditingController(text: ad.amount.toString());
  final fiatAmountController = TextEditingController(text: ad.fiatAmount.toString());
  final fiatCurrencyController = TextEditingController(text: ad.fiatCurrency);
  final paymentMethodController = TextEditingController(text: ad.paymentMethod);
  final paymentDetailsController = TextEditingController(text: ad.paymentDetails);

  final P2pController controller = Get.find();

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text(
        'Edit Ad',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextField(controller: currencyController, label: 'Currency'),
            SizedBox(height: 10),
            _buildTextField(controller: amountController, label: 'Amount', keyboardType: TextInputType.number),
            SizedBox(height: 10),
            _buildTextField(controller: fiatAmountController, label: 'Fiat Amount', keyboardType: TextInputType.number),
            SizedBox(height: 10),
            _buildTextField(controller: fiatCurrencyController, label: 'Fiat Currency'),
            SizedBox(height: 10),
            _buildTextField(controller: paymentMethodController, label: 'Payment Method'),
            SizedBox(height: 10),
            _buildTextField(controller: paymentDetailsController, label: 'Payment Details', maxLines: 2),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Update', style: TextStyle(fontSize: 16)),
          onPressed: () async {
            try {
              final editRequest = EditRequest(
                id: ad.id,
                currency: currencyController.text.trim().isEmpty ? ad.currency : currencyController.text.trim(),
                amount: amountController.text.trim().isEmpty
                    ? ad.amount
                    : double.parse(amountController.text.trim()),
                fiatAmount: fiatAmountController.text.trim().isEmpty
                    ? ad.fiatAmount
                    : double.parse(fiatAmountController.text.trim()),
                fiatCurrency: fiatCurrencyController.text.trim().isEmpty ? ad.fiatCurrency : fiatCurrencyController.text.trim(),
                paymentMethod: paymentMethodController.text.trim().isEmpty ? ad.paymentMethod : paymentMethodController.text.trim(),
                paymentDetails: paymentDetailsController.text.trim().isEmpty ? ad.paymentDetails : paymentDetailsController.text.trim(),
              );

              Navigator.pop(context);

              bool success = false;
              if (ad.tradeType.toLowerCase() == 'buy') {
                success = await controller.editBuyAd(editRequest);
              } else if (ad.tradeType.toLowerCase() == 'sell') {
                success = await controller.editSellAd(editRequest);
              }

              if (success) {
                Get.snackbar(
                  'Success',
                  'Ad updated successfully.',
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                );
              } else {
                Get.snackbar(
                  'Error',
                  'Failed to update ad.',
                  backgroundColor: Colors.redAccent,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            } catch (e) {
              Navigator.pop(context);
              Get.snackbar(
                'Error',
                'An error occurred: $e',
                backgroundColor: Colors.red,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          },
        ),
      ],
    ),
  );
}

Widget _buildTextField({
  required TextEditingController controller,
  required String label,
  TextInputType keyboardType = TextInputType.text,
  int maxLines = 1,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    maxLines: maxLines,
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    ),
    style: const TextStyle(fontSize: 16),
  );
}
