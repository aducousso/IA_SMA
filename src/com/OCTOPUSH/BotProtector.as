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
			super(_type);
			trace("Protector");
		}
		
		override public function Update() : void {
			var p:Point = new Point(Math.floor(Math.random() * 10 - 5), Math.floor(Math.random() * 10 - 5));
			p.normalize(1);
			direction = p;
			//this.color = 300;
			super.Update();
			//this.graphics.beginFill(0x00FFFF);
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