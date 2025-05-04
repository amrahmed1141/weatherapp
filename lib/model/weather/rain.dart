class Rain {
	double? oneHour;

	Rain({this.oneHour});

	factory Rain.fromJson(Map<String, dynamic> json) => Rain(
				oneHour: (json['oneHour'] as num?)?.toDouble(),
			);

	Map<String, dynamic> toJson() => {
				'oneHour': oneHour,
			};
}
