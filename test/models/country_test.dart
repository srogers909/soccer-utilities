import 'package:test/test.dart';
import 'package:soccer_utilities/src/models/country.dart';

void main() {
  group('Country Model Tests', () {
    group('Constructor and Basic Properties', () {
      test('should create country with required properties', () {
        // Arrange
        const leagueStructure = LeagueStructure(
          topDivisionTeams: 20,
          professionalDivisions: 4,
          hasPlayoffs: false,
          hasRelegation: true,
          seasonLength: 38,
          seasonStartMonth: 8,
        );
        
        const namingCulture = NamingCulture(
          teamPrefixes: ['FC', 'AFC'],
          teamSuffixes: ['United', 'City'],
          stadiumPatterns: ['Stadium', 'Arena'],
          includesCityInTeamName: true,
          prefersTraditionalNames: true,
          titlePrefixes: ['Mr.', 'Mrs.'],
        );

        // Act
        const country = Country(
          code: 'GB',
          name: 'England',
          nativeName: 'England',
          language: 'en',
          currency: 'GBP',
          strongSoccerCulture: true,
          leagueStructure: leagueStructure,
          namingCulture: namingCulture,
        );

        // Assert
        expect(country.code, equals('GB'));
        expect(country.name, equals('England'));
        expect(country.nativeName, equals('England'));
        expect(country.language, equals('en'));
        expect(country.currency, equals('GBP'));
        expect(country.strongSoccerCulture, isTrue);
        expect(country.leagueStructure, equals(leagueStructure));
        expect(country.namingCulture, equals(namingCulture));
      });

      test('should create country with minimal required data', () {
        // Arrange
        const leagueStructure = LeagueStructure(
          topDivisionTeams: 18,
          professionalDivisions: 2,
          hasPlayoffs: true,
          hasRelegation: false,
          seasonLength: 34,
          seasonStartMonth: 3,
        );
        
        const namingCulture = NamingCulture(
          teamPrefixes: [],
          teamSuffixes: [],
          stadiumPatterns: ['Stadium'],
          includesCityInTeamName: false,
          prefersTraditionalNames: false,
          titlePrefixes: [],
        );

        // Act
        const country = Country(
          code: 'US',
          name: 'United States',
          nativeName: 'United States',
          language: 'en',
          currency: 'USD',
          strongSoccerCulture: false,
          leagueStructure: leagueStructure,
          namingCulture: namingCulture,
        );

        // Assert
        expect(country.code, equals('US'));
        expect(country.strongSoccerCulture, isFalse);
        expect(country.leagueStructure.hasPlayoffs, isTrue);
        expect(country.namingCulture.teamPrefixes, isEmpty);
      });
    });

    group('Equality and Hashing', () {
      test('should be equal when country codes match', () {
        // Arrange
        const leagueStructure1 = LeagueStructure(
          topDivisionTeams: 20,
          professionalDivisions: 4,
          hasPlayoffs: false,
          hasRelegation: true,
          seasonLength: 38,
          seasonStartMonth: 8,
        );
        
        const leagueStructure2 = LeagueStructure(
          topDivisionTeams: 18,
          professionalDivisions: 3,
          hasPlayoffs: true,
          hasRelegation: false,
          seasonLength: 34,
          seasonStartMonth: 3,
        );
        
        const namingCulture = NamingCulture(
          teamPrefixes: ['FC'],
          teamSuffixes: ['United'],
          stadiumPatterns: ['Stadium'],
          includesCityInTeamName: true,
          prefersTraditionalNames: true,
          titlePrefixes: ['Mr.'],
        );

        const country1 = Country(
          code: 'GB',
          name: 'England',
          nativeName: 'England',
          language: 'en',
          currency: 'GBP',
          strongSoccerCulture: true,
          leagueStructure: leagueStructure1,
          namingCulture: namingCulture,
        );

        const country2 = Country(
          code: 'GB',
          name: 'Great Britain', // Different name
          nativeName: 'Great Britain',
          language: 'en',
          currency: 'GBP',
          strongSoccerCulture: false, // Different soccer culture
          leagueStructure: leagueStructure2, // Different league structure
          namingCulture: namingCulture,
        );

        // Act & Assert
        expect(country1, equals(country2)); // Should be equal based on code only
        expect(country1.hashCode, equals(country2.hashCode));
      });

      test('should not be equal when country codes differ', () {
        // Arrange
        const leagueStructure = LeagueStructure(
          topDivisionTeams: 20,
          professionalDivisions: 4,
          hasPlayoffs: false,
          hasRelegation: true,
          seasonLength: 38,
          seasonStartMonth: 8,
        );
        
        const namingCulture = NamingCulture(
          teamPrefixes: ['FC'],
          teamSuffixes: ['United'],
          stadiumPatterns: ['Stadium'],
          includesCityInTeamName: true,
          prefersTraditionalNames: true,
          titlePrefixes: ['Mr.'],
        );

        const country1 = Country(
          code: 'GB',
          name: 'England',
          nativeName: 'England',
          language: 'en',
          currency: 'GBP',
          strongSoccerCulture: true,
          leagueStructure: leagueStructure,
          namingCulture: namingCulture,
        );

        const country2 = Country(
          code: 'DE',
          name: 'Germany',
          nativeName: 'Deutschland',
          language: 'de',
          currency: 'EUR',
          strongSoccerCulture: true,
          leagueStructure: leagueStructure,
          namingCulture: namingCulture,
        );

        // Act & Assert
        expect(country1, isNot(equals(country2)));
        expect(country1.hashCode, isNot(equals(country2.hashCode)));
      });
    });

    group('JSON Serialization', () {
      test('should serialize to JSON correctly', () {
        // Arrange
        const country = Country(
          code: 'ES',
          name: 'Spain',
          nativeName: 'España',
          language: 'es',
          currency: 'EUR',
          strongSoccerCulture: true,
          leagueStructure: LeagueStructure(
            topDivisionTeams: 20,
            professionalDivisions: 3,
            hasPlayoffs: false,
            hasRelegation: true,
            seasonLength: 38,
            seasonStartMonth: 8,
          ),
          namingCulture: NamingCulture(
            teamPrefixes: ['Real', 'CF', 'FC'],
            teamSuffixes: ['Barcelona', 'Madrid'],
            stadiumPatterns: ['Estadio', 'Campo'],
            includesCityInTeamName: true,
            prefersTraditionalNames: true,
            titlePrefixes: ['Sr.', 'Sra.'],
          ),
        );

        // Act
        final json = country.toJson();

        // Assert
        expect(json['code'], equals('ES'));
        expect(json['name'], equals('Spain'));
        expect(json['nativeName'], equals('España'));
        expect(json['language'], equals('es'));
        expect(json['currency'], equals('EUR'));
        expect(json['strongSoccerCulture'], isTrue);
        expect(json['leagueStructure'], isA<Map<String, dynamic>>());
        expect(json['namingCulture'], isA<Map<String, dynamic>>());
        
        // Check nested structure details
        final leagueStructureJson = json['leagueStructure'] as Map<String, dynamic>;
        expect(leagueStructureJson['topDivisionTeams'], equals(20));
        expect(leagueStructureJson['hasPlayoffs'], isFalse);
        
        final namingCultureJson = json['namingCulture'] as Map<String, dynamic>;
        expect(namingCultureJson['teamPrefixes'], contains('Real'));
      });

      test('should deserialize from JSON correctly', () {
        // Arrange
        final json = {
          'code': 'FR',
          'name': 'France',
          'nativeName': 'France',
          'language': 'fr',
          'currency': 'EUR',
          'strongSoccerCulture': true,
          'leagueStructure': {
            'topDivisionTeams': 20,
            'professionalDivisions': 2,
            'hasPlayoffs': true,
            'hasRelegation': true,
            'seasonLength': 38,
            'seasonStartMonth': 8,
          },
          'namingCulture': {
            'teamPrefixes': ['FC', 'AS'],
            'teamSuffixes': ['Saint-Étienne', 'Marseille'],
            'stadiumPatterns': ['Stade'],
            'includesCityInTeamName': true,
            'prefersTraditionalNames': true,
            'titlePrefixes': ['M.', 'Mme.'],
          },
        };

        // Act
        final country = Country.fromJson(json);

        // Assert
        expect(country.code, equals('FR'));
        expect(country.name, equals('France'));
        expect(country.nativeName, equals('France'));
        expect(country.language, equals('fr'));
        expect(country.currency, equals('EUR'));
        expect(country.strongSoccerCulture, isTrue);
        expect(country.leagueStructure.topDivisionTeams, equals(20));
        expect(country.namingCulture.teamPrefixes, contains('FC'));
      });
    });

    group('toString', () {
      test('should provide readable string representation', () {
        // Arrange
        const country = Country(
          code: 'IT',
          name: 'Italy',
          nativeName: 'Italia',
          language: 'it',
          currency: 'EUR',
          strongSoccerCulture: true,
          leagueStructure: LeagueStructure(
            topDivisionTeams: 20,
            professionalDivisions: 3,
            hasPlayoffs: false,
            hasRelegation: true,
            seasonLength: 38,
            seasonStartMonth: 8,
          ),
          namingCulture: NamingCulture(
            teamPrefixes: ['AC', 'FC'],
            teamSuffixes: ['Milan', 'Roma'],
            stadiumPatterns: ['Stadio'],
            includesCityInTeamName: true,
            prefersTraditionalNames: true,
            titlePrefixes: ['Sig.', 'Sig.ra'],
          ),
        );

        // Act
        final result = country.toString();

        // Assert
        expect(result, equals('Country(code: IT, name: Italy)'));
      });
    });
  });

  group('LeagueStructure Tests', () {
    test('should create league structure with all properties', () {
      // Act
      const structure = LeagueStructure(
        topDivisionTeams: 18,
        professionalDivisions: 3,
        hasPlayoffs: true,
        hasRelegation: false,
        seasonLength: 34,
        seasonStartMonth: 3,
      );

      // Assert
      expect(structure.topDivisionTeams, equals(18));
      expect(structure.professionalDivisions, equals(3));
      expect(structure.hasPlayoffs, isTrue);
      expect(structure.hasRelegation, isFalse);
      expect(structure.seasonLength, equals(34));
      expect(structure.seasonStartMonth, equals(3));
    });

    test('should serialize and deserialize LeagueStructure correctly', () {
      // Arrange
      const original = LeagueStructure(
        topDivisionTeams: 16,
        professionalDivisions: 4,
        hasPlayoffs: false,
        hasRelegation: true,
        seasonLength: 30,
        seasonStartMonth: 2,
      );

      // Act
      final json = original.toJson();
      final deserialized = LeagueStructure.fromJson(json);

      // Assert
      expect(deserialized.topDivisionTeams, equals(original.topDivisionTeams));
      expect(deserialized.professionalDivisions, equals(original.professionalDivisions));
      expect(deserialized.hasPlayoffs, equals(original.hasPlayoffs));
      expect(deserialized.hasRelegation, equals(original.hasRelegation));
      expect(deserialized.seasonLength, equals(original.seasonLength));
      expect(deserialized.seasonStartMonth, equals(original.seasonStartMonth));
    });
  });

  group('NamingCulture Tests', () {
    test('should create naming culture with all properties', () {
      // Act
      const culture = NamingCulture(
        teamPrefixes: ['Real', 'Athletic', 'Club'],
        teamSuffixes: ['Bilbao', 'Madrid', 'Barcelona'],
        stadiumPatterns: ['Estadio', 'Campo de'],
        includesCityInTeamName: false,
        prefersTraditionalNames: true,
        titlePrefixes: ['Don', 'Doña'],
      );

      // Assert
      expect(culture.teamPrefixes, equals(['Real', 'Athletic', 'Club']));
      expect(culture.teamSuffixes, equals(['Bilbao', 'Madrid', 'Barcelona']));
      expect(culture.stadiumPatterns, equals(['Estadio', 'Campo de']));
      expect(culture.includesCityInTeamName, isFalse);
      expect(culture.prefersTraditionalNames, isTrue);
      expect(culture.titlePrefixes, equals(['Don', 'Doña']));
    });

    test('should serialize and deserialize NamingCulture correctly', () {
      // Arrange
      const original = NamingCulture(
        teamPrefixes: ['FC', 'SC'],
        teamSuffixes: ['United', 'City', 'Town'],
        stadiumPatterns: ['Stadium', 'Ground', 'Park'],
        includesCityInTeamName: true,
        prefersTraditionalNames: false,
        titlePrefixes: ['Mr.', 'Ms.', 'Dr.'],
      );

      // Act
      final json = original.toJson();
      final deserialized = NamingCulture.fromJson(json);

      // Assert
      expect(deserialized.teamPrefixes, equals(original.teamPrefixes));
      expect(deserialized.teamSuffixes, equals(original.teamSuffixes));
      expect(deserialized.stadiumPatterns, equals(original.stadiumPatterns));
      expect(deserialized.includesCityInTeamName, equals(original.includesCityInTeamName));
      expect(deserialized.prefersTraditionalNames, equals(original.prefersTraditionalNames));
      expect(deserialized.titlePrefixes, equals(original.titlePrefixes));
    });

    test('should handle empty lists correctly', () {
      // Act
      const culture = NamingCulture(
        teamPrefixes: [],
        teamSuffixes: [],
        stadiumPatterns: ['Stadium'],
        includesCityInTeamName: false,
        prefersTraditionalNames: false,
        titlePrefixes: [],
      );

      // Assert
      expect(culture.teamPrefixes, isEmpty);
      expect(culture.teamSuffixes, isEmpty);
      expect(culture.stadiumPatterns, equals(['Stadium']));
      expect(culture.titlePrefixes, isEmpty);
    });
  });
}
