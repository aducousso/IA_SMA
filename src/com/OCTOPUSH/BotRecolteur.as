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
	
		
		
		
	override public function onAgentCollide(_event:AgentCollideEvent) : void {
			var collidedAgent:Agent = _event.GetAgent();
			
			if (IsCollided(collidedAgent)) {
				//trace('boum');
			} else {
				if (collidedAgent.GetType() == AgentType.AGENT_RESOURCE) {
					var ress:Resource = (collidedAgent as Resource);
					
					//trace('RESSOURCE');
				} else if (collidedAgent.GetType() == AgentType.AGENT_BOT_HOME) {
					//trace('MAISON');
				} else {
					if (collidedAgent.GetType() == TwitedEquipeBot.BOT_RECOLTEUR) {
						//trace('COPAIN');
						var bot: BotRecolteur = (collidedAgent as BotRecolteur);
						if (bot.getBotDerriere() == null) {
							this.botDevant = bot;
							bot.setBotDerrier(this);
							var point: Point = new Point(0, 0);
							this.SetTargetPoint(point);
						}
						
					} else {
						//trace('ENNEMI');
					}
				}
			}
		}
	}
}
