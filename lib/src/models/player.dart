import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'player.g.dart';

/// Represents a player's position on the field
@JsonEnum()
enum PlayerPosition {
  goalkeeper,
  defender,
  midfielder,
  forward;
}

/// Represents a soccer player with all their attributes and capabilities
@JsonSerializable()
class Player extends Equatable {
  /// Unique identifier for the player
  final String id;

  /// Player's full name
  final String name;

  /// Player's age in years
  final int age;

  /// Player's primary position
  final PlayerPosition position;

  /// Technical skill rating (1-100)
  final int technical;

  /// Physical attributes rating (1-100)
  final int physical;

  /// Mental attributes rating (1-100)
  final int mental;

  /// Current form rating (1-10)
  final int form;

  /// Current fitness percentage (0-100)
  final int fitness;

  /// Creates a new player instance
  ///
  /// [id] and [name] cannot be empty
  /// [age] must be between 16 and 45
  /// [technical], [physical], [mental] must be between 1 and 100
  /// [form] must be between 1 and 10
  /// [fitness] must be between 0 and 100
  Player({
    required this.id,
    required this.name,
    required this.age,
    required this.position,
    int? technical,
    int? physical,
    int? mental,
    int? form,
    int? fitness,
  })  : technical = technical ?? 50,
        physical = physical ?? 50,
        mental = mental ?? 50,
        form = form ?? 7,
        fitness = fitness ?? 100 {
    if (id.isEmpty) throw ArgumentError('Player ID cannot be empty');
    if (name.isEmpty) throw ArgumentError('Player name cannot be empty');
    if (age < 16 || age > 45) throw ArgumentError('Player age must be between 16 and 45');
    
    final techValue = technical ?? 50;
    final physValue = physical ?? 50;
    final mentalValue = mental ?? 50;
    final formValue = form ?? 7;
    final fitnessValue = fitness ?? 100;
    
    if (techValue < 1 || techValue > 100) throw ArgumentError('Technical rating must be between 1 and 100');
    if (physValue < 1 || physValue > 100) throw ArgumentError('Physical rating must be between 1 and 100');
    if (mentalValue < 1 || mentalValue > 100) throw ArgumentError('Mental rating must be between 1 and 100');
    if (formValue < 1 || formValue > 10) throw ArgumentError('Form rating must be between 1 and 10');
    if (fitnessValue < 0 || fitnessValue > 100) throw ArgumentError('Fitness must be between 0 and 100');
  }

  /// Creates a player from JSON data
  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  /// Converts the player to JSON data
  Map<String, dynamic> toJson() => _$PlayerToJson(this);

  /// Calculates the overall rating as simple average of all attributes
  int get overallRating => ((technical + physical + mental) / 3).round();

  /// Calculates position-specific overall rating with weighted attributes
  int get positionOverallRating {
    switch (position) {
      case PlayerPosition.goalkeeper:
        // Goalkeepers: Mental (50%), Physical (30%), Technical (20%)
        return (mental * 0.5 + physical * 0.3 + technical * 0.2).round();
      case PlayerPosition.defender:
        // Defenders: Physical (40%), Mental (35%), Technical (25%)
        return (physical * 0.4 + mental * 0.35 + technical * 0.25).round();
      case PlayerPosition.midfielder:
        // Midfielders: Technical (40%), Mental (35%), Physical (25%)
        return (technical * 0.4 + mental * 0.35 + physical * 0.25).round();
      case PlayerPosition.forward:
        // Forwards: Technical (45%), Physical (30%), Mental (25%)
        return (technical * 0.45 + physical * 0.3 + mental * 0.25).round();
    }
  }

  /// Creates a copy of this player with updated form
  Player updateForm(int newForm) {
    final clampedForm = newForm.clamp(1, 10);
    return Player(
      id: id,
      name: name,
      age: age,
      position: position,
      technical: technical,
      physical: physical,
      mental: mental,
      form: clampedForm,
      fitness: fitness,
    );
  }

  /// Creates a copy of this player with updated fitness
  Player updateFitness(int newFitness) {
    final clampedFitness = newFitness.clamp(0, 100);
    return Player(
      id: id,
      name: name,
      age: age,
      position: position,
      technical: technical,
      physical: physical,
      mental: mental,
      form: form,
      fitness: clampedFitness,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        age,
        position,
        technical,
        physical,
        mental,
        form,
        fitness,
      ];

  @override
  String toString() {
    return 'Player(id: $id, name: $name, age: $age, position: ${position.name}, '
        'overall: $overallRating, form: $form, fitness: $fitness)';
  }
}
