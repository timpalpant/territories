package us.palpant.games.territories {
	import us.palpant.games.players.Player;

	public class TerritoriesModel extends Array {
		
		private var _help:Boolean;
		
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
		
		public function getScore(row:uint, column:uint):String {
			var territory:Territory = this[row][column] as Territory;

			

			return territory.owner.name;
		}

		public function setSelected(player:Player, row:uint, column:uint):void {
			var territory:Territory = this[row][column] as Territory;
			territory.owner = player;
		}
	}
}