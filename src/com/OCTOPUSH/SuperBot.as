package com.OCTOPUSH 
{
	import com.novabox.MASwithTwoNests.AgentType;
	import com.novabox.MASwithTwoNests.Bot;
	import flash.geom.Point;
	import com.novabox.MASwithTwoNests.TimeManager;
	/**
	 * ...
	 * @author ADB
	 */
	public class SuperBot extends Bot
	{
		
		public function SuperBot(_type:AgentType) 
		{
			super(_type);
		}
		
		public function moveAt(_thisPoint:Point) : void {
			var pixelByFrame:Number = this.speed / (TimeManager.timeManager.GetFrameDeltaTime());
			var distanceBetweenMeAndDirection:Number;
			distanceBetweenMeAndDirection = Math.sqrt(Math.pow((this.x - _thisPoint.x), 2) + Math.pow((this.y - _thisPoint.y), 2));
			if ((distanceBetweenMeAndDirection > pixelByFrame) || (pixelByFrame == Infinity)) {
				
				direction = _thisPoint.subtract(targetPoint);
				direction.normalize(1);
			}else {
				this.x = _thisPoint.x;
				this.y = _thisPoint.y;
				direction.x = 0;
				direction.y = 0;
				trace("je suis arrivé");
			}
		}
	}

}