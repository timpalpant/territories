package us.palpant.games.boards.gridBoardClasses {
	import flash.events.MouseEvent;
	
	import mx.containers.GridItem;
	import mx.events.ListEvent;

	public class GridBoardItem extends GridItem {
		
		public var rowIndex:uint;
		public var columnIndex:uint;
		public var itemClickEnabled:Boolean;
		
		public function GridBoardItem(rowIndex:uint = 0, columnIndex:uint = 0) {
			super();
			
			this.rowIndex = rowIndex;
			this.columnIndex = columnIndex;
			
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		/**
		 * Catches the MouseEvent.CLICK on this cell in the grid and 
		 * dispatches a ListEvent.ITEM_CLICK so it can be
		 * targeted individually and the rowIndex, columnIndex sent
		 * @param event
		 * 
		 */
		private function onClick(event:MouseEvent):void {
			if(itemClickEnabled) {
				dispatchSelectionEvent();
			}
		}
		
		/**
		 * Dispatches a ListEvent.ITEM_CLICK from this territory
		 * with its coordinates 
		 * 
		 */
		public function dispatchSelectionEvent():void {
			dispatchEvent(new ListEvent(ListEvent.ITEM_CLICK, true, false, columnIndex, rowIndex));
		}
	}
}