package us.palpant.games.territories {

	public interface ITerritoriesAI {
		
		/**
		 * Determine a selection on the board 
		 * @param model the TerritoriesModel to choose on
		 * @return the selected Territory
		 * 
		 */
		function select(model:TerritoriesModel):Territory;
		
	}
}