// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
  code: json['code'] as String,
  name: json['name'] as String,
  nativeName: json['nativeName'] as String,
  language: json['language'] as String,
  currency: json['currency'] as String,
  strongSoccerCulture: json['strongSoccerCulture'] as bool,
  leagueStructure: LeagueStructure.fromJson(
    json['leagueStructure'] as Map<String, dynamic>,
  ),
  namingCulture: NamingCulture.fromJson(
    json['namingCulture'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'nativeName': instance.nativeName,
  'language': instance.language,
  'currency': instance.currency,
  'strongSoccerCulture': instance.strongSoccerCulture,
  'leagueStructure': instance.leagueStructure.toJson(),
  'namingCulture': instance.namingCulture.toJson(),
};

LeagueStructure _$LeagueStructureFromJson(Map<String, dynamic> json) =>
    LeagueStructure(
      topDivisionTeams: (json['topDivisionTeams'] as num).toInt(),
      professionalDivisions: (json['professionalDivisions'] as num).toInt(),
      hasPlayoffs: json['hasPlayoffs'] as bool,
      hasRelegation: json['hasRelegation'] as bool,
      seasonLength: (json['seasonLength'] as num).toInt(),
      seasonStartMonth: (json['seasonStartMonth'] as num).toInt(),
    );

Map<String, dynamic> _$LeagueStructureToJson(LeagueStructure instance) =>
    <String, dynamic>{
      'topDivisionTeams': instance.topDivisionTeams,
      'professionalDivisions': instance.professionalDivisions,
      'hasPlayoffs': instance.hasPlayoffs,
      'hasRelegation': instance.hasRelegation,
      'seasonLength': instance.seasonLength,
      'seasonStartMonth': instance.seasonStartMonth,
    };

NamingCulture _$NamingCultureFromJson(Map<String, dynamic> json) =>
    NamingCulture(
      teamPrefixes: (json['teamPrefixes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      teamSuffixes: (json['teamSuffixes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      stadiumPatterns: (json['stadiumPatterns'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      includesCityInTeamName: json['includesCityInTeamName'] as bool,
      prefersTraditionalNames: json['prefersTraditionalNames'] as bool,
      titlePrefixes: (json['titlePrefixes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$NamingCultureToJson(NamingCulture instance) =>
    <String, dynamic>{
      'teamPrefixes': instance.teamPrefixes,
      'teamSuffixes': instance.teamSuffixes,
      'stadiumPatterns': instance.stadiumPatterns,
      'includesCityInTeamName': instance.includesCityInTeamName,
      'prefersTraditionalNames': instance.prefersTraditionalNames,
      'titlePrefixes': instance.titlePrefixes,
    };
