package us.palpant.games.players {

	/**
	 * Encapsulates player information 
	 * @author timpalpant
	 * 
	 */
	public class Player {
		
		private var _id:uint;
		
		public function get id():uint { return _id; }
		
		[Bindable] public var color:uint;
		[Bindable] public var name:String;
		[Bindable] public var score:Number;

		public function Player(id:uint, name:String=null, color:uint=0) {
			_id = id;
			this.name = name;
			this.color = color;
			this.score = 0;
		}
	}
}