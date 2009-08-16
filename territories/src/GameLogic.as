import mx.events.ListEvent;
import mx.controls.Alert;

import us.palpant.games.players.Player;
import us.palpant.games.players.PlayerManager;

import us.palpant.games.territories.Territory;
import us.palpant.games.territories.TerritoriesModel;

import us.palpant.games.territories.ITerritoriesAI;
import us.palpant.games.territories.RandomAI;

import us.palpant.games.boards.gridBoardClasses.GridBoardRow;
import us.palpant.games.boards.gridBoardClasses.GridBoardItem;


[Bindable] private var playerManager:PlayerManager;
[Bindable] private var model:TerritoriesModel;
[Bindable] private var computerAI:ITerritoriesAI;


private function onCreationComplete():void {
	playerManager = new PlayerManager(4);
	playerManager.addEventListener(Event.CLOSE, onPlayerSetUp);
	playerManager.showWindow();
	
	model = new TerritoriesModel(gameBoard.rows, gameBoard.columns);
	
	computerAI = new RandomAI();
}

private function onPlayerSetUp(event:Event):void {
	if(playerManager.currentPlayer.type == Player.COMPUTER)
		computerMove();
}

private function computerMove():void {
	var computerSelection:Territory = computerAI.select(model);
	
	var selectedItem:GridBoardItem = (gameBoard.getChildAt(computerSelection.rowIndex) as GridBoardRow).getChildAt(computerSelection.columnIndex) as GridBoardItem;
	selectedItem.dispatchSelectionEvent();
}

private function onGridItemClick(event:ListEvent):void {
	// Change the board to reflect the color of the owner and disable item click
	var gridItem:GridBoardItem = event.target as GridBoardItem;
	gridItem.setStyle("backgroundColor", playerManager.currentPlayer.color);
	gridItem.itemClickEnabled = false;
	
	// Mark the territory owner in the model
	var territory:Territory = model[event.rowIndex][event.columnIndex] as Territory;
	territory.owner = playerManager.currentPlayer;
	
	// Update the score of the current player
	playerManager.currentPlayer.score = model.getScore(playerManager.currentPlayer);
	
	// Check if the game is over
	if(model.full) {
		endGame();
		return;
	}
	
	// Change to the next player
	playerManager.next();
	
	if(playerManager.currentPlayer.type == Player.COMPUTER)
		computerMove();
}

private function endGame():void {
	var winner:Player;
	var highScore:Number = 0;

	for each(var player:Player in playerManager.players) {
		if(player.score > highScore) {
			winner = player;
			highScore = player.score;
		}
	}
	
	Alert.show(winner.name + " wins!", "Game over");
}