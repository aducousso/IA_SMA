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
	public class BotExplorer extends SuperBot
	{
		public static const EXPLORER_INIT_POSITION:Point = new Point(29,29);
		
		
		public function BotExplorer(_type:AgentType)
		{
			super(_type);
			this.graphics.beginFill(0x00FFFF);			
		}
		
		override public function Update() : void {
			moveAt(EXPLORER_INIT_POSITION);
			super.Update();
		}
		
		// générer un tableau de point qui représente le parcours des bots
		public function GenerateMyWay(): Array {
			return null;
		}
	}

}