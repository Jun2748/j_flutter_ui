import 'package:flutter/material.dart';

abstract final class JDimens {
  const JDimens._();

  static const double dp0 = 0;
  static const double dp1 = 1;
  static const double dp1_5 = 1.5;
  static const double dp2 = 2;
  static const double dp3 = 3;
  static const double dp4 = 4;
  static const double dp6 = 6;
  static const double dp8 = 8;
  static const double dp10 = 10;
  static const double dp12 = 12;
  static const double dp14 = 14;
  static const double dp16 = 16;
  static const double dp18 = 18;
  static const double dp20 = 20;
  static const double dp24 = 24;
  static const double dp28 = 28;
  static const double dp32 = 32;
  static const double dp36 = 36;
  static const double dp40 = 40;
  static const double dp44 = 44;
  static const double dp48 = 48;
  static const double dp52 = 52;
  static const double dp56 = 56;
  static const double dp60 = 60;
  static const double dp64 = 64;
  static const double dp72 = 72;
  static const double dp80 = 80;
  static const double dp96 = 96;
  static const double dp100 = 100;
  static const double dp120 = 120;
  static const double dp140 = 140;
  static const double dp160 = 160;
  static const double dp180 = 180;
  static const double dp200 = 200;
  static const double dp240 = 240;
  static const double dp260 = 260;
}

abstract final class JGaps {
  const JGaps._();

  static const SizedBox h2 = SizedBox(height: JDimens.dp2);
  static const SizedBox h4 = SizedBox(height: JDimens.dp4);
  static const SizedBox h6 = SizedBox(height: JDimens.dp6);
  static const SizedBox h8 = SizedBox(height: JDimens.dp8);
  static const SizedBox h12 = SizedBox(height: JDimens.dp12);
  static const SizedBox h16 = SizedBox(height: JDimens.dp16);
  static const SizedBox h20 = SizedBox(height: JDimens.dp20);
  static const SizedBox h24 = SizedBox(height: JDimens.dp24);
  static const SizedBox h32 = SizedBox(height: JDimens.dp32);
  static const SizedBox h40 = SizedBox(height: JDimens.dp40);
  static const SizedBox h48 = SizedBox(height: JDimens.dp48);

  static const SizedBox w2 = SizedBox(width: JDimens.dp2);
  static const SizedBox w4 = SizedBox(width: JDimens.dp4);
  static const SizedBox w6 = SizedBox(width: JDimens.dp6);
  static const SizedBox w8 = SizedBox(width: JDimens.dp8);
  static const SizedBox w12 = SizedBox(width: JDimens.dp12);
  static const SizedBox w16 = SizedBox(width: JDimens.dp16);
  static const SizedBox w20 = SizedBox(width: JDimens.dp20);
  static const SizedBox w24 = SizedBox(width: JDimens.dp24);
  static const SizedBox w32 = SizedBox(width: JDimens.dp32);
  static const SizedBox w40 = SizedBox(width: JDimens.dp40);
  static const SizedBox w48 = SizedBox(width: JDimens.dp48);
}

abstract final class JFontSizes {
  const JFontSizes._();

  static const double fs10 = JDimens.dp10;
  static const double fs12 = JDimens.dp12;
  static const double fs14 = JDimens.dp14;
  static const double fs16 = JDimens.dp16;
  static const double fs18 = JDimens.dp18;
  static const double fs20 = JDimens.dp20;
  static const double fs24 = JDimens.dp24;
  static const double fs28 = JDimens.dp28;
  static const double fs32 = JDimens.dp32;
}

abstract final class JLineHeights {
  const JLineHeights._();

  static const double lh14 = JDimens.dp14;
  static const double lh16 = JDimens.dp16;
  static const double lh18 = JDimens.dp18;
  static const double lh20 = JDimens.dp20;
  static const double lh24 = JDimens.dp24;
  static const double lh28 = JDimens.dp28;
  static const double lh32 = JDimens.dp32;
  static const double lh40 = JDimens.dp40;
}

abstract final class JIconSizes {
  const JIconSizes._();

  static const double xxs = JDimens.dp8;
  static const double xs = JDimens.dp12;
  static const double sm = JDimens.dp16;
  static const double md = JDimens.dp20;
  static const double lg = JDimens.dp24;
  static const double xl = JDimens.dp32;
  static const double xxl = JDimens.dp40;
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
  static const EdgeInsets all32 = EdgeInsets.all(JDimens.dp32);

  static const EdgeInsets horizontal4 = EdgeInsets.symmetric(
    horizontal: JDimens.dp4,
  );
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
  static const EdgeInsets horizontal32 = EdgeInsets.symmetric(
    horizontal: JDimens.dp32,
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
  static const EdgeInsets vertical32 = EdgeInsets.symmetric(
    vertical: JDimens.dp32,
  );

  static const EdgeInsets horizontal8Vertical4 = EdgeInsets.symmetric(
    horizontal: JDimens.dp8,
    vertical: JDimens.dp4,
  );
  static const EdgeInsets horizontal16Vertical8 = EdgeInsets.symmetric(
    horizontal: JDimens.dp16,
    vertical: JDimens.dp8,
  );
  static const EdgeInsets horizontal16Vertical12 = EdgeInsets.symmetric(
    horizontal: JDimens.dp16,
    vertical: JDimens.dp12,
  );
  static const EdgeInsets horizontal12Vertical8 = EdgeInsets.symmetric(
    horizontal: JDimens.dp12,
    vertical: JDimens.dp8,
  );
  static const EdgeInsets horizontal16Vertical14 = EdgeInsets.symmetric(
    horizontal: JDimens.dp16,
    vertical: JDimens.dp14,
  );
  static const EdgeInsets horizontal12Vertical16 = EdgeInsets.symmetric(
    horizontal: JDimens.dp12,
    vertical: JDimens.dp16,
  );
  static const EdgeInsets horizontal24Vertical16 = EdgeInsets.symmetric(
    horizontal: JDimens.dp24,
    vertical: JDimens.dp16,
  );
  static const EdgeInsets screen = EdgeInsets.all(JDimens.dp16);
  static const EdgeInsets screenPadding = screen;
  static const EdgeInsets card = EdgeInsets.all(JDimens.dp16);

  static const EdgeInsets onlyTop8 = EdgeInsets.only(top: JDimens.dp8);
  static const EdgeInsets onlyTop16 = EdgeInsets.only(top: JDimens.dp16);
  static const EdgeInsets onlyTop24 = EdgeInsets.only(top: JDimens.dp24);
  static const EdgeInsets onlyBottom8 = EdgeInsets.only(bottom: JDimens.dp8);
  static const EdgeInsets onlyBottom16 = EdgeInsets.only(bottom: JDimens.dp16);
  static const EdgeInsets onlyBottom24 = EdgeInsets.only(bottom: JDimens.dp24);

  /// RTL-safe leading-edge-only padding. Use for the first item in a
  /// horizontal scroll list or any start-anchored layout.
  static const EdgeInsetsDirectional onlyStart8 = EdgeInsetsDirectional.only(
    start: JDimens.dp8,
  );
  static const EdgeInsetsDirectional onlyStart12 = EdgeInsetsDirectional.only(
    start: JDimens.dp12,
  );
  static const EdgeInsetsDirectional onlyStart16 = EdgeInsetsDirectional.only(
    start: JDimens.dp16,
  );
  static const EdgeInsetsDirectional onlyStart20 = EdgeInsetsDirectional.only(
    start: JDimens.dp20,
  );
  static const EdgeInsetsDirectional onlyStart24 = EdgeInsetsDirectional.only(
    start: JDimens.dp24,
  );

  /// RTL-safe trailing-edge-only padding. Use for the last item in a
  /// horizontal scroll list or any end-anchored layout.
  static const EdgeInsetsDirectional onlyEnd8 = EdgeInsetsDirectional.only(
    end: JDimens.dp8,
  );
  static const EdgeInsetsDirectional onlyEnd12 = EdgeInsetsDirectional.only(
    end: JDimens.dp12,
  );
  static const EdgeInsetsDirectional onlyEnd16 = EdgeInsetsDirectional.only(
    end: JDimens.dp16,
  );
  static const EdgeInsetsDirectional onlyEnd20 = EdgeInsetsDirectional.only(
    end: JDimens.dp20,
  );
  static const EdgeInsetsDirectional onlyEnd24 = EdgeInsetsDirectional.only(
    end: JDimens.dp24,
  );
}

abstract final class JHeights {
  const JHeights._();

  static const double appBar = JDimens.dp56;
  static const double button = JDimens.dp48;
  static const double buttonSmall = JDimens.dp32;
  static const double input = JDimens.dp52;
  static const double listItem = JDimens.dp56;
  static const double tabBar = JDimens.dp48;
  static const double badge = JDimens.dp20;
  static const double chip = JDimens.dp32;
  static const double menuTile = JDimens.dp72;
  static const double railItem = JDimens.dp72;
  static const double bottomNav = JDimens.dp56;
  static const double bottomBar = JDimens.dp64;
  static const double searchBar = JDimens.dp44;
  static const double cardMin = JDimens.dp120;
  static const double promoBanner = JDimens.dp180;
  static const double productCard = JDimens.dp200;
}
