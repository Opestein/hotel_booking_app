import 'package:flutter/material.dart';
import 'package:hotel_booking_app/src/utils/custom_pie_chart/custom_chart_painter.dart';
import 'package:hotel_booking_app/src/utils/custom_pie_chart/custom_chart_values_options.dart';
import 'package:hotel_booking_app/src/utils/custom_pie_chart/custom_legend.dart';
import 'package:hotel_booking_app/src/utils/custom_pie_chart/custom_legend_options.dart';
import 'package:hotel_booking_app/src/utils/custom_pie_chart/custom_utils.dart';

enum CustomLegendPosition { top, bottom, left, right }

enum CustomChartType { disc, ring }

class CustomPieChart extends StatefulWidget {
  CustomPieChart({
    required this.dataMap,
    this.chartType = CustomChartType.disc,
    this.chartRadius,
    this.animationDuration,
    this.chartLegendSpacing = 48,
    this.colorList = defaultCustomColorList,
    this.initialAngleInDegree = 0.0,
    this.formatChartValues,
    this.centerText,
    this.ringStrokeWidth = 20.0,
    this.legendOptions = const CustomLegendOptions(),
    this.chartValuesOptions = const CustomChartValuesOptions(),
    this.emptyColor = Colors.grey,
    Key? key,
  }) : super(key: key);

  final Map<String, double> dataMap;
  final CustomChartType chartType;
  final double? chartRadius;
  final Duration? animationDuration;
  final double chartLegendSpacing;
  final List<Color> colorList;
  final double initialAngleInDegree;
  final Function? formatChartValues;
  final String? centerText;
  final double ringStrokeWidth;
  final CustomLegendOptions legendOptions;
  final CustomChartValuesOptions chartValuesOptions;
  final Color emptyColor;

  @override
  _CustomPieChartState createState() => _CustomPieChartState();
}

class _CustomPieChartState extends State<CustomPieChart>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  AnimationController? controller;
  double _animFraction = 0.0;

  List<String>? legendTitles;
  late List<double> legendValues;

  void initLegends() {
    this.legendTitles = widget.dataMap.keys.toList(growable: false);
  }

  void initValues() {
    this.legendValues = widget.dataMap.values.toList(growable: false);
  }

  void initData() {
    assert(
      widget.dataMap != null && widget.dataMap.isNotEmpty,
      "dataMap passed to pie chart cant be null or empty",
    );
    initLegends();
    initValues();
  }

  @override
  void initState() {
    super.initState();
    initData();
    controller = AnimationController(
      duration: widget.animationDuration ?? Duration(milliseconds: 800),
      vsync: this,
    );
    final Animation curve = CurvedAnimation(
      parent: controller!,
      curve: Curves.decelerate,
    );
    animation =
        Tween<double>(begin: 0, end: 1).animate(curve as Animation<double>)
          ..addListener(() {
            setState(() {
              _animFraction = animation.value;
            });
          });
    controller!.forward();
  }

  Widget _getChart() {
    return Flexible(
      child: LayoutBuilder(
        builder: (_, c) => Container(
          height: widget.chartRadius != null
              ? c.maxWidth < widget.chartRadius!
                  ? c.maxWidth
                  : widget.chartRadius
              : null,
          child: CustomPaint(
            painter: CustomPieChartPainter(
              _animFraction,
              widget.chartValuesOptions.showChartValues,
              widget.chartValuesOptions.showChartValuesOutside,
              widget.colorList,
              chartValueStyle: widget.chartValuesOptions.chartValueStyle,
              chartValueBackgroundColor:
                  widget.chartValuesOptions.chartValueBackgroundColor,
              values: legendValues,
              titles: legendTitles,
              initialAngle: widget.initialAngleInDegree,
              showValuesInPercentage:
                  widget.chartValuesOptions.showChartValuesInPercentage,
              decimalPlaces: widget.chartValuesOptions.decimalPlaces,
              showChartValueLabel:
                  widget.chartValuesOptions.showChartValueBackground,
              chartType: widget.chartType,
              centerText: widget.centerText,
              formatChartValues: widget.formatChartValues,
              strokeWidth: widget.ringStrokeWidth,
              emptyColor: widget.emptyColor,
            ),
            child: AspectRatio(aspectRatio: 1),
          ),
        ),
      ),
    );
  }

  Widget _getPieChart() {
    switch (widget.legendOptions.legendPosition) {
      case CustomLegendPosition.top:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _getLegend(
              padding: EdgeInsets.only(
                bottom: widget.chartLegendSpacing,
              ),
            ),
            _getChart(),
          ],
        );

      case CustomLegendPosition.bottom:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _getChart(),
            _getLegend(
              padding: EdgeInsets.only(
                top: widget.chartLegendSpacing,
              ),
            ),
          ],
        );
      case CustomLegendPosition.left:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _getLegend(
              padding: EdgeInsets.only(
                right: widget.chartLegendSpacing,
              ),
            ),
            _getChart(),
          ],
        );
      case CustomLegendPosition.right:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _getChart(),
            _getLegend(
              padding: EdgeInsets.only(
                left: widget.chartLegendSpacing,
              ),
            ),
          ],
        );
      default:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _getChart(),
            _getLegend(
              padding: EdgeInsets.only(
                left: widget.chartLegendSpacing,
              ),
            ),
          ],
        );
    }
  }

  _getLegend({EdgeInsets? padding}) {
    if (widget.legendOptions.showLegends) {
      return Padding(
        padding: padding!,
        child: Wrap(
          direction: widget.legendOptions.showLegendsInRow
              ? Axis.horizontal
              : Axis.vertical,
          runSpacing: 8,
          spacing: 10,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: legendTitles!
              .map(
                (item) => CustomLegend(
                  title: item,
                  color: getCustomColor(
                    widget.colorList,
                    legendTitles!.indexOf(item),
                  ),
                  style: widget.legendOptions.legendTextStyle,
                  legendShape: widget.legendOptions.legendShape,
                ),
              )
              .toList(),
        ),
      );
    } else
      return SizedBox(
        height: 0,
        width: 0,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(8.0),
      child: _getPieChart(),
    );
  }

  @override
  void didUpdateWidget(CustomPieChart oldWidget) {
    initData();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
