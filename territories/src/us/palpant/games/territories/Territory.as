package us.palpant.games.territories {
	import us.palpant.games.players.Player;
	
	public class Territory {
		
		/**
		 * References to the row and column this territory represents 
		 */
		public var rowIndex:uint;
		public var columnIndex:uint;
		
		/**
		 * The player who controls this territory, if any 
		 */
		public var owner:Player;
		
		/**
		 * Whether or not this territory has an owner
		 */
		public function get selected():Boolean { return owner != null; }
		
		/**
		 * The current value of this territory 
		 */
		public var score:uint = 0;
		
		public function Territory(rowIndex:uint = 0, columnIndex:uint = 0) {
			super();
			
			this.rowIndex = rowIndex;
			this.columnIndex = columnIndex;
		}

	}
}