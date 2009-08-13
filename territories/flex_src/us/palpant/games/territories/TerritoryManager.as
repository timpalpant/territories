package us.palpant.games.territories {
	import us.palpant.games.players.Player;

	public class TerritoryManager {
		
		private var model:TerritoriesModel;
		
		public function TerritoryManager() {
			model = new TerritoriesModel();
		}
		
		public function getTerritoryScore(row:uint, column:uint):uint {
			if(row >= model.length || column >= model[0].length)
				return -1;
			
			var territory:Territory = model[row][column] as Territory;
			
			// TODO: This could be more elegant...
			var score:uint = 0;
			if(territory.owner = (model[row+1][column] as Territory).owner)
				score++;
			if(territory.owner = (model[row-1][column] as Territory).owner)
				score++;
			if(territory.owner = (model[row][column+1] as Territory).owner)
				score++;
			if(territory.owner = (model[row][column-1] as Territory).owner)
				score++;
			
			return score;
		}

		public function setSelected(row:uint, column:uint, player:Player):void {
			var territory:Territory = model[row][column] as Territory;
			territory.owner = player;
		}
	}
}