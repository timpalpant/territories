package us.palpant.games.territories {
	import us.palpant.games.players.Player;

	/**
	 * Data model for the Territories board
	 * (curse Adobe for making the Vector class final)
	 * @author timpalpant
	 * 
	 */
	public dynamic class TerritoriesModel extends Array {
		
		private var _rows:uint;
		private var _columns:uint;
		
		public function TerritoriesModel(rows:uint, columns:uint) {
			super();
			
			_rows = rows;
			_columns = columns;
			
			for(var i:uint = 0; i < rows; i++) {
				var row:Array = new Array();
				push(row);
				
				for(var j:uint = 0; j < columns; j++) {
					row.push(new Territory(i, j));
				}
			}
		}
		
		/**
		 * Checks to see if a coordinate is within the territories model 
		 * @param rowIndex
		 * @param columnIndex
		 * @return whether or not the territory is valid
		 * 
		 */
		public function contains(row:uint, column:uint):Boolean {
			return (row < _rows) && (column < _columns);
		}
		
		/**
		 * Computes the score/value of an indexed location (territory)
		 * @param row
		 * @param column
		 * @return the point value of the indexed territory
		 * 
		 */
		private function getIndexScore(row:uint, column:uint):uint {
			if(!contains(row, column))
				return 0;
			
			var territory:Territory = this[row][column] as Territory;
			
			// TODO: This could be more elegant...?
			var score:uint = 0;
			if(contains(row+1, column) && territory.owner == (this[row+1][column] as Territory).owner)
				score++;
			if(contains(row-1, column) && territory.owner == (this[row-1][column] as Territory).owner)
				score++;
			if(contains(row, column+1) && territory.owner == (this[row][column+1] as Territory).owner)
				score++;
			if(contains(row, column-1) && territory.owner == (this[row][column-1] as Territory).owner)
				score++;
			
			return score;
		}
		
		/**
		 * Computes the point value of a territory 
		 * @param territory
		 * @return the territory's score
		 * 
		 */
		private function getTerritoryScore(territory:Territory):uint {
			return getIndexScore(territory.rowIndex, territory.columnIndex);
		}
		
		/**
		 * Computes the score of an individual player across the board
		 * @param player
		 * @return 
		 * 
		 */
		private function getPlayerScore(player:Player):uint {
			var score:uint = 0;
			
			for each(var row:Array in this) {
				for each(var territory:Territory in row) {
					if(territory.owner == player)
						score += getTerritoryScore(territory);
				}
			}
			
			return score;
		}
		
		/**
		 * Gets the score of a player, territory, or location on the board
		 * (please implement overloading in AS4)
		 * @param args
		 * @return 
		 * 
		 */
		public function getScore(...args):uint {
			var n:uint = args.length;
			
			if(n == 1) {
				if(args[0] is Player)
					return getPlayerScore(args[0]);
				
				if(args[0] is Territory)
					return getTerritoryScore(args[0]);
			}
			
			if(n == 2 && (args[0] is uint) && (args[1] is uint))
				return getIndexScore(args[0], args[1]);
			
			return 0;
		}
	}
}