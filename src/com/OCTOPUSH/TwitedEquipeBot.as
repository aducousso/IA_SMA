package com.OCTOPUSH 
{
	import com.novabox.MASwithTwoNests.AgentType;
	
	public class TwitedEquipeBot {
		
		public static const BOT_PROTECTOR:AgentType = new AgentType(BotProtector, 0.1);
		public static const BOT_RECOLTEUR:AgentType = new AgentType(BotRecolteur, 0.9);
		
		public function TwitedEquipeBot() {
			
		}
	}
}