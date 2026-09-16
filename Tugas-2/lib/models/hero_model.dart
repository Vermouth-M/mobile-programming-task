class HeroModel {
  final String id;
  final String name;
  final String knownAs;
  final String originCity;
  final String originProvince;
  final String regionGroup; // Jawa, Sumatera, Maluku, Sulawesi, Bali & Nusa, Papua
  final String birthDate;
  final String birthPlace;
  final String deathDate;
  final String deathPlace;
  final int ageAtDeath;
  final String photoPath;
  final String shortBio;
  final String fullBio;
  final String struggleEra; // e.g. Pergerakan Nasional, Revolusi Kemerdekaan, dsb.
  final List<String> keyContributions;
  final String famousQuote;
  final String quoteContext;
  final String decreeNumber;
  final String burialPlace;

  const HeroModel({
    required this.id,
    required this.name,
    required this.knownAs,
    required this.originCity,
    required this.originProvince,
    required this.regionGroup,
    required this.birthDate,
    required this.birthPlace,
    required this.deathDate,
    required this.deathPlace,
    required this.ageAtDeath,
    required this.photoPath,
    required this.shortBio,
    required this.fullBio,
    required this.struggleEra,
    required this.keyContributions,
    required this.famousQuote,
    required this.quoteContext,
    required this.decreeNumber,
    required this.burialPlace,
  });

  String get lifeTimeYears {
    final b = RegExp(r'\b\d{4}\b').firstMatch(birthDate)?.group(0) ?? birthDate;
    final d = RegExp(r'\b\d{4}\b').firstMatch(deathDate)?.group(0) ?? deathDate;
    return '$b – $d';
  }

  String get fullOrigin => '$originCity, $originProvince';
}
