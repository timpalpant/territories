import flash.events.Event;

import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.events.ListEvent;

import us.palpant.games.boards.gridBoardClasses.GridBoardItem;
import us.palpant.games.boards.gridBoardClasses.GridBoardRow;
import us.palpant.games.players.Player;
import us.palpant.games.players.PlayerManager;
import us.palpant.games.territories.DefensiveAI;
import us.palpant.games.territories.ITerritoriesAI;
import us.palpant.games.territories.RandomAI;
import us.palpant.games.territories.TerritoriesModel;
import us.palpant.games.territories.Territory;
import us.palpant.games.territories.OffensiveAI;

// Player manager and game model
[Bindable] private var playerManager:PlayerManager;
[Bindable] private var model:TerritoriesModel;

// AIs
[Bindable] private var computerAIs:ArrayCollection;
[Bindable] private var currentAI:ITerritoriesAI;


private function onCreationComplete():void {
	// Set up players
	playerManager = new PlayerManager(4);
	playerManager.addEventListener(Event.CLOSE, onPlayerSetUp);
	playerManager.showWindow();
	
	// Set up the model
	model = new TerritoriesModel(gameBoard.rows, gameBoard.columns);
	
	// Set up AIs
	var defensiveAI:ITerritoriesAI = new DefensiveAI();
	var randomAI:ITerritoriesAI = new RandomAI();
	var offensiveAI:ITerritoriesAI = new OffensiveAI();

	computerAIs = new ArrayCollection();
	computerAIs.addItem(defensiveAI);
	computerAIs.addItem(randomAI);
	computerAIs.addItem(offensiveAI);
	
	currentAI = offensiveAI;
}

private function onPlayerSetUp(event:Event):void {
	// If the first player is a computer, move
	if(playerManager.currentPlayer.type == Player.COMPUTER)
		computerMove();
}

private function onAIChange(event:ListEvent):void {
	currentAI = event.currentTarget.selectedItem;
}

private function computerMove():void {
	var computerSelection:Territory = currentAI.select(model, playerManager.currentPlayer);

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

private function newGame():void {
	// Reset the board
	for each(var row:GridBoardRow in gameBoard.getChildren()) {
		for each(var item:GridBoardItem in row.getChildren()) {
			item.setStyle("backgroundColor", "white");
			item.itemClickEnabled = true;
		}
	}
	
	// Restart the game
	onCreationComplete();

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
	
	if(winner)
		Alert.show(winner.name + " wins!", "Game over");
}