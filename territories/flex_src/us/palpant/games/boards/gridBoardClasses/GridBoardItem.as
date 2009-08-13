package us.palpant.games.boards.gridBoardClasses {
	import mx.containers.GridItem;

	public class GridBoardItem extends GridItem {
		
		public var rowIndex:uint;
		public var columnIndex:uint;
		
		public function GridBoardItem(rowIndex:uint = 0, columnIndex:uint = 0) {
			super();
			
			this.rowIndex = rowIndex;
			this.columnIndex = columnIndex;
		}

	}
}