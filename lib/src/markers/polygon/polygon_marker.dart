import '../../components/marker/overlay_marker.dart';
import '../../components/marker/overlay_marker_render.dart';
import '../../values/coord.dart';
import '../../values/value.dart';
import 'polygon_marker_render.dart';

class GPolygonMarker extends GOverlayMarker {
  final GValue<bool> _close;
  bool get close => _close.value;
  set close(bool value) => _close.value = value;

  List<GCoordinate> get coordinates => [...keyCoordinates];

  GPolygonMarker({
    super.id,
    super.label,
    super.visible,
    super.layer,
    super.hitTestMode,
    super.theme,
    required List<GCoordinate> coordinates,
    bool close = true,
    GOverlayMarkerRender? render,
    super.scaleHandler,
  }) : _close = GValue<bool>(close),
       super(keyCoordinates: coordinates) {
    super.render = render ?? GPolygonMarkerRender();
  }
}
