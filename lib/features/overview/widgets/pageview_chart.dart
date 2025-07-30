import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:pulse/features/overview/models/pageview.dart';
import 'package:pulse/utils/text.dart';
import 'package:pulse/widgets/container_wrapper.dart';
import '../models/metric.dart';

class PageviewChart extends StatelessWidget {
  final Pageview data;
  final String unit;
  const PageviewChart({super.key, required this.data, required this.unit});

  @override
  Widget build(BuildContext context) {
    final mergedData = _mergeData(data.pageviews, data.sessions);
    final barGroups = _buildBarGroups(mergedData);
    final labels = mergedData.map((e) => _formatLabel(e.x)).toList();

    return ContainerWrapper(
      padding: 5.0,
      height: 420,
      child: BarChart(
        BarChartData(
          barGroups: barGroups,
          titlesData: FlTitlesData(
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  int index = value.toInt();
                  if (index >= 0 && index < labels.length) {
                    return SideTitleWidget(
                      meta: _,
                      child: Text(
                        labels[index],
                        style: kBodyTextStyle.copyWith(fontSize: 10),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
                reservedSize: 42,
                interval: 1,
              ),
            ),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barTouchData: BarTouchData(enabled: true),
          maxY: _getMaxY(mergedData),
        ),
      ),
    );
  }

  /// Merges the pageview & session lists into a unified structure
  List<_MergedMetric> _mergeData(
      List<Metric> pageviews, List<Metric> sessions) {
    final sessionMap = {
      for (var session in sessions) session.x: session.y,
    };

    return pageviews.map((pv) {
      return _MergedMetric(
        x: pv.x,
        pageviews: pv.y,
        sessions: sessionMap[pv.x] ?? 0,
      );
    }).toList();
  }

  /// Creates bar groups for FL Chart
  List<BarChartGroupData> _buildBarGroups(List<_MergedMetric> data) {
    return List.generate(data.length, (index) {
      final item = data[index];
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: item.pageviews.toDouble(),
            color: Colors.orange,
            width: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          BarChartRodData(
            toY: item.sessions.toDouble(),
            color: Colors.blue,
            width: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
        barsSpace: 4,
      );
    });
  }

  /// Finds the max Y value for scaling
  double _getMaxY(List<_MergedMetric> data) {
    final max = data
        .map((e) => e.pageviews > e.sessions ? e.pageviews : e.sessions)
        .reduce((a, b) => a > b ? a : b);
    return max.toDouble() + 10;
  }

  /// Formats the X-axis label
  String _formatLabel(String iso) {
    final dt = DateTime.parse(iso).toLocal();
    switch (unit) {
      case 'hour':
        return DateFormat('ha').format(dt); // e.g. 2AM
      case 'day':
        return DateFormat('E').format(dt); // e.g. Mon
      case 'month':
        return DateFormat('MMM').format(dt); // e.g. Jul
      case 'year':
        return DateFormat('yyyy').format(dt); // e.g. 2025
      default:
        return DateFormat('E').format(dt);
    }
  }
}

/// Internal structure for merging metrics
class _MergedMetric {
  final String x;
  final int pageviews;
  final int sessions;

  _MergedMetric({
    required this.x,
    required this.pageviews,
    required this.sessions,
  });
}
