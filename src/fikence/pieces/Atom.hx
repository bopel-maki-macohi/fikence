package fikence.pieces;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Atom extends FlxSprite
{
	public static var idEnumerator:Int = 0;

	public static final size:Int = 4;

	override public function new(?color:FlxColor)
	{
		super();

		makeGraphic(Atom.size, Atom.size, 0xFFFFFFFF);
		this.color = color ?? 0xFFFFFFFF;

		this.ID = Atom.idEnumerator++;
	}
}
