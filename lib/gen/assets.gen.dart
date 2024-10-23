/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/icon.png
  AssetGenImage get icon => const AssetGenImage('assets/images/icon.png');

  /// File path: assets/images/meditation_person.png
  AssetGenImage get meditationPerson =>
      const AssetGenImage('assets/images/meditation_person.png');

  /// File path: assets/images/onb_1.png
  AssetGenImage get onb1 => const AssetGenImage('assets/images/onb_1.png');

  /// File path: assets/images/onb_2.png
  AssetGenImage get onb2 => const AssetGenImage('assets/images/onb_2.png');

  /// File path: assets/images/quiz_finish.png
  AssetGenImage get quizFinish =>
      const AssetGenImage('assets/images/quiz_finish.png');

  /// File path: assets/images/smile_1.png
  AssetGenImage get smile1 => const AssetGenImage('assets/images/smile_1.png');

  /// File path: assets/images/smile_2.png
  AssetGenImage get smile2 => const AssetGenImage('assets/images/smile_2.png');

  /// File path: assets/images/smile_3.png
  AssetGenImage get smile3 => const AssetGenImage('assets/images/smile_3.png');

  /// File path: assets/images/smile_4.png
  AssetGenImage get smile4 => const AssetGenImage('assets/images/smile_4.png');

  /// File path: assets/images/smile_5.png
  AssetGenImage get smile5 => const AssetGenImage('assets/images/smile_5.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        icon,
        meditationPerson,
        onb1,
        onb2,
        quizFinish,
        smile1,
        smile2,
        smile3,
        smile4,
        smile5
      ];
}

class $AssetsVectorsGen {
  const $AssetsVectorsGen();

  /// File path: assets/vectors/arrow_left.svg
  String get arrowLeft => 'assets/vectors/arrow_left.svg';

  /// File path: assets/vectors/back.svg
  String get back => 'assets/vectors/back.svg';

  /// File path: assets/vectors/calendar.svg
  String get calendar => 'assets/vectors/calendar.svg';

  /// File path: assets/vectors/checkbox.svg
  String get checkbox => 'assets/vectors/checkbox.svg';

  /// File path: assets/vectors/checkbox_active.svg
  String get checkboxActive => 'assets/vectors/checkbox_active.svg';

  /// File path: assets/vectors/chevron-right.svg
  String get chevronRight => 'assets/vectors/chevron-right.svg';

  /// File path: assets/vectors/diary.svg
  String get diary => 'assets/vectors/diary.svg';

  /// File path: assets/vectors/file.svg
  String get file => 'assets/vectors/file.svg';

  /// File path: assets/vectors/meditation.svg
  String get meditation => 'assets/vectors/meditation.svg';

  /// File path: assets/vectors/note_plus.svg
  String get notePlus => 'assets/vectors/note_plus.svg';

  /// File path: assets/vectors/pause.svg
  String get pause => 'assets/vectors/pause.svg';

  /// File path: assets/vectors/play.svg
  String get play => 'assets/vectors/play.svg';

  /// List of all assets
  List<String> get values => [
        arrowLeft,
        back,
        calendar,
        checkbox,
        checkboxActive,
        chevronRight,
        diary,
        file,
        meditation,
        notePlus,
        pause,
        play
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsVectorsGen vectors = $AssetsVectorsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size = null});

  final String _assetName;

  final Size? size;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
