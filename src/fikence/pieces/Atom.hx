package fikence.pieces;

import fikence.data.atom.AtomData;
import fikence.data.atom.AtomState;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Atom extends FlxSprite
{
	override public function new(?properties:AtomData)
	{
		super();

		makeGraphic(Atom.size, Atom.size, 0xFFFFFFFF);
		this.ID = Atom.idEnumerator++;

		state = properties?.state;
	}

	public static var idEnumerator:Int = 0;

	public static final size:Int = 4;

	public var state(default, set):AtomState;

	function set_state(_state:AtomState):AtomState
	{
		if (_state == null)
			_state = AtomState.TYPE_0;

		// TODO: Make state properties data-driven
		updateStateColor(_state);

		return state = _state;
	}

	function updateStateColor(_state:AtomState)
	{
		color = switch (_state)
		{
			case TYPE_0:
				0xFFFFFFFF;
			case TYPE_A:
				0xFFFF0000;
			case TYPE_B:
				0xFF00FF00;
			default:
				0xFFFFFFFF;
		}
	}
}
