package us.palpant.games.territories {
	import us.palpant.games.players.Player;
	

	public class DefensiveAI implements ITerritoriesAI {
		
		public function DefensiveAI() { }
		
		public function get name():String { return "Defensive"; }

		public function select(model:TerritoriesModel, player:Player):Territory {
			
			var potentialSelections:Array = new Array();
			
			for each(var row:Array in model) {
				for each(var territory:Territory in row) {
					
					// Target territories selected by other players
					if(territory.selected && territory.owner != player) {
						if(model.contains(territory.rowIndex+1, territory.columnIndex) && 
							!(model[territory.rowIndex+1][territory.columnIndex] as Territory).selected) {
							
							potentialSelections.push(model[territory.rowIndex+1][territory.columnIndex]);
							
						} else if(model.contains(territory.rowIndex-1, territory.columnIndex) && 
							!(model[territory.rowIndex-1][territory.columnIndex] as Territory).selected) {
							
							potentialSelections.push(model[territory.rowIndex-1][territory.columnIndex]);
							
						} else if(model.contains(territory.rowIndex, territory.columnIndex+1) && 
							!(model[territory.rowIndex][territory.columnIndex+1] as Territory).selected) {
							
							potentialSelections.push(model[territory.rowIndex][territory.columnIndex+1]);
							
						} else if(model.contains(territory.rowIndex, territory.columnIndex-1) && 
							!(model[territory.rowIndex][territory.columnIndex-1] as Territory).selected) {
							
							potentialSelections.push(model[territory.rowIndex][territory.columnIndex-1]);
						}
					}
					
				}
			}
			
			if(potentialSelections.length > 0) {
				var random:uint = Math.floor(Math.random() * potentialSelections.length);
				return potentialSelections[random];
			} else {
				return totalRandom(model);	
			}	
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