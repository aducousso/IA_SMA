package com.OCTOPUSH 
{
	import com.novabox.MASwithTwoNests.Agent;
	import com.novabox.MASwithTwoNests.BotHome;
	import com.novabox.MASwithTwoNests.Resource;
	import flash.geom.Point;
	/**
	 * ...
	 * @author ADB
	 */
	public class TentacleInfo 
	{
		private var botsOfTheTentacle:Array;
		private var positionOfTheRoot:Point;
		private var positionOfTheExtremity:Point;
		private var theRootResource:Agent;
		private var theTargetResource:Agent;
		private var brokenOrder:Boolean;
		private var dropTarget:Boolean;
		private var distanceBetweenTowBots:Number;
		private var bestResourceSeen:Agent;
		private var rotationAngle:Number = 0;
		
		public function TentacleInfo() 
		{
			
		}
		
		public function init(byTheRootBot:SuperBot, andTheRootResource:Agent) : void
		{
			botsOfTheTentacle = new Array(byTheRootBot);
			theRootResource = andTheRootResource;
			positionOfTheRoot = new Point(byTheRootBot.x, byTheRootBot.y);
			positionOfTheExtremity = new Point(byTheRootBot.x, byTheRootBot.y);
			brokenOrder = false;
			distanceBetweenTowBots = byTheRootBot.GetPerceptionRadius() * 0.75;
		}
		
		public function getBotsOfTheTentacle():Array 
		{
			return botsOfTheTentacle;
		}
		
		public function getTheExtremityBot() : SuperBot
		{
			return botsOfTheTentacle[botsOfTheTentacle.length - 1];
		}
		
		public function setBotsOfTheTentacle(value:Array):void 
		{
			botsOfTheTentacle = value;
		}
		
		public function getThePreviousBotOf(him:SuperBot) : SuperBot
		{
			if(botsOfTheTentacle.indexOf(him) > 0)
				return botsOfTheTentacle[botsOfTheTentacle.indexOf(him) - 1];
				
			return null;
		}
		
		public function getTheNextBotOf(him:SuperBot) : SuperBot
		{
			if(botsOfTheTentacle.indexOf(him) < botsOfTheTentacle.length)
				return botsOfTheTentacle[botsOfTheTentacle.indexOf(him) + 1];
				
			return null;
		}
		
		public function getTheRoot() : SuperBot
		{
			return (botsOfTheTentacle[0] as SuperBot);
		}
		
		public function getTheRootResource() : Agent
		{
			return theRootResource;
		}
		
		public function setTheRootResource(_value:Agent):void
		{
			theRootResource = _value;
		}
		
		public function getTheHead() : SuperBot
		{
			return (botsOfTheTentacle[botsOfTheTentacle.length - 1] as SuperBot);
		}
		
		public function getTheTargetResource() : Agent
		{
			return theTargetResource;
		}
		
		public function setTheTargetResource(_aResource:Agent) :void
		{
			theTargetResource = _aResource;
		}
		
		public function CalculateTheMaxSize() : Number
		{
			return (botsOfTheTentacle.length - 1) * (botsOfTheTentacle[0] as SuperBot).GetPerceptionRadius();
		}
		
		public function CalculateDistanceBetweenTwoBots() : Number
		{
			if (theTargetResource == null)
				return ((botsOfTheTentacle[0] as SuperBot).GetPerceptionRadius() - 1);
			else
				return (distanceBetweenTwoPoints(new Point(theTargetResource.x, theTargetResource.y), new Point(theRootResource.x, theRootResource.y)) / botsOfTheTentacle.length);
		}
		
		public function CalculateSizeOfTheTentacle() : Number
		{
			return (distanceBetweenTwoPoints(new Point(getTheHead().x, getTheHead().y), new Point(theRootResource.x, theRootResource.y)));
		}
		
		public function distanceBetweenTwoPoints(_firstPoint:Point, _secondPoint:Point) : Number
		{
			return Math.sqrt(Math.pow((_firstPoint.x - _secondPoint.x), 2) + Math.pow((_firstPoint.y - _secondPoint.y), 2));
		}
		
		public function RAZbestResourceSeen():void
		{
			bestResourceSeen = null;
		}
		
		public function getBestResourceSeen():Agent
		{
			return bestResourceSeen;
		}
		
		public function MaJBestResourceSeen(aResourceSeen:Agent) : void
		{
			if (aResourceSeen != theRootResource) {
				if ((aResourceSeen is BotHome))
					bestResourceSeen = aResourceSeen;
				else if ((bestResourceSeen == null) && (aResourceSeen is Resource) && ((aResourceSeen as Resource).GetLife() > 0) )
					bestResourceSeen = aResourceSeen;
				else if ((aResourceSeen is Resource) && (bestResourceSeen is Resource) && ((aResourceSeen as Resource).GetLife() > (bestResourceSeen as Resource).GetLife() ) )
					bestResourceSeen = aResourceSeen;
			}
		}
		
		public function getRotationAngle():Number 
		{
			return rotationAngle;
		}
		
		public function setRotationAngle(value:Number):void 
		{
			rotationAngle = value;
		}
	}

}