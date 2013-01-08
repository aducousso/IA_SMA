package com.OCTOPUSH 
{
	import com.novabox.MASwithTwoNests.Agent;
	import com.novabox.MASwithTwoNests.AgentCollideEvent;
	import com.novabox.MASwithTwoNests.AgentType;
	import com.novabox.MASwithTwoNests.Bot;
	import com.novabox.MASwithTwoNests.Resource;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BotRecolteur extends Bot
	{
		private var botDevant : Bot = null;
		private var botDerriere: BotRecolteur = null;
	
		public function BotRecolteur(_type:AgentType)  
		{
			//trace('BotRecolteur');
			super(_type);
		}
		public function getBotDevant() : Bot {
			return botDevant;
		}
		public function getBotDerriere() : BotRecolteur {
			return botDerriere;
		}
		public function setBotDevant(value:Bot) : void {
			this.botDevant = value;
		}
		public function setBotDerrier(value:BotRecolteur) : void {
			this.botDerriere = value;
		}
	}
}
