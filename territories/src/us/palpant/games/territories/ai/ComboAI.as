package us.palpant.games.territories.ai {
	import mx.controls.Alert;
	
	import us.palpant.games.players.Player;
	import us.palpant.games.territories.*;

	public class ComboAI implements ITerritoriesAI {
		
		private var _potentialSelections:Array = new Array();
		private var _highestDelta:uint = 0;
		
		public function ComboAI() { }

		public function get name():String { return "Combo"; }

		public function select(model:TerritoriesModel, player:Player):Territory {

			var defensiveDelta:uint;
			var offensiveDelta:uint;
			var totalDelta:uint;
			
			for each(var row:Array in model) {
				for each(var territory:Territory in row) {
					
					// Target territories selected by other players
					if(territory.selected && territory.owner != player) {
						if(model.contains(territory.rowIndex+1, territory.columnIndex)) {
							
							var down:Territory = model[territory.rowIndex+1][territory.columnIndex];
							if(!down.selected)
								examinePotentials(down, model, player);

						} else if(model.contains(territory.rowIndex-1, territory.columnIndex)) {
							
							var up:Territory = model[territory.rowIndex-1][territory.columnIndex];
							if(!up.selected)
								examinePotentials(up, model, player);
							
						} else if(model.contains(territory.rowIndex, territory.columnIndex+1)) {
							
							var right:Territory = model[territory.rowIndex][territory.columnIndex+1];
							if(!right.selected)
								examinePotentials(right, model, player);
							
						} else if(model.contains(territory.rowIndex, territory.columnIndex-1)) {
							
							var left:Territory = model[territory.rowIndex][territory.columnIndex-1];
							if(!left.selected)
								examinePotentials(left, model, player);
						}
					} else {
						totalDelta = model.getPotentialDelta(territory, player);
						
						if(totalDelta > _highestDelta) {
							_highestDelta = totalDelta;
							
							_potentialSelections = new Array();
							_potentialSelections.push(left);
						} else if(totalDelta == _highestDelta) {
							_potentialSelections.push(left);
						}
					}					
				}
			}
			
			Alert.show("Number of potential selections: " + _potentialSelections.length);
			
			if(_potentialSelections.length > 0) {
				var random:uint = Math.floor(Math.random() * _potentialSelections.length);
				return _potentialSelections[random];
			} else {
				return totalRandom(model);	
			}
		}
		
		private function examinePotentials(territory:Territory, model:TerritoriesModel, player:Player):void {
			var defensiveDelta:uint = model.getPotentialDelta(territory, territory.owner);
			var offensiveDelta:uint = model.getPotentialDelta(territory, player);
			var totalDelta:uint = defensiveDelta + offensiveDelta;
		
			if(totalDelta > _highestDelta) {
				_highestDelta = totalDelta;
				
				_potentialSelections = new Array();
				_potentialSelections.push(territory);
			} else if(totalDelta == _highestDelta) {
				_potentialSelections.push(territory);
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