package us.palpant.games.territories.ai {
	import us.palpant.games.players.PlayerManager;
	import us.palpant.games.players.Player;
	import us.palpant.games.territories.*;

	public class ComboAI implements ITerritoriesAI {
		
		private var _potentialSelections:Array = new Array();
		private var _highestDelta:uint = 0;
		
		public function ComboAI() { }

		public function get name():String { return "Combo"; }

		public function select(model:TerritoriesModel, playerManager:PlayerManager):Territory {

			var potentialSelections:Array = new Array();
			var highestDelta:uint = 0;
			
			for each(var row:Array in model) {
				for each(var territory:Territory in row) {
					
					if(!territory.selected) {
						var totalDelta:uint = 0;
						
						for each(var player:Player in playerManager.players)
							totalDelta += model.getPotentialDelta(territory, player);
						
						if(totalDelta > highestDelta) {
							highestDelta = totalDelta;
							
							potentialSelections = new Array();
							potentialSelections.push(territory);
						} else if(totalDelta == highestDelta) {
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