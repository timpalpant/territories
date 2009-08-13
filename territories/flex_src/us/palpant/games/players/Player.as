package us.palpant.games.players {

	/**
	 * Encapsulates player information 
	 * @author timpalpant
	 * 
	 */
	public class Player {
		[Bindable] public var color:uint;
		[Bindable] public var name:String;

		public function Player(name:String=null, color:uint=0) {
			this.name = name;
			this.color = color;
		}
	}
}