package us.palpant.games.territories.ai {
	import us.palpant.games.players.Player;
	import us.palpant.games.territories.*;

	public interface ITerritoriesAI {
		
		/**
		 * Returns the AI's identifier 
		 * @return user-friendly name
		 * 
		 */
		function get name():String;
		
		/**
		 * Determine a selection on the board 
		 * @param model the TerritoriesModel to choose on
		 * @param player the current Player
		 * @return the selected Territory
		 * 
		 */
		function select(model:TerritoriesModel, player:Player):Territory;
		
	}
}