
import luxe.Input;
import luxe.AppConfig;
import luxe.Camera;
import phoenix.Vector;
import phoenix.Color;
import level.Level;
import luxe.Parcel;
import luxe.ParcelProgress;
import luxe.Sprite;
import luxe.tween.Actuate;

//47.26 STRIPPED
class Main extends luxe.Game {

	var _defaultX: Int = 960;
	var _defaultY: Int = 640;

	override function config(c: AppConfig): AppConfig {
		//c.window.width = 1440;
		//c.window.width = 768;
		return c;
	}

    override function ready() {
    	_setUpCamera();
    	Luxe.renderer.clear_color = new Color(94 / 255, 92 / 255, 79 / 255);
    	Luxe.renderer.vsync = true;

    	_load();
    } //ready

    function _setUpCamera() {
    	Luxe.camera.size = new Vector(Luxe.screen.w, Luxe.screen.h);
		var zoom = (Luxe.screen.h / _defaultY);
		trace(zoom);
		//#if android 
			Luxe.camera.zoom = zoom;
		//#else 
			//Luxe.camera.zoom = 1; 
		//#end
    }

    function _load() {
    	var json = Luxe.loadJSON('assets/files/parcel.json');

    	var parcel = new Parcel();
    	parcel.from_json(json.json);

    	new ParcelProgress({
    		parcel: parcel,
    		background: new Color(0.3,0.3,0.3),
    		oncomplete: _assetsLoaded
    	});

    	parcel.load();
    }

    function _assetsLoaded(_) {
    	trace('loaded');
    	new player.Player();

        var s = new enemies.Enemy();
    }

    override function onkeyup( e:KeyEvent ) {
    	if(e.keycode == Key.key_e) {
    		Level.instance.toggleEdit();
    	}
    	if(e.keycode == Key.key_s) {
    		Level.instance.saveJSON('assets/files/output.lvl');
    	}
        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }

    } //onkeyup

    override function update(dt:Float) {
    	Level.instance.update();

        if(Luxe.input.mousepressed(1)) {
            trace(Luxe.camera.screen_point_to_world(Luxe.mouse));
        }
    } //update

    override function ondestroy() {

    }


} //Main
