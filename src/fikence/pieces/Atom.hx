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
	public static var idEnumerator:Int = 0;

	public static final debug:Bool = true;
	public static final debug_bg:Bool = false;

	public static final size:Int = 4;

	override public function new(?_state:State)
	{
		super();

		makeGraphic(Atom.size, Atom.size, 0xFFFFFFFF);
		ID = Atom.idEnumerator++;

		state = _state;

		if (Atom.debug)
		{
			debugLabel = new FlxText();
			if (Atom.debug_bg) debugLabelBG = new FlxSprite().makeGraphic(1, 1, FlxColor.BLACK);
		}
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

	public var state(default, set):AtomState;

	function set_state(_state:AtomState):AtomState
	{
		if (_state == null) _state = AtomState.TYPE_0;

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
			if (atom == null) continue;

			if (atom.ID == this.ID) continue;

			if (overlaps(atom, true) && !overlappingAtoms.contains(atom)) overlappingAtoms.push(atom);
		}

		var o_a1 = overlappingAtoms[0] ?? null;
		var o_a2 = overlappingAtoms[1] ?? null;

		function stateConditional(currentstate:AtomState, states:Array<AtomState>, newstate:AtomState)
		{
			if (this.state != currentstate) return;

			var genstates:Array<AtomState> = [];

			if (states.length >= 1 && o_a1 != null)
			{
				atoms.remove(o_a1);
				genstates.push(o_a1.state);
			}
			if (states.length >= 2 && o_a2 != null)
			{
				atoms.remove(o_a2);
				genstates.push(o_a2.state);
			}

			if (genstates == states)
			{
				state = newstate;
			}
		}

		stateConditional(TYPE_A, [TYPE_A], TYPE_B);
		// stateConditional(TYPE_A, [TYPE_B], TYPE_A);
		stateConditional(TYPE_B, [TYPE_B], TYPE_A);
		// stateConditional(TYPE_B, [TYPE_A], TYPE_B);
	}

	var debugLabel:FlxText;
	var debugLabelBG:FlxSprite;

	override function draw()
	{
		super.draw();

		if (!Atom.debug) return;

		if (debugLabel != null)
		{
			debugLabel.cameras = cameras;

			debugLabel.text = '';
			debugLabel.text += '$ID : $state';
			debugLabel.text += '\n${[for (atom in overlappingAtoms) atom.ID]}';

			debugLabel.x = (this.getScreenPosition().x - this.width);
			debugLabel.y = (this.getScreenPosition().y) - this.height - debugLabel.height;

			if (debugLabelBG != null && Atom.debug_bg)
			{
				debugLabelBG.cameras = cameras;

				debugLabelBG.scale.set(debugLabel.width, debugLabel.height);
				debugLabelBG.updateHitbox();

				debugLabelBG.setPosition(debugLabel.x, debugLabel.y);

				debugLabelBG.draw();
			}

			debugLabel.draw();
		}
	}
}
