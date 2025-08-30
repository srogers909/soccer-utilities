import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

/// Represents a country with its cultural and linguistic data for generation
@JsonSerializable(explicitToJson: true)
class Country {
  /// ISO 3166-1 alpha-2 country code (e.g., 'GB', 'DE', 'ES')
  final String code;
  
  /// English name of the country
  final String name;
  
  /// Native name of the country in local language
  final String nativeName;
  
  /// Primary language code (ISO 639-1)
  final String language;
  
  /// Currency code (ISO 4217)
  final String currency;
  
  /// Whether this country has a strong soccer culture
  final bool strongSoccerCulture;
  
  /// Typical league structure for this country
  final LeagueStructure leagueStructure;
  
  /// Cultural naming patterns and preferences
  final NamingCulture namingCulture;

  const Country({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.language,
    required this.currency,
    required this.strongSoccerCulture,
    required this.leagueStructure,
    required this.namingCulture,
  });

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);
  Map<String, dynamic> toJson() => _$CountryToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Country &&
          runtimeType == other.runtimeType &&
          code == other.code;

  @override
  int get hashCode => code.hashCode;

  @override
  String toString() => 'Country(code: $code, name: $name)';
}

/// Defines the typical league structure for a country
@JsonSerializable(explicitToJson: true)
class LeagueStructure {
  /// Number of teams in the top division
  final int topDivisionTeams;
  
  /// Number of professional divisions
  final int professionalDivisions;
  
  /// Whether the league uses playoffs
  final bool hasPlayoffs;
  
  /// Whether the league has relegation/promotion
  final bool hasRelegation;
  
  /// Typical season length in weeks
  final int seasonLength;
  
  /// Month when season typically starts (1-12)
  final int seasonStartMonth;

  const LeagueStructure({
    required this.topDivisionTeams,
    required this.professionalDivisions,
    required this.hasPlayoffs,
    required this.hasRelegation,
    required this.seasonLength,
    required this.seasonStartMonth,
  });

  factory LeagueStructure.fromJson(Map<String, dynamic> json) => 
      _$LeagueStructureFromJson(json);
  Map<String, dynamic> toJson() => _$LeagueStructureToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeagueStructure &&
          runtimeType == other.runtimeType &&
          topDivisionTeams == other.topDivisionTeams &&
          professionalDivisions == other.professionalDivisions &&
          hasPlayoffs == other.hasPlayoffs &&
          hasRelegation == other.hasRelegation &&
          seasonLength == other.seasonLength &&
          seasonStartMonth == other.seasonStartMonth;

  @override
  int get hashCode => Object.hash(
        topDivisionTeams,
        professionalDivisions,
        hasPlayoffs,
        hasRelegation,
        seasonLength,
        seasonStartMonth,
      );
}

/// Defines cultural naming patterns for a country
@JsonSerializable(explicitToJson: true)
class NamingCulture {
  /// Common prefixes for team names (e.g., 'FC', 'Real', 'Athletic')
  final List<String> teamPrefixes;
  
  /// Common suffixes for team names (e.g., 'United', 'City', 'Rovers')
  final List<String> teamSuffixes;
  
  /// Typical stadium naming patterns
  final List<String> stadiumPatterns;
  
  /// Whether names typically include the city name
  final bool includesCityInTeamName;
  
  /// Whether names follow traditional patterns vs modern corporate naming
  final bool prefersTraditionalNames;
  
  /// Common title prefixes for people (Mr., Sr., Dr., etc.)
  final List<String> titlePrefixes;

  const NamingCulture({
    required this.teamPrefixes,
    required this.teamSuffixes,
    required this.stadiumPatterns,
    required this.includesCityInTeamName,
    required this.prefersTraditionalNames,
    required this.titlePrefixes,
  });

  factory NamingCulture.fromJson(Map<String, dynamic> json) => 
      _$NamingCultureFromJson(json);
  Map<String, dynamic> toJson() => _$NamingCultureToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NamingCulture &&
          runtimeType == other.runtimeType &&
          _listEquals(teamPrefixes, other.teamPrefixes) &&
          _listEquals(teamSuffixes, other.teamSuffixes) &&
          _listEquals(stadiumPatterns, other.stadiumPatterns) &&
          includesCityInTeamName == other.includesCityInTeamName &&
          prefersTraditionalNames == other.prefersTraditionalNames &&
          _listEquals(titlePrefixes, other.titlePrefixes);

  @override
  int get hashCode => Object.hash(
        Object.hashAll(teamPrefixes),
        Object.hashAll(teamSuffixes),
        Object.hashAll(stadiumPatterns),
        includesCityInTeamName,
        prefersTraditionalNames,
        Object.hashAll(titlePrefixes),
      );
}

/// Helper function to compare lists for equality
bool _listEquals<T>(List<T> a, List<T> b) {
  if (a.length != b.length) return false;
  for (int i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
