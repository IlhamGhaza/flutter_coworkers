import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_color.dart';

class WalletFragment extends StatefulWidget {
  const WalletFragment({super.key});

  @override
  State<WalletFragment> createState() => _WalletFragmentState();
}

class _WalletFragmentState extends State<WalletFragment> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        SizedBox(
          height: 172,
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: AppColor.bgHeader,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(80),
                  ),
                ),
                margin: const EdgeInsets.only(bottom: 24),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          'wallet'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  DView.height(20),
                ],
              ),
            ],
          ),
        ),
        DView.height(12),
        _balanceCard(context),
        DView.height(20),
        _actions(),
        DView.height(20),
        _transactions(),
        DView.height(),
      ],
    );
  }

  Widget _balanceCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xffE5E7EC).withValues(alpha: 0.3),
            blurRadius: 30,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: const Color(0xffeaeaea)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('current_balance'.tr,
              style: const TextStyle(color: Colors.grey)),
          Text('\$2,540.00',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w700,
                fontSize: 28,
              )),
        ],
        // DView.height(8)
      ),
    );
  }

  Widget _actions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: Text(
                'top_up'.tr,
              ),
            ),
          ),
          DView.width(12),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.arrow_downward),
              label: Text('withdraw'.tr),
            ),
          ),
        ],
      ),
    );
  }

  Widget _transactions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('transactions'.tr,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              )),
        ),
        DView.height(8),
        ...List.generate(10, (index) => _transactionItem(index)),
      ],
    );
  }

  Widget _transactionItem(int i) {
    final isIncome = i % 2 == 0;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: CircleAvatar(
        backgroundColor:
            isIncome ? const Color(0xffD8FFE2) : const Color(0xffFFE7E7),
        child: Icon(
          isIncome ? Icons.south_west : Icons.north_east,
          color: isIncome ? Colors.green : Colors.red,
        ),
      ),
      title: Text(
        isIncome ? 'payment_received'.tr : 'service_payment'.tr,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      subtitle: const Text('24 Aug 2024'),
      trailing: Text(
        isIncome ? '+\$120.00' : '-\$80.00',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: isIncome ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
