package fikence;

import fikence.data.atom.AtomData;
import fikence.pieces.Atom;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxSpriteContainer.FlxTypedSpriteContainer;
import flixel.util.FlxColor;

class VisualizerState extends FlxState
{
	public var atoms:FlxTypedSpriteContainer<Atom>;

	override function create()
	{
		super.create();

		atoms = new FlxTypedSpriteContainer<Atom>();
		add(atoms);

		addAtom({state: TYPE_A});
		addAtom({state: TYPE_B});
	}

	function addAtom(properties:AtomData)
	{
		var atom = new Atom(properties);

		atom.setPosition(FlxG.random.float(0, FlxG.width - atom.width), FlxG.random.float(0, FlxG.height - atom.height));

		atoms.add(atom);
	}
}
