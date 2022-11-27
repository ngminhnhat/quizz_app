import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/image_composition.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flame/src/sprite_animation.dart' as animation;

class CustomSpriteAnimate extends FlameGame {
  CustomSpriteAnimate(
      {required this.spritePath,
      required this.column,
      required this.row,
      required this.steptime,
      required this.sizes,
      this.loop = true});

  final String spritePath;
  final int column;
  final int row;
  final double steptime;
  final Vector2 sizes;
  bool loop;

  @override
  Color backgroundColor() => Color.fromARGB(0, 0, 0, 0);
  late SpriteComponent spriteComponent;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    Image img = await images.load(spritePath);
    var sheet =
        SpriteSheet.fromColumnsAndRows(image: img, columns: column, rows: row);
    //spriteComponent = SpriteComponent(sprite: sheet.getSprite(row, column));
    List<Sprite> list = [];
    for (var i = 0; i < sheet.columns * sheet.rows; i++) {
      list.add(sheet.getSpriteById(i));
    }
    var spriteAnimation =
        SpriteAnimation.spriteList(list, stepTime: steptime, loop: loop);
    var animation = SpriteAnimationComponent()
      ..animation = spriteAnimation
      ..size = sizes;
    add(animation);
  }
}
