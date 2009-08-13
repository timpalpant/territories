package us.palpant.utils {
	import flash.geom.ColorTransform;
	
	public class PseudoRandomColor {

		/**
		 * Generates a pseudo-random, red-biased color 
		 * @return pseudo-random color (uint)
		 * 
		 */
		public static function red():uint {	
			return generate(255, 0, 0);
		}
		
		/**
		 * Generates a pseudo-random, green-biased color 
		 * @return pseudo-random color (uint)
		 * 
		 */
		public static function green():uint {
			return generate(0, 255, 0);
		}
		
		/**
		 * Generates a pseudo-random, blue-biased color 
		 * @return pseudo-random color (uint)
		 * 
		 */
		public static function blue():uint {
			return generate(0, 0, 255);
		}
		
		/**
		 * Generates a pseudo-random (biased) color 
		 * @param redBias multiplier for redOffset (0-255)
		 * @param greenBias multiplier for greenOffset (0-255)
		 * @param blueBias multiplier for blueOffset (0-255)
		 * @return psuedo-random color (uint)
		 * 
		 */
		public static function generate(redBias:Number, greenBias:Number, blueBias:Number):uint {
			var ct:ColorTransform = new ColorTransform(1, 1, 1, 1, Math.random() * redBias, Math.random() * greenBias, Math.random() * blueBias);
			return ct.color;
		}
	}
}