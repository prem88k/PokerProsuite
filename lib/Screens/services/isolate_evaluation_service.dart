import "package:poker/poker.dart";

import "../../Model/calculation.dart";

abstract class IsolateEvaluationService {
  Stream<Calculation> get onProgress;

  Future<void> initialize();

  Future<void> dispose();

  void requestEvaluation({
    required CardSet communityCards,
    required List<HandRange> players,
    required int times,
  });
}
