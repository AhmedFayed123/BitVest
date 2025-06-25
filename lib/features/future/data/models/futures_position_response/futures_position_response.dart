import 'futures_position.dart';

class FuturesPositionResponse {
  final List<FuturesPosition> openPositions;
  final List<FuturesPosition> closedPositions;

  FuturesPositionResponse({
    required this.openPositions,
    required this.closedPositions,
  });

  factory FuturesPositionResponse.fromJson(Map<String, dynamic> json) {
    return FuturesPositionResponse(
      openPositions: (json['open_positions'] as List)
          .map((e) => FuturesPosition.fromJson(e))
          .toList(),
      closedPositions: (json['closed_positions'] as List)
          .map((e) => FuturesPosition.fromJson(e))
          .toList(),
    );
  }
}
