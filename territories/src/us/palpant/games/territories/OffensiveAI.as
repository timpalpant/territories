package us.palpant.games.territories {
	import us.palpant.games.players.Player;
	
	public class OffensiveAI implements ITerritoriesAI {
		
		public function OffensiveAI() { }
		
		public function get name():String { return "Offensive"; }

		public function select(model:TerritoriesModel, player:Player):Territory {
			
			var highestPotential:Territory;
			var highestDelta:uint = 0;
			
			for each(var row:Array in model) {
				for each(var territory:Territory in row) {
					
					if(!territory.selected) {
						var deltaScore:uint = model.getPotentialDelta(territory, player);
						
						if(deltaScore > highestDelta) {
							highestPotential = territory;
							highestDelta = deltaScore;
						}
					}
					
				}
			}
			
			if(highestPotential)
				return highestPotential;
			else
				return totalRandom(model);
	
		}
		
		private function totalRandom(model:TerritoriesModel):Territory {
			// Randomly select a grid index
			var randomRow:uint = Math.floor(Math.random() * model.length);
			var randomColumn:uint = Math.floor(Math.random() * (model[0] as Array).length);
			var potentialSelection:Territory = model[randomRow][randomColumn] as Territory;
			
			// If that index is not selected, return it
			if(!potentialSelection.selected)
				return potentialSelection;
				
			// Otherwise, try again
			return totalRandom(model);
		}

	}
}