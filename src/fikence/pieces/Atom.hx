package fikence.pieces;

import fikence.data.atom.AtomState;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteContainer.FlxTypedSpriteContainer;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
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

		debugLabel = new FlxText();
	}

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

	var orbitRadius = 0.0;
	var orbitElapsed = FlxG.random.float(0, FlxMath.MAX_VALUE_INT / 10);

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

	var overlappingAtoms = [];

	public function check(atoms:AtomContainer)
	{
		overlappingAtoms = [];
		for (atom in atoms)
		{
			if (atom == null)
				continue;

			if (atom.ID == this.ID)
				continue;

			if (overlaps(atom, true))
				overlappingAtoms.push(atom.ID);
		}
	}

	var debugLabel:FlxText;

	override function draw()
	{
		super.draw();

		if (debugLabel != null)
		{
			debugLabel.cameras = cameras;

			debugLabel.text = '$overlappingAtoms';

			debugLabel.x = (this.getScreenPosition().x - this.width / 2) - (debugLabel.width / 2);
			debugLabel.y = (this.getScreenPosition().y - this.height / 2) - this.height - debugLabel.height;

			debugLabel.draw();
		}
	}
}
