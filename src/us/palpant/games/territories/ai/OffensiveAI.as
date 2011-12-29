package us.palpant.games.territories.ai {
	import us.palpant.games.players.PlayerManager;
	import us.palpant.games.territories.*;
	
	public class OffensiveAI implements ITerritoriesAI {
		
		public function OffensiveAI() { }
		
		public function get name():String { return "Offensive"; }

		public function select(model:TerritoriesModel, playerManager:PlayerManager):Territory {
			
			var potentialSelections:Array = new Array();
			var highestDelta:uint = 0;
			
			for each(var row:Array in model) {
				for each(var territory:Territory in row) {
					
					if(!territory.selected) {
						var offensiveDelta:uint = model.getPotentialDelta(territory, playerManager.currentPlayer);
						
						if(offensiveDelta > highestDelta) {
							highestDelta = offensiveDelta;
							
							potentialSelections = new Array();
							potentialSelections.push(territory);
						} else if(offensiveDelta == highestDelta) {
							potentialSelections.push(territory);
						}
					}
					
				}
			}
			
			if(potentialSelections.length > 0) {
				var random:uint = Math.floor(Math.random() * potentialSelections.length);
				return potentialSelections[random];
			}
			
			// Backup
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