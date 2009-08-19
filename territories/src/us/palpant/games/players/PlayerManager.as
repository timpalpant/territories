package us.palpant.games.players {
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.core.Application;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	import us.palpant.games.players.playerManagerClasses.PlayerManagerWindow;
	import us.palpant.games.territories.ai.DefensiveAI;
	import us.palpant.games.territories.ai.OffensiveAI;
	import us.palpant.games.territories.ai.RandomAI;
	import us.palpant.utils.PseudoRandomColor;
	
	/**
	 * Manages players in a game 
	 * @author timpalpant
	 * 
	 */
	public class PlayerManager extends EventDispatcher {
		
		/**
		 * Collection of players in the game 
		 */
		private var _players:ArrayCollection = new ArrayCollection();
		
		public function get players():ArrayCollection { return _players; }
		
		/**
		 * The current player (player whose turn it is) 
		 */
		private var _currentPlayer:Player;
		
		[Bindable]
		public function get currentPlayer():Player { return _currentPlayer; }
		
		public function set currentPlayer(player:Player):void {
			_currentPlayer = player;
			_currentPlayerIndex = players.getItemIndex(player);
		}
		
		/**
		 * Index of the current player in the players array 
		 */
		private var _currentPlayerIndex:uint = 0;
		
		public function get currentPlayerIndex():uint { return _currentPlayerIndex; }
		
		/**
		 * The max number of players allowed in this game 
		 */
		private var _maxPlayers:uint;
		
		public function get maxPlayers():uint { return _maxPlayers; }
		
		/**
		 * Collection of AIs available to computer players
		 */
		private var _AIs:ArrayCollection = new ArrayCollection();
		
		public function get AIs():ArrayCollection { return _AIs; }
		
		/**
		 * TitleWindow which allows visual player management 
		 */
		private var _managerWindow:PlayerManagerWindow;
		
		
		/**
		 * Constructor 
		 * @param maxPlayers number of people that can play the game
		 * 
		 */
		public function PlayerManager(maxPlayers:uint = 2) {
			_maxPlayers = maxPlayers;
			
			_AIs.addItem(new RandomAI());
			_AIs.addItem(new OffensiveAI());
			_AIs.addItem(new DefensiveAI());
		}
		
		/**
		 * Adds a player to the game with an (optionally) specified name
		 * Auto-generates an appropriate color, cycling through blue/green/red
		 * @return the newly added player
		 * 
		 */
		public function add(type:String, name:String = null):Player {
			// Rotate player color (blue, green, red)
			var playerColor:uint;
			switch(players.length % 3) {
				case 0: playerColor = PseudoRandomColor.blue();
					break;
				case 1: playerColor = PseudoRandomColor.green();
					break;
				case 2: playerColor = PseudoRandomColor.red();
					break;
			}
			
			// Instantiate a new player and add it to the collection of players
			var player:Player = new Player(players.length, type, name, playerColor);
			players.addItem(player);
			
			return player;
		}
		
		/**
		 * Rotates the current player
		 * @return the new active player
		 * 
		 */
		public function next():Player {
			_currentPlayerIndex++;
			
			// Cycle back around
			if(_currentPlayerIndex >= players.length)
				_currentPlayerIndex = 0;
				
			currentPlayer = players.getItemAt(_currentPlayerIndex) as Player;
			
			return currentPlayer;
		}
		
		/**
		 * Visually manage players with a modal popup 
		 */
		public function showWindow():void {
			_managerWindow = PopUpManager.createPopUp(Application.application as DisplayObject, PlayerManagerWindow, true) as PlayerManagerWindow;
			_managerWindow.playerManager = this;
			
			_managerWindow.addEventListener(CloseEvent.CLOSE, onManagerWindowClose);
		}
		
		private function onManagerWindowClose(event:CloseEvent):void {
			PopUpManager.removePopUp(_managerWindow);
			
			// Randomly select who goes first
			_currentPlayerIndex = Math.round(Math.random() * (players.length-1));
			currentPlayer = players.getItemAt(_currentPlayerIndex) as Player;
			
			// Dispatch an event to signal that players are set up
			dispatchEvent(new Event(Event.CLOSE));
		}
	}
}