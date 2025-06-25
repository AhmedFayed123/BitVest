import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controller/p2p_controller.dart';
import '../../../data/models/edit/edit_request/Edit_request.dart';

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
                  onPressed: () => showAllBuy.value = !showAllBuy.value,
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
                  onPressed: () => showAllSell.value = !showAllSell.value,
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
          direction: DismissDirection.horizontal,
          background: Container(
            decoration: BoxDecoration(
              color: Colors.red.shade700,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20),
            child: const Icon(Icons.delete, color: Colors.white, size: 28),
          ),
          secondaryBackground: Container(
            decoration: BoxDecoration(
              color: Colors.blueAccent.shade700,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.edit, color: Colors.white, size: 28),
          ),
          onDismissed: (direction) {
            final P2pController controller = Get.put(P2pController());
            if (direction == DismissDirection.startToEnd) {
              if (ad.tradeType.toLowerCase() == 'buy') {
                controller.deleteBuyAd(ad.id);
              } else if (ad.tradeType.toLowerCase() == 'sell') {
                controller.deleteSellAd(ad.id);
              }
            } else if (direction == DismissDirection.endToStart) {
              _showEditDialog(context, ad);
            }
          },
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.endToStart) {
              _showEditDialog(context, ad);
              return false;
            }
            return true;
          },
          child: Card(
            color: const Color(0xFF1E1E1E),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 6,
            shadowColor: Colors.black.withOpacity(0.2),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              title: Text(
                '${ad.currency.toUpperCase()} - ${ad.amount}',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price: ${ad.fiatAmount} ${ad.fiatCurrency}',
                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Payment: ${ad.paymentMethod}',
                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: _getStatusColor(ad.transferStatus),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  (ad.transferStatus ?? '').toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
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

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.grey[900],
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Edit Ad',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 20),

            _buildDarkTextField(controller: currencyController, label: 'Currency'),
            const SizedBox(height: 10),
            _buildDarkTextField(
              controller: amountController,
              label: 'Amount',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            _buildDarkTextField(
              controller: fiatAmountController,
              label: 'Fiat Amount',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            _buildDarkTextField(controller: fiatCurrencyController, label: 'Fiat Currency'),
            const SizedBox(height: 10),
            _buildDarkTextField(controller: paymentMethodController, label: 'Payment Method'),
            const SizedBox(height: 10),
            _buildDarkTextField(
              controller: paymentDetailsController,
              label: 'Payment Details',
              maxLines: 2,
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () async {
                try {
                  final editRequest = EditRequest(
                    id: ad.id,
                    currency: currencyController.text.trim().isEmpty
                        ? ad.currency
                        : currencyController.text.trim(),
                    amount: amountController.text.trim().isEmpty
                        ? ad.amount
                        : double.parse(amountController.text.trim()),
                    fiatAmount: fiatAmountController.text.trim().isEmpty
                        ? ad.fiatAmount
                        : double.parse(fiatAmountController.text.trim()),
                    fiatCurrency: fiatCurrencyController.text.trim().isEmpty
                        ? ad.fiatCurrency
                        : fiatCurrencyController.text.trim(),
                    paymentMethod: paymentMethodController.text.trim().isEmpty
                        ? ad.paymentMethod
                        : paymentMethodController.text.trim(),
                    paymentDetails: paymentDetailsController.text.trim().isEmpty
                        ? ad.paymentDetails
                        : paymentDetailsController.text.trim(),
                  );

                  Navigator.pop(context);

                  bool success = false;
                  if (ad.tradeType.toLowerCase() == 'buy') {
                    success = await controller.editBuyAd(editRequest);
                  } else {
                    success = await controller.editSellAd(editRequest);
                  }

                  Get.snackbar(
                    success ? 'Success' : 'Error',
                    success ? 'Ad updated successfully.' : 'Failed to update ad.',
                    backgroundColor: success ? Colors.green : Colors.redAccent,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                  );
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
              child: const Text('Update', style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    ),
  );
}

Widget _buildDarkTextField({
  required TextEditingController controller,
  required String label,
  TextInputType keyboardType = TextInputType.text,
  int maxLines = 1,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    maxLines: maxLines,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.grey[400]),
      filled: true,
      fillColor: Colors.grey[850],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.blueAccent),
      ),
    ),
  );
}

