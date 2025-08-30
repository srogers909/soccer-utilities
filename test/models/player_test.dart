import 'package:test/test.dart';
import 'package:soccer_utilities/src/models/player.dart';

void main() {
  group('Player Model Tests', () {
    group('Constructor and Basic Properties', () {
      test('should create player with required properties', () {
        // Arrange
        const id = 'player-123';
        const name = 'John Doe';
        const age = 25;
        const position = PlayerPosition.midfielder;

        // Act
        final player = Player(
          id: id,
          name: name,
          age: age,
          position: position,
        );

        // Assert
        expect(player.id, equals(id));
        expect(player.name, equals(name));
        expect(player.age, equals(age));
        expect(player.position, equals(position));
      });

      test('should have default attributes when not specified', () {
        // Act
        final player = Player(
          id: 'test-id',
          name: 'Test Player',
          age: 20,
          position: PlayerPosition.forward,
        );

        // Assert
        expect(player.technical, isA<int>());
        expect(player.physical, isA<int>());
        expect(player.mental, isA<int>());
        expect(player.technical, greaterThanOrEqualTo(1));
        expect(player.technical, lessThanOrEqualTo(100));
        expect(player.physical, greaterThanOrEqualTo(1));
        expect(player.physical, lessThanOrEqualTo(100));
        expect(player.mental, greaterThanOrEqualTo(1));
        expect(player.mental, lessThanOrEqualTo(100));
      });

      test('should allow custom attributes', () {
        // Arrange
        const technical = 85;
        const physical = 70;
        const mental = 90;

        // Act
        final player = Player(
          id: 'test-id',
          name: 'Test Player',
          age: 28,
          position: PlayerPosition.defender,
          technical: technical,
          physical: physical,
          mental: mental,
        );

        // Assert
        expect(player.technical, equals(technical));
        expect(player.physical, equals(physical));
        expect(player.mental, equals(mental));
      });
    });

    group('Validation', () {
      test('should throw when age is negative', () {
        expect(
          () => Player(
            id: 'test-id',
            name: 'Test Player',
            age: -1,
            position: PlayerPosition.goalkeeper,
          ),
          throwsA(isA<ArgumentError>()),
        );
      });

      test('should throw when age is over maximum', () {
        expect(
          () => Player(
            id: 'test-id',
            name: 'Test Player',
            age: 50,
            position: PlayerPosition.goalkeeper,
          ),
          throwsA(isA<ArgumentError>()),
        );
      });

      test('should throw when attributes are out of range', () {
        expect(
          () => Player(
            id: 'test-id',
            name: 'Test Player',
            age: 25,
            position: PlayerPosition.midfielder,
            technical: 101,
          ),
          throwsA(isA<ArgumentError>()),
        );

        expect(
          () => Player(
            id: 'test-id',
            name: 'Test Player',
            age: 25,
            position: PlayerPosition.midfielder,
            physical: 0,
          ),
          throwsA(isA<ArgumentError>()),
        );
      });

      test('should throw when name is empty', () {
        expect(
          () => Player(
            id: 'test-id',
            name: '',
            age: 25,
            position: PlayerPosition.midfielder,
          ),
          throwsA(isA<ArgumentError>()),
        );
      });

      test('should throw when id is empty', () {
        expect(
          () => Player(
            id: '',
            name: 'Test Player',
            age: 25,
            position: PlayerPosition.midfielder,
          ),
          throwsA(isA<ArgumentError>()),
        );
      });
    });

    group('Overall Rating Calculation', () {
      test('should calculate overall rating correctly', () {
        // Arrange
        final player = Player(
          id: 'test-id',
          name: 'Test Player',
          age: 25,
          position: PlayerPosition.midfielder,
          technical: 80,
          physical: 70,
          mental: 90,
        );

        // Act
        final overall = player.overallRating;

        // Assert
        expect(overall, equals(80)); // (80 + 70 + 90) / 3 = 80
      });

      test('should calculate position-weighted overall rating', () {
        // Test that different positions weight attributes differently
        final goalkeeper = Player(
          id: 'gk-id',
          name: 'Goalkeeper',
          age: 25,
          position: PlayerPosition.goalkeeper,
          technical: 60,
          physical: 70,
          mental: 90,
        );

        final forward = Player(
          id: 'fw-id',
          name: 'Forward',
          age: 25,
          position: PlayerPosition.forward,
          technical: 90,
          physical: 80,
          mental: 60,
        );

        // Assert that position affects overall calculation
        expect(goalkeeper.positionOverallRating, isNot(equals(goalkeeper.overallRating)));
        expect(forward.positionOverallRating, isNot(equals(forward.overallRating)));
      });
    });

    group('Form and Fitness', () {
      test('should have default form and fitness values', () {
        // Act
        final player = Player(
          id: 'test-id',
          name: 'Test Player',
          age: 25,
          position: PlayerPosition.midfielder,
        );

        // Assert
        expect(player.form, equals(7)); // Default form should be 7/10
        expect(player.fitness, equals(100)); // Default fitness should be 100%
      });

      test('should update form correctly', () {
        // Arrange
        final player = Player(
          id: 'test-id',
          name: 'Test Player',
          age: 25,
          position: PlayerPosition.midfielder,
        );

        // Act
        final updatedPlayer = player.updateForm(9);

        // Assert
        expect(updatedPlayer.form, equals(9));
        expect(updatedPlayer.id, equals(player.id)); // Other properties unchanged
      });

      test('should update fitness correctly', () {
        // Arrange
        final player = Player(
          id: 'test-id',
          name: 'Test Player',
          age: 25,
          position: PlayerPosition.midfielder,
        );

        // Act
        final updatedPlayer = player.updateFitness(85);

        // Assert
        expect(updatedPlayer.fitness, equals(85));
        expect(updatedPlayer.id, equals(player.id)); // Other properties unchanged
      });

      test('should clamp form values to valid range', () {
        // Arrange
        final player = Player(
          id: 'test-id',
          name: 'Test Player',
          age: 25,
          position: PlayerPosition.midfielder,
        );

        // Act & Assert
        expect(player.updateForm(11).form, equals(10)); // Max form is 10
        expect(player.updateForm(-1).form, equals(1)); // Min form is 1
      });

      test('should clamp fitness values to valid range', () {
        // Arrange
        final player = Player(
          id: 'test-id',
          name: 'Test Player',
          age: 25,
          position: PlayerPosition.midfielder,
        );

        // Act & Assert
        expect(player.updateFitness(110).fitness, equals(100)); // Max fitness is 100
        expect(player.updateFitness(-10).fitness, equals(0)); // Min fitness is 0
      });
    });

    group('Equality and Hashing', () {
      test('should be equal when all properties match', () {
        // Arrange
        final player1 = Player(
          id: 'test-id',
          name: 'Test Player',
          age: 25,
          position: PlayerPosition.midfielder,
          technical: 80,
          physical: 70,
          mental: 90,
        );

        final player2 = Player(
          id: 'test-id',
          name: 'Test Player',
          age: 25,
          position: PlayerPosition.midfielder,
          technical: 80,
          physical: 70,
          mental: 90,
        );

        // Act & Assert
        expect(player1, equals(player2));
        expect(player1.hashCode, equals(player2.hashCode));
      });

      test('should not be equal when properties differ', () {
        // Arrange
        final player1 = Player(
          id: 'test-id-1',
          name: 'Test Player',
          age: 25,
          position: PlayerPosition.midfielder,
        );

        final player2 = Player(
          id: 'test-id-2',
          name: 'Test Player',
          age: 25,
          position: PlayerPosition.midfielder,
        );

        // Act & Assert
        expect(player1, isNot(equals(player2)));
      });
    });

    group('JSON Serialization', () {
      test('should serialize to JSON correctly', () {
        // Arrange
        final player = Player(
          id: 'test-id',
          name: 'Test Player',
          age: 25,
          position: PlayerPosition.midfielder,
          technical: 80,
          physical: 70,
          mental: 90,
        );

        // Act
        final json = player.toJson();

        // Assert
        expect(json['id'], equals('test-id'));
        expect(json['name'], equals('Test Player'));
        expect(json['age'], equals(25));
        expect(json['position'], equals('midfielder'));
        expect(json['technical'], equals(80));
        expect(json['physical'], equals(70));
        expect(json['mental'], equals(90));
      });

      test('should deserialize from JSON correctly', () {
        // Arrange
        final json = {
          'id': 'test-id',
          'name': 'Test Player',
          'age': 25,
          'position': 'forward',
          'technical': 85,
          'physical': 75,
          'mental': 80,
          'form': 8,
          'fitness': 95,
        };

        // Act
        final player = Player.fromJson(json);

        // Assert
        expect(player.id, equals('test-id'));
        expect(player.name, equals('Test Player'));
        expect(player.age, equals(25));
        expect(player.position, equals(PlayerPosition.forward));
        expect(player.technical, equals(85));
        expect(player.physical, equals(75));
        expect(player.mental, equals(80));
        expect(player.form, equals(8));
        expect(player.fitness, equals(95));
      });
    });
  });
}
