package us.palpant.games.territories {

	public class BlockerAI implements ITerritoriesAI {
		
		public var target:String;
		
		public function BlockerAI() {
		}
		
		public function get name():String { return "Blocker"; }

		public function select(model:TerritoriesModel):Territory {
			
			for each(var row:Array in model) {
				for each(var territory:Territory in row) {
					
					if(territory.selected && territory.owner.name == target) {
						if(model.contains(territory.rowIndex+1, territory.columnIndex) && 
							!(model[territory.rowIndex+1][territory.columnIndex] as Territory).selected) {
							
							return model[territory.rowIndex+1][territory.columnIndex];
							
						} else if(model.contains(territory.rowIndex-1, territory.columnIndex) && 
							!(model[territory.rowIndex-1][territory.columnIndex] as Territory).selected) {
							
							return model[territory.rowIndex-1][territory.columnIndex];
							
						} else if(model.contains(territory.rowIndex, territory.columnIndex+1) && 
							!(model[territory.rowIndex][territory.columnIndex+1] as Territory).selected) {
							
							return model[territory.rowIndex][territory.columnIndex+1];
							
						} else if(model.contains(territory.rowIndex, territory.columnIndex-1) && 
							!(model[territory.rowIndex][territory.columnIndex-1] as Territory).selected) {
							
							return model[territory.rowIndex][territory.columnIndex-1];
						}
					}
					
				}
			}
			
			return randomBackup(model);			
		}
		
		private function randomBackup(model:TerritoriesModel):Territory {
			// Randomly select a grid index
			var randomRow:uint = Math.floor(Math.random() * model.length);
			var randomColumn:uint = Math.floor(Math.random() * (model[0] as Array).length);
			var potentialSelection:Territory = model[randomRow][randomColumn] as Territory;
			
			// If that index is not selected, return it
			if(!potentialSelection.selected)
				return potentialSelection;
				
			// Otherwise, try again
			return select(model);
		}

	}
}