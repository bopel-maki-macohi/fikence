package fikence;

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

		addAtom(0xFFFF0000);
		addAtom(0xFF00FF00);
	}

	function addAtom(color_property:FlxColor)
	{
		var atom = new Atom(color_property);

		atom.setPosition(FlxG.random.float(0, FlxG.width - atom.width), FlxG.random.float(0, FlxG.height - atom.height));

		atoms.add(atom);
	}
}
