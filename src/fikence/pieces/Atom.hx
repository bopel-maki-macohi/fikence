package fikence.pieces;

import fikence.data.atom.AtomState;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import lime.system.WorkOutput.State;

class Atom extends FlxSprite
{
	override public function new(?state:State)
	{
		super();

		makeGraphic(Atom.size, Atom.size, 0xFFFFFFFF);
		this.ID = Atom.idEnumerator++;

		this.state = state;
	}

	public static var idEnumerator:Int = 0;

	public static final size:Int = 4;

	public var state(default, set):AtomState;

	function set_state(_state:AtomState):AtomState
	{
		if (_state == null)
			_state = AtomState.TYPE_0;

		// TODO: Make state properties data-driven
		updateStateProperties(_state);

		return state = _state;
	}

	function updateStateProperties(_state:AtomState)
	{
		switch (_state)
		{
			case TYPE_0:
				orbitRadius = 0;
				color = 0xFFFFFFFF;

			case TYPE_A:
				orbitRadius = 15;
				color = 0xFFFF0000;

			case TYPE_B:
				orbitRadius = 7.5;
				color = 0xFF00FF00;
		}
	}

	var orbitRadius = 0.0;
	var orbitElapsed = FlxG.random.float(0, FlxMath.MAX_VALUE_INT / 10);

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		orbitElapsed += elapsed;
	}

	override function getScreenPosition(?result:FlxPoint, ?camera:FlxCamera):FlxPoint
	{
		var output:FlxPoint = super.getScreenPosition(result, camera);

		output.x += (Math.sin(orbitElapsed) * orbitRadius) * this.scale.x;
		output.y += (Math.cos(orbitElapsed) * orbitRadius) * this.scale.y;

		return output;
	}
}
