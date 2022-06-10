// ignore_for_file: camel_case_types, non_constant_identifier_names

class pkgmodel {
  final DateTime renewed_at;
  final DateTime expires_at;

  pkgmodel({
    required this.renewed_at,
    required this.expires_at,
  });

  Map<String, dynamic> toJson() => {
        'renewed_at': renewed_at,
        'expires_at': expires_at,
      };

  factory pkgmodel.fromJson(Map<String, dynamic> json) => pkgmodel(
        renewed_at: json['renewed_at'] as DateTime,
        expires_at: json['expires_at'] as DateTime,
      );
}
