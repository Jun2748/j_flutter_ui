import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class RatingBarDemo extends StatefulWidget {
  const RatingBarDemo({super.key});

  String get title => 'Rating Bar';

  @override
  State<RatingBarDemo> createState() => _RatingBarDemoState();
}

class _RatingBarDemoState extends State<RatingBarDemo> {
  double _rating = 3.5;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: widget.title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          SimpleText.sectionLabel(text: 'FULL, HALF, EMPTY STARS'),
          JGaps.h8,
          SimpleCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                SimpleRatingBar(rating: 5.0, reviewCount: 99),
                JGaps.h8,
                SimpleRatingBar(rating: 4.5, reviewCount: 213),
                JGaps.h8,
                SimpleRatingBar(rating: 3.0),
                JGaps.h8,
                SimpleRatingBar(rating: 1.5),
                JGaps.h8,
                SimpleRatingBar(rating: 0.0),
              ],
            ),
          ),
          JGaps.h16,
          SimpleText.sectionLabel(text: 'INTERACTIVE'),
          JGaps.h8,
          SimpleCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SimpleRatingBar(rating: _rating, reviewCount: 42),
                JGaps.h16,
                Slider(
                  value: _rating,
                  min: 0,
                  max: 5,
                  divisions: 10,
                  label: _rating.toStringAsFixed(1),
                  onChanged: (double v) => setState(() => _rating = v),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
