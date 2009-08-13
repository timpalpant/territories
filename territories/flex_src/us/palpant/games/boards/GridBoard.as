package us.palpant.games.boards {
	import flash.events.MouseEvent;
	
	import mx.events.ListEvent;
	import mx.containers.Grid;
	
	import us.palpant.games.boards.gridBoardClasses.*;
	
	[Event(name="itemClick", type="mx.events.ListEvent")]
	
	/**
	 * Souped up Grid that fires ListEvent.ITEM_CLICK when
	 * a GridItem is clicked with its row and column index
	 * @author timpalpant
	 * 
	 */
	public class GridBoard extends Grid {
		
		[Bindable] public var rows:uint;
		[Bindable] public var columns:uint;
		
		public function GridBoard() {
			super();
		}
		
		override protected function createChildren():void {
			super.createChildren();
			
			// Create rows
			for(var i:int = 0; i < rows; i++) {
				var gridRow:GridBoardRow = new GridBoardRow(i);
				gridRow.percentHeight = 100;
				gridRow.percentWidth = 100;
				addChild(gridRow);
				
				// Create columns
				for(var j:int = 0; j < columns; j++) {
					var gridItem:GridBoardItem = new GridBoardItem(i, j);
					gridItem.percentHeight = 100;
					gridItem.percentWidth = 100;
					gridItem.addEventListener(MouseEvent.CLICK, onGridItemClick);
					gridRow.addChild(gridItem);
				}
			}
		}
		
		/**
		 * Catches the MouseEvent.CLICK on individual cells in the grid and 
		 * dispatches a ListEvent.ITEM_CLICK so the individual GridItem can be
		 * targeted and the rowIndex, columnIndex sent
		 * @param event
		 * 
		 */
		private function onGridItemClick(event:MouseEvent):void {
			var gridItem:GridBoardItem = event.currentTarget as GridBoardItem;
			
			gridItem.dispatchEvent(new ListEvent(ListEvent.ITEM_CLICK, true, false, gridItem.columnIndex, gridItem.rowIndex));
		}
	}
}