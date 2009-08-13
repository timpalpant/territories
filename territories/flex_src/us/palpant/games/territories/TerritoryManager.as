package us.palpant.games.territories {
	import us.palpant.games.players.Player;
	

	public class TerritoryManager {
		
		private var territoryArray:Array = new Array();
		
		public function TerritoryManager() {
			for(var i:uint = 0; i < 10; i++) {
				var row:Array = new Array();
				territoryArray.push(row);
				
				for(var j:uint = 0; j < 10; j++) {
					row.push(new Territory(i, j));
				}
			}
		}
		
		public function getItemScore(row:uint, column:uint):String {
			var territory:Territory = territoryArray[row][column] as Territory;
			
			
			
			return territory.owner.name;
		}

		public function setSelected(player:Player, row:uint, column:uint):void {
			var territory:Territory = territoryArray[row][column] as Territory;
			territory.owner = player;
		}
	}
}