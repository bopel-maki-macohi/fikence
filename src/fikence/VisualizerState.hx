package fikence;

import fikence.data.atom.AtomState;
import fikence.pieces.Atom;
import fikence.pieces.AtomContainer;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxSpriteContainer.FlxTypedSpriteContainer;
import flixel.util.FlxColor;

class VisualizerState extends FlxState
{
	public var atoms:AtomContainer;

	override function create()
	{
		super.create();

		atoms = new AtomContainer();
		add(atoms);

		for (i in 0...50)
		{
			addAtom(FlxG.random.bool(75) ? TYPE_A : TYPE_B);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		atoms.forEach(function(atom)
		{
			atom?.check(atoms);
		});
	}

	function addAtom(state:AtomState)
	{
		var atom = new Atom(state);

		atom.setPosition(FlxG.random.float(0, FlxG.width - (atom.width * 10)), FlxG.random.float(0, FlxG.height - (atom.height * 10)));

		atoms.add(atom);
	}
}
