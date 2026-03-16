import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class FlagDemo extends StatelessWidget {
  const FlagDemo({super.key});

  String get title => 'Flag';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: title),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SimpleFlag.countryCode(CountryCodes.my, size: 36),
            JGaps.h8,
            Text('Malaysia (country code)'),
            JGaps.h24,
            SimpleFlag.asset(Flags.singapore, size: 36),
            JGaps.h8,
            Text('Singapore (asset)'),
            JGaps.h24,
            _CurrencyFlagExample(),
          ],
        ),
      ),
    );
  }
}

class _CurrencyFlagExample extends StatelessWidget {
  const _CurrencyFlagExample();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FlagUtils.flagByCurrency(CurrencyCodes.usd, size: 36),
        JGaps.h8,
        const Text('USA (currency mapping)'),
      ],
    );
  }
}
