class StepValue {
  final String dates;
  final int step;

  StepValue({required this.dates, required this.step});

  factory StepValue.fromMap(Map<String, dynamic> json) =>
      StepValue(dates: json['dates'], step: json['step']);

  Map<String, dynamic> toMap() {
    return {
      'dates': dates,
      'step': step,
    };
  }
}
