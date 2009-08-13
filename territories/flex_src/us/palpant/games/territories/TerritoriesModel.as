package us.palpant.games.territories {
	import us.palpant.games.players.Player;

	public class TerritoriesModel extends Array {
		
		public function TerritoriesModel() {
			super(10);
			
			for(var i:uint = 0; i < 10; i++) {
				var row:Array = new Array();
				push(row);
				
				for(var j:uint = 0; j < 10; j++) {
					row.push(new Territory(i, j));
				}
			}
		}
		
		public function onGrid(rowIndex:uint, columnIndex:uint):Boolean {
			return (rowIndex < this.length) && (columnIndex < this[0].length);
		}
	}
}