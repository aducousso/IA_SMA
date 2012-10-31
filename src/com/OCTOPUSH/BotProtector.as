package com.OCTOPUSH 
{
	import com.novabox.MASwithTwoNests.Agent;
	import com.novabox.MASwithTwoNests.AgentCollideEvent;
	import com.novabox.MASwithTwoNests.AgentType;
	import com.novabox.MASwithTwoNests.Bot;
	import com.novabox.MASwithTwoNests.Resource;
	import flash.geom.Point;
	
	public class BotProtector extends Bot {
		
		public function BotProtector(_type:AgentType) {
			trace("BotProtector");
			super(_type);
		}
		
		override public function Update() : void {
			calculerDirectionDepuisPointDestination(new Point (300, 300));
			
			super.Update();
		}
		
		
		public function calculerDirectionDepuisPointDestination(maDestination:Point) : void {
			direction = new Point(maDestination.x - this.x, maDestination.y - this.y);
			direction.normalize(1);
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
					if (collidedAgent.GetType() == TwitedEquipeBot.BOT_PROTECTOR) {
						//trace('COPAIN');
					} else {
						//trace('ENNEMI');
					}
				}
			}
		}
	}
}