package us.palpant.games.territories.ai {
	import us.palpant.games.players.PlayerManager;
	import us.palpant.games.territories.*;
	
	public class RandomAI implements ITerritoriesAI {
		
		public function RandomAI() { }
		
		public function get name():String { return "Random"; }

		/**
		 * Shiitttyy AI example 
		 * @param args the TerritoriesModel to randomly select
		 * @return the randomly selected Territory
		 * 
		 */
		public function select(model:TerritoriesModel, playerManager:PlayerManager):Territory {
			// Randomly select a grid index
			var randomRow:uint = Math.floor(Math.random() * model.length);
			var randomColumn:uint = Math.floor(Math.random() * (model[0] as Array).length);
			var potentialSelection:Territory = model[randomRow][randomColumn] as Territory;
			
			// If that index is not selected, return it
			if(!potentialSelection.selected)
				return potentialSelection;
				
			// Otherwise, try again
			return select(model, playerManager);
		}

	}
}