import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flame/image_composition.dart';

class CustomSpriteCrop extends FlameGame {
  CustomSpriteCrop(
      {required this.spritePath,
      required this.column,
      required this.row,
      required this.sizes,
      required this.index});

  final String spritePath;
  final int column;
  final int row;
  final Vector2 sizes;
  final int index;

  @override
  Color backgroundColor() => Color.fromARGB(0, 0, 0, 0);
  late SpriteComponent spriteComponent;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    Image img = await images.load(spritePath);
    var sheet =
        SpriteSheet.fromColumnsAndRows(image: img, columns: column, rows: row);
    var spriteComponent =
        SpriteComponent(sprite: sheet.getSpriteById(index), size: sizes);
    add(spriteComponent);
  }
}
