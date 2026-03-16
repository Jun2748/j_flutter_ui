import 'package:flutter/material.dart';

abstract final class JDimens {
  const JDimens._();

  static const double dp0 = 0;
  static const double dp2 = 2;
  static const double dp4 = 4;
  static const double dp8 = 8;
  static const double dp12 = 12;
  static const double dp14 = 14;
  static const double dp16 = 16;
  static const double dp20 = 20;
  static const double dp24 = 24;
  static const double dp28 = 28;
  static const double dp32 = 32;
  static const double dp40 = 40;
  static const double dp48 = 48;
  static const double dp52 = 52;
  static const double dp56 = 56;
  static const double dp64 = 64;
  static const double dp120 = 120;
}

abstract final class JGaps {
  const JGaps._();

  static const SizedBox h4 = SizedBox(height: JDimens.dp4);
  static const SizedBox h8 = SizedBox(height: JDimens.dp8);
  static const SizedBox h12 = SizedBox(height: JDimens.dp12);
  static const SizedBox h16 = SizedBox(height: JDimens.dp16);
  static const SizedBox h20 = SizedBox(height: JDimens.dp20);
  static const SizedBox h24 = SizedBox(height: JDimens.dp24);
  static const SizedBox h32 = SizedBox(height: JDimens.dp32);

  static const SizedBox w4 = SizedBox(width: JDimens.dp4);
  static const SizedBox w8 = SizedBox(width: JDimens.dp8);
  static const SizedBox w12 = SizedBox(width: JDimens.dp12);
  static const SizedBox w16 = SizedBox(width: JDimens.dp16);
  static const SizedBox w20 = SizedBox(width: JDimens.dp20);
  static const SizedBox w24 = SizedBox(width: JDimens.dp24);
  static const SizedBox w32 = SizedBox(width: JDimens.dp32);
}

abstract final class JFontSizes {
  const JFontSizes._();

  static const double fs12 = JDimens.dp12;
  static const double fs14 = JDimens.dp14;
  static const double fs16 = JDimens.dp16;
  static const double fs20 = JDimens.dp20;
  static const double fs24 = JDimens.dp24;
  static const double fs32 = JDimens.dp32;
}

abstract final class JLineHeights {
  const JLineHeights._();

  static const double lh16 = JDimens.dp16;
  static const double lh20 = JDimens.dp20;
  static const double lh24 = JDimens.dp24;
  static const double lh28 = JDimens.dp28;
  static const double lh32 = JDimens.dp32;
  static const double lh40 = JDimens.dp40;
}

abstract final class JIconSizes {
  const JIconSizes._();

  static const double xs = JDimens.dp12;
  static const double sm = JDimens.dp16;
  static const double md = JDimens.dp20;
  static const double lg = JDimens.dp24;
  static const double xl = JDimens.dp32;
}

abstract final class JInsets {
  const JInsets._();
  static const EdgeInsets zero = EdgeInsets.only();
  static const EdgeInsets all4 = EdgeInsets.all(JDimens.dp4);
  static const EdgeInsets all8 = EdgeInsets.all(JDimens.dp8);
  static const EdgeInsets all12 = EdgeInsets.all(JDimens.dp12);
  static const EdgeInsets all16 = EdgeInsets.all(JDimens.dp16);
  static const EdgeInsets all20 = EdgeInsets.all(JDimens.dp20);
  static const EdgeInsets all24 = EdgeInsets.all(JDimens.dp24);

  static const EdgeInsets horizontal8 = EdgeInsets.symmetric(
    horizontal: JDimens.dp8,
  );
  static const EdgeInsets horizontal12 = EdgeInsets.symmetric(
    horizontal: JDimens.dp12,
  );
  static const EdgeInsets horizontal16 = EdgeInsets.symmetric(
    horizontal: JDimens.dp16,
  );
  static const EdgeInsets horizontal20 = EdgeInsets.symmetric(
    horizontal: JDimens.dp20,
  );
  static const EdgeInsets horizontal24 = EdgeInsets.symmetric(
    horizontal: JDimens.dp24,
  );

  static const EdgeInsets vertical4 = EdgeInsets.symmetric(
    vertical: JDimens.dp4,
  );
  static const EdgeInsets vertical8 = EdgeInsets.symmetric(
    vertical: JDimens.dp8,
  );
  static const EdgeInsets vertical12 = EdgeInsets.symmetric(
    vertical: JDimens.dp12,
  );
  static const EdgeInsets vertical16 = EdgeInsets.symmetric(
    vertical: JDimens.dp16,
  );
  static const EdgeInsets vertical20 = EdgeInsets.symmetric(
    vertical: JDimens.dp20,
  );
  static const EdgeInsets vertical24 = EdgeInsets.symmetric(
    vertical: JDimens.dp24,
  );

  static const EdgeInsets horizontal16Vertical12 = EdgeInsets.symmetric(
    horizontal: JDimens.dp16,
    vertical: JDimens.dp12,
  );
  static const EdgeInsets screen = EdgeInsets.all(JDimens.dp16);
  static const EdgeInsets screenPadding = screen;
  static const EdgeInsets card = EdgeInsets.all(JDimens.dp16);
}

abstract final class JHeights {
  const JHeights._();

  static const double appBar = JDimens.dp56;
  static const double button = JDimens.dp48;
  static const double input = JDimens.dp52;
  static const double listItem = JDimens.dp56;
  static const double cardMin = JDimens.dp120;
}
