package us.palpant.games.boards.gridBoardClasses {
	import mx.containers.GridRow;

	public class GridBoardRow extends GridRow {
		
		public var index:uint;
		
		public function GridBoardRow(index:uint = 0) {
			super();
			
			this.index = index;
		}

	}
}