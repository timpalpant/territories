package us.palpant.games.players {
	import us.palpant.games.territories.TerritoriesModel;
	import us.palpant.games.territories.Territory;
	import us.palpant.games.territories.ai.ITerritoriesAI;
	

	/**
	 * Encapsulates player information 
	 * @author timpalpant
	 * 
	 */
	public class Player {
		
		public static const HUMAN:String = "humanPlayer";
		public static const COMPUTER:String = "computerPlayer";
		
		/**
		 * Unique player id 
		 */
		private var _id:uint;
		
		public function get id():uint { return _id; }
		
		/**
		 * Player type (human/computer) 
		 */
		[Bindable] public var type:String;
		[Bindable] public var AI:ITerritoriesAI;
		
		/**
		 * Player's color for game pieces, etc. 
		 */
		[Bindable] public var color:uint;
		
		/**
		 * Player's name 
		 */
		[Bindable] public var name:String;
		
		/**
		 * Player's score in the current game
		 */
		[Bindable] public var score:Number;

		public function Player(id:uint, type:String, name:String=null, color:uint=0) {
			_id = id;
			
			this.type = type;
			this.name = name;
			this.color = color;
			this.score = 0;
		}
		
		public function autoSelect(model:TerritoriesModel, playerManager:PlayerManager):Territory {
			if(type == HUMAN)
				return null;
				
			return AI.select(model, playerManager);
		}
	}
}