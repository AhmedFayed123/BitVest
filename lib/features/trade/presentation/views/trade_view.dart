import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TradeScreen extends StatefulWidget {
  const TradeScreen({Key? key}) : super(key: key);

  @override
  _TradeScreenState createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'XRP/USDT',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.candlestick_chart, color: Colors.white, size: 35),
                  onPressed: () {
                  },
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.more_horiz, color: Colors.white, size: 35),
                  onPressed: () {
                  },
                ),
              ],
            ),

          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(6.10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TabBar(
                          controller: _tabController,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Colors.transparent,
                          tabs: [
                            _buildTabBarItem('Buy', Colors.green, 0),
                            _buildTabBarItem('Sell', Colors.red, 1),
                          ],
                        ),
                        const SizedBox(height: 5),
                        _buildDropdown('Limit order'),
                        const SizedBox(height: 7),
                        _buildInputField('Price (USDT)', '0.48'),
                        const SizedBox(height: 7),
                        _buildInputField('Amount (XRP)', '10.1563'),
                        Slider(
                          value: 0,
                          onChanged: (value) {},
                          activeColor: Colors.blue,
                          inactiveColor: Colors.grey,
                        ),
                        _buildInputField('Total (USDT)', '4.8'),
                        const SizedBox(height: 5),
                        _buildInputField('Max Buy', '7.12 XRP'),
                        const SizedBox(height: 7),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              minimumSize: const Size(150, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Buy XRP',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildColumnHeaders('Price \n (TRY)', 'Amount \n(BTC)'),
                        const SizedBox(height: 5),
                        _buildPriceList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Minimum quantity 1 XRP',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  Text(
                    'Save',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.grey),
            _buildOrderDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBarItem(String title, Color color, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _tabController.index = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: _tabController.index == index ? color : Colors.grey[800],
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 10.h),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String value) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 5.w, vertical: 0),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          items: [
            DropdownMenuItem(
              value: value,
              child: Text(
                value,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
          onChanged: (value) {},
          dropdownColor: Colors.grey[900],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildColumnHeaders(String left, String right) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          left,
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
        Text(
          right,
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildPriceList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 12,
      itemBuilder: (context, index) {
        final color = index < 6 ? Colors.red : Colors.green;
        final value = index < 6
            ? '0.5059$index'
            : '0.5058${index - 6}';
        final amount = index < 6
            ? '${(index + 5) * 1.4}K'
            : '${((index - 6) * 5.5) * 3}';
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value, style: TextStyle(color: color, fontSize: 14)),
              Text(amount, style: const TextStyle(color: Colors.white, fontSize: 14)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOrderDetails() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Current symbol',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 5),
          const Text(
            'XRP/USDT',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 5),
          _buildOrderRow('Limit', '6/14, 16:28'),
          _buildOrderRow('Total (XRP)', '19.749327'),
          _buildOrderRow('Filled (XRP)', '0'),
          _buildOrderRow('Order price', '0.53'),
        ],
      ),
    );
  }

  Widget _buildOrderRow(String left, String right) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          left,
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
        Text(
          right,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }
}
