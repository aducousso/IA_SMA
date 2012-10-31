package com.OCTOPUSH 
{
	import com.novabox.MASwithTwoNests.Agent;
	import com.novabox.MASwithTwoNests.AgentType;
	import com.novabox.MASwithTwoNests.Bot;
	import flash.geom.Point;
	/**
	 * ...
	 * @author ADB
	 */
	public class BotExplorer extends Bot
	{
		public static const EXPLORER_INIT_POSITION:Point = new Point(50,50);
		
		
		public function BotExplorer(_type:AgentType)
		{
			super(_type);
			this.graphics.beginFill(0x00FFFF);
			trace("BotExploreur");
			
		}
		
		override public function Update() : void {
			super.Update();
		}
		
	}

}