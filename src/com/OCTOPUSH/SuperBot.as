package com.OCTOPUSH 
{
	import com.novabox.MASwithTwoNests.AgentType;
	import com.novabox.MASwithTwoNests.Bot;
	import com.novabox.MASwithTwoNests.BotHome;
	import flash.geom.Point;
	import com.novabox.MASwithTwoNests.TimeManager;
	import com.novabox.MASwithTwoNests.Agent;
	import com.novabox.MASwithTwoNests.AgentCollideEvent;
	import com.novabox.MASwithTwoNests.AgentType;
	import com.novabox.MASwithTwoNests.Resource;
	import com.OCTOPUSH.*;
	import com.OCTOPUSH.systemExpert.*;
	
	/**
	 * ...
	 * @author ADB
	 */
	public class SuperBot extends Bot
	{
		private var updateTime:Number;
		private var seenResource:Agent;
		private var seenSomeone:Bot;
		private var takenResource:Agent;
		private var reachedResource:Agent;
		private var lastReachedResource:Agent;
		private var systemeExpert:SystemeExpert;
		private var moteurInference:MoteurInference;
		private var tentacleInfo:TentacleInfo;
		private var whereIAm:String;
		private var seeATentacle:SuperBot;
		private var delayToChangeDirection:int;
		private var rotationAngle:Number = 0;
		
		public function SuperBot(_type:AgentType) 
		{
			reachedResource = null;
			lastReachedResource = null;
			takenResource = null;
			SetResource(false);
			
			systemeExpert = null;
			
			whereIAm = null;
			
			updateTime = 0;
			
			super(_type);
		}
		
		override public function initialize(_teamId:String, _color:int, _radius:Number, _speed:Number, _directionChangeDelay:Number, _perceptionRadius:Number) : void
		{
			reachedResource = null;
			lastReachedResource = null;
			takenResource = null;
			seenResource = null;
			seenSomeone = null;
			
			updateTime = 0;
			
			InitSystemeExpert();
			
			super.initialize(_teamId, _color, _radius, _speed, _directionChangeDelay, _perceptionRadius);
		}
		
		protected function InitSystemeExpert() : void
		{
			systemeExpert = new SystemeExpert(new BaseFait(), new BaseRegle());
			systemeExpert.AddRegle(new Array(SuperFacts.NOWHERE, SuperFacts.NO_TENTACLE), SuperFacts.CHANGE_DIRECTION, 200);
			systemeExpert.AddRegle(new Array(SuperFacts.NO_TENTACLE, SuperFacts.SEE_RESOURCE), SuperFacts.GO_TO_RESOURCE, 210);
			systemeExpert.AddRegle(new Array(SuperFacts.NO_TENTACLE, SuperFacts.ALREADY_IN_RESOURCE), SuperFacts.CREATE_TENTACLE, 220);
			systemeExpert.AddRegle(new Array(SuperFacts.NO_TENTACLE, SuperFacts.AT_HOME), SuperFacts.CREATE_TENTACLE, 240);
			systemeExpert.AddRegle(new Array(SuperFacts.NO_TENTACLE, SuperFacts.SEE_TENTACLE), SuperFacts.MEET_TENTACLE, 250);
			// Mode tentacule
				// comportement ROOT
			systemeExpert.AddRegle(new Array(SuperFacts.IS_TENTACLE, SuperFacts.IS_THE_ROOT), SuperFacts.STAY_IN_THE_TENTACLE_RESOURCE, 210);
			systemeExpert.AddRegle(new Array(SuperFacts.IS_TENTACLE, SuperFacts.IS_A_LINK), SuperFacts.FOLLOW_THE_PREVIOUS, 200);
			systemeExpert.AddRegle(new Array(SuperFacts.IS_TENTACLE, SuperFacts.IS_THE_HEAD), SuperFacts.ROTATE_TENTACLE, 200);
			systemeExpert.AddRegle(new Array(SuperFacts.IS_TENTACLE, SuperFacts.SEE_TENTACLE, SuperFacts.INTEREST_MEET_OTHER_TENTACLE), SuperFacts.MEET_TENTACLE, 220);
			
		}
		
		override public function Update():void
		{
			systemeExpert.ResetFacts();
			super.Update();
			UpdateFacts(); // MAJ Faits via des variables de "perceptions"
			Infer(); // Inférer / résoudre pb de logique parallele (cas ou tu te retrouves avec deux actions possibles ...)
		 	// c est rien d'autre qu un chainage avant qui va executer tes regles
			Act(); // recoit : les actions à effectuer
		}
		
		protected function UpdateFacts() : void
		{	
			//***************************************
			//Checking if the bot has got a resource
			//***************************************
			if (HasResource())
			{
				systemeExpert.SetFactValue(SuperFacts.GOT_RESOURCE, true);
			}
			else
			{
				systemeExpert.SetFactValue(SuperFacts.NO_RESOURCE, true);				
			}
			
			//***************************************
			//Checking if it's changing direction time
			//***************************************
			updateTime += TimeManager.timeManager.GetFrameDeltaTime();
			if (updateTime > directionChangeDelay)
			{
				systemeExpert.SetFactValue(SuperFacts.CHANGE_DIRECTION_TIME, true);
				updateTime = 0;
			}
			
			//***************************************
			//Checking if a resource is seen
			//***************************************
			if (seenResource != null) 
			{
				systemeExpert.SetFactValue(SuperFacts.SEE_RESOURCE, true);

				/*if (takenResource != null)
				{		
					//***************************************
					//Checking resource size
					//***************************************
					if (seenResource.GetType() == AgentType.AGENT_RESOURCE)
					{
						if ((seenResource as Resource).GetLife() >= (takenResource.GetLife())
						{
							systemeExpert.SetFactValue(SuperFacts.BIGGER_RESOURCE, true);							
						}
						else
						{
							systemeExpert.SetFactValue(SuperFacts.SMALLER_RESOURCE, true);							
						}
					}
					/*if (seenResource.GetType() == AgentType.AGENT_BOT_HOME)
					{
						if (seenResource.GetLife() >= takenResource.GetLife())
						{
							systemeExpert.SetFactValue(SuperFacts.BIGGER_RESOURCE, true);							
						}
						else
						{
							systemeExpert.SetFactValue(SuperFacts.SMALLER_RESOURCE, true);							
						}
					}
				}*/
			}
			else
			{
				systemeExpert.SetFactValue(SuperFacts.NOTHING_SEEN, true);				
			}
			
			//***************************************
			// Checking if a resource is reached
			//***************************************
			if (reachedResource != null)
			{
				systemeExpert.SetFactValue(SuperFacts.REACHED_RESOURCE, true);
			}
			
			//***************************************
			// Checking what is my situation in the world
			//***************************************
			switch(whereIAm)
			{
				case (null) :
				systemeExpert.SetFactValue(SuperFacts.NOWHERE, true);
				break;
				case ("AtHome") :
				systemeExpert.SetFactValue(SuperFacts.AT_HOME, true);
				break;
				case ("InAResource") :
				systemeExpert.SetFactValue(SuperFacts.ALREADY_IN_RESOURCE, true);
				break;
			}
			whereIAm = null;
			
			//***************************************
			// Checking if I see a tentacle and the interest
			//***************************************
			if (seeATentacle != null) {
				systemeExpert.SetFactValue(SuperFacts.SEE_TENTACLE, true);
				
				if (tentacleInfo != null)
				{
					if (seeATentacle.tentacleInfo.getBotsOfTheTentacle.length > tentacleInfo.getBotsOfTheTentacle.length)
						systemeExpert.SetFactValue(SuperFacts.INTEREST_MEET_OTHER_TENTACLE, true);
					else if (seeATentacle.tentacleInfo.getBotsOfTheTentacle.length == tentacleInfo.getBotsOfTheTentacle.length)
						if (CalculateIfACountResourceIsHigher(seeATentacle.tentacleInfo.getTheRootResource(), tentacleInfo.getTheRootResource()))
							systemeExpert.SetFactValue(SuperFacts.INTEREST_MEET_OTHER_TENTACLE, true);
				}
			}
			
			//***************************************
			// Checking if I am a tentacle
			//***************************************
			if (tentacleInfo == null) 
				systemeExpert.SetFactValue(SuperFacts.NO_TENTACLE, true);
			else
				systemeExpert.SetFactValue(SuperFacts.IS_TENTACLE, true);
				
			//***************************************
			// Checking if what is my position in the tentacle (if it exist)
			//***************************************
			if (tentacleInfo != null) {
				if (tentacleInfo.getTheRoot() == this)
					systemeExpert.SetFactValue(SuperFacts.IS_THE_ROOT, true);
				else if (tentacleInfo.getTheHead() == this)
					systemeExpert.SetFactValue(SuperFacts.IS_THE_HEAD, true);
					else
						systemeExpert.SetFactValue(SuperFacts.IS_A_LINK, true);
			}
			
			
			
		}
		
		protected function Infer() : void
		{
			systemeExpert.RealiserChainageAvant();
			ResolutionLogiqueParrallele(systemeExpert.GetBaseFait().GetFaits());
		}
		
		public function ResolutionLogiqueParrallele(faitsDeConclusion:Array):void {
			var indexFaitTemp:Number = -1;
			for (var i:int = 0; i < faitsDeConclusion.length; i++) {
				if ((Fait)(faitsDeConclusion[i]).GetEtat() && (Fait)(faitsDeConclusion[i]).Getpoid() > 0) {
					if (indexFaitTemp >= 0){
						if ((Fait)(faitsDeConclusion[i]).Getpoid() > (Fait)(faitsDeConclusion[indexFaitTemp]).Getpoid())
							(Fait)(faitsDeConclusion[indexFaitTemp]).SetEtat(false);
						else
							(Fait)(faitsDeConclusion[i]).SetEtat(false);
					}else {
						indexFaitTemp = i;
					}
				}
			}
		}
		
		protected function Act() : void
		{
			var facts:Array = systemeExpert.GetBaseFait().GetFaits();
			
			for (var i:int = 0; i < systemeExpert.GetBaseFait().GetFaits().length; i++)
			{
				var unFait:Fait = (facts[i] as Fait);
				
				if(unFait.GetEtat()==true) {
					switch(unFait.GetLabel())
					{
						case SuperFacts.MEET_TENTACLE.GetLabel():
						trace("MEET_TENTACLE");
						MeetTentacle(seeATentacle);
						break;
						
						case SuperFacts.CREATE_TENTACLE.GetLabel():
						trace("CREATE_TENTACLE");
						BecomeTentacle(seenResource);
						break;
						
						case SuperFacts.GO_TO_RESOURCE.GetLabel():
						trace("GO_TO_RESOURCE");
						GoToResource();
						break;
						
						case SuperFacts.TAKE_RESOURCE.GetLabel():
						trace("TAKE_RESOURCE");
						TakeResource();
						break;
						
						case SuperFacts.PUT_DOWN_RESOURCE.GetLabel():
						trace("PUT_DOWN_RESOURCE");
						PutDownResource();
						break;
						
						case SuperFacts.CHANGE_DIRECTION.GetLabel():
						trace("CHANGE_DIRECTION");
						ChangeDirection();
						break;
						
						case SuperFacts.STAY_IN_THE_TENTACLE_RESOURCE.GetLabel():
						//trace("STAY_IN_THE_TENTACLE_RESOURCE");
						Follow(tentacleInfo.getTheRootResource());
						break;
						
						case SuperFacts.FOLLOW_THE_PREVIOUS.GetLabel():
						//trace("FOLLOW_THE_PREVIOUS");
						FollowThePreviousLink();
						break;
						
						case SuperFacts.ROTATE_TENTACLE.GetLabel():
						//trace("ROTATE_TENTACLE");
						rotationAngle += (4 / tentacleInfo.getBotsOfTheTentacle().length);
						Rotate(new Point(tentacleInfo.getTheRootResource().x, tentacleInfo.getTheRootResource().y), rotationAngle);
						break;
						
						/*case SuperFacts.NO_TENTACLE.GetLabel():
						trace("NO_TENTACLE");
						tentacleInfo = null;
						break;*/
					}
				}
			}
			
			seeATentacle = null;
			/*if ((systemeExpert.GetFactBase().GetFactValue(SuperFacts.IS_TENTACLE) ==  false) && 
			(systemeExpert.GetFactBase().GetFactValue(SuperFacts.SEE_TENTACLE) == false))
				tentacleInfo = null;
			*/
		}
		
		public function CalculateIfACountResourceIsHigher(_resource1:Agent, _resource2:Agent) : Boolean {
			if (_resource1 is Resource) {
				if (_resource2 is Resource) {
					if ( (_resource1 as Resource).GetLife() > (_resource2 as Resource).GetLife() )
						return true
				} else if (_resource2 is BotHome)
					if ( (_resource1 as Resource).GetLife() > (_resource2 as BotHome).GetResourceCount() )
						return true;
			} else if (_resource1 is BotHome) {
				if (_resource2 is Resource) {
					if ( (_resource1 as BotHome).GetResourceCount() > (_resource2 as Resource).GetLife() )
						return true
				} else if (_resource2 is BotHome)
					if ( (_resource1 as BotHome).GetResourceCount() > (_resource2 as BotHome).GetResourceCount() )
						return true;
			}
			
			return false;
		}
		
		
		public function BecomeTentacle(_onThisResource:Agent):void 
		{
			if(tentacleInfo == null) {
				tentacleInfo = new TentacleInfo();
				tentacleInfo.init(this, _onThisResource);
				Follow(_onThisResource);
			}else {
				if(tentacleInfo.getBotsOfTheTentacle().indexOf(this) > 0) {
					if (moveAt(new Point(tentacleInfo.getThePreviousBotOf(this).x + 25, tentacleInfo.getThePreviousBotOf(this).y + 25)))
					{
						Follow(tentacleInfo.getThePreviousBotOf(this));
					}
				}
			}
			
		}
		
		public function Follow(_thisAgent:Agent) : void
		{
			moveAt(new Point(_thisAgent.x, _thisAgent.y));
		}
		
		public function MeetTentacle(_ofABotFriend:Agent) : void
		{
			tentacleInfo = (_ofABotFriend as SuperBot).GetTentacleInfo();
			tentacleInfo.getBotsOfTheTentacle().push(this);
			//FollowThePreviousLink();
		}
		
		public function Rotate(center:Point, angle:Number) : void {
			var destinationX:Number = tentacleInfo.CalculateTheMaxSize() * Math.cos( angle * Math.PI / 180 ) + center.x;
			var destinationY:Number = tentacleInfo.CalculateTheMaxSize() * Math.sin( angle * Math.PI / 180 ) + center.y;
			moveAt(new Point(destinationX, destinationY));
		}
		
		public function FollowThePreviousLink() : void
		{
			var previousLink:SuperBot = tentacleInfo.getThePreviousBotOf(this);
			var nextLink:SuperBot = tentacleInfo.getTheNextBotOf(this);
			moveAt(new Point((previousLink.x + nextLink.x)/2 , (previousLink.y + nextLink.y)/2 ));
		}
		
		public function moveAt(_thisPoint:Point) : Boolean
		{
			var pixelByFrame:Number = this.speed / (TimeManager.timeManager.GetFrameDeltaTime());
			if ((distanceBetweenTwoPoints(new Point(this.x,this.y), _thisPoint) > pixelByFrame) || (pixelByFrame == Infinity)) {
				
				direction = _thisPoint.subtract(targetPoint);
				direction.normalize(1);				
				return false;
			}else {
				this.x = _thisPoint.x;
				this.y = _thisPoint.y;
				direction.x = 0;
				direction.y = 0;
				return true;
			}
		}
		
		public function distanceBetweenTwoPoints(_firstPoint:Point, _secondPoint:Point) : Number
		{
			return Math.sqrt(Math.pow((_firstPoint.x - _secondPoint.x), 2) + Math.pow((_firstPoint.y - _secondPoint.y), 2));
		}
		
		public function GoToResource() : void
		{
			if (seenResource != null)
			{
				moveAt(seenResource.GetTargetPoint());
				//direction.normalize(1);
				
				seenResource = null;
			}
		}
		
		public function TakeResource() : void
		{
			if (reachedResource != null)
			{
				if (reachedResource.GetType() == AgentType.AGENT_RESOURCE)
				{
					(reachedResource as Resource).DecreaseLife();
					SetResource(true);
					takenResource = (reachedResource as Resource);
					
					lastReachedResource = (reachedResource as Resource);
					
					reachedResource = null;
				}
				else if (reachedResource.GetType() == AgentType.AGENT_BOT_HOME)
				{
					(reachedResource as BotHome).TakeResource();
					SetResource(true);
					takenResource = (reachedResource as BotHome);
				
					lastReachedResource = (reachedResource as BotHome);
				
					reachedResource = null;
				}
				
			}
			seenResource = null;
		}

		public function PutDownResource() : void
		{
			if (reachedResource != null)
			{
				if (reachedResource.GetType() == AgentType.AGENT_RESOURCE)
				{
					(reachedResource as Resource).IncreaseLife();
				}else if (reachedResource.GetType() == AgentType.AGENT_RESOURCE){
					(reachedResource as BotHome).AddResource();
				}
				SetResource(false);

				lastReachedResource = reachedResource;
				
				reachedResource = null;
				takenResource = null;
			}
			
			seenResource = null;
		}
		
		override public function ChangeDirection() : void 
		{
			if(delayToChangeDirection == 10) {
				moveAt(new Point(Math.random() * 650, Math.random()* 600));
				delayToChangeDirection = 0;
			}
			
			delayToChangeDirection++;
			seenResource = null;
		}
		
		override public function onAgentCollide(_event:AgentCollideEvent) : void
		{
			var collidedAgent:Agent = _event.GetAgent();
			var ifCollisionWithSomething:Boolean = false;
			//whereIAm = null;
			seenSomeone = null;
			
			if (IsCollided(collidedAgent))
			{
				//Bot collision
				if (distanceBetweenTwoPoints(new Point(this.x, this.y), new Point(collidedAgent.x, collidedAgent.y)) < 3)
					ifCollisionWithSomething = true;
				
				if (collidedAgent is Resource)
				{
					reachedResource = (collidedAgent as Resource);
					seenResource = (collidedAgent as Resource);
					
					if(ifCollisionWithSomething) {
						whereIAm = new String("InAResource");
						//trace("je suis en collision avec une RESSOURCE");
					}
				}
				if (collidedAgent is BotHome)
				{
					reachedResource = (collidedAgent as BotHome);
					seenResource = (collidedAgent as BotHome);
					
					if ((collidedAgent as BotHome).GetTeamId() == this.teamId) {
						if(ifCollisionWithSomething) {
							whereIAm = new String("AtHome");
							//trace("je suis en collision avec ma HOME");
						}
					}else{
						if(ifCollisionWithSomething) {
							whereIAm = new String("AtEnnemyHome");
							//trace("je suis en collision avec une HOME_ENNEMY");
						}
					}
				}
				
				/*if (collidedAgent is Bot) {
					trace("je suis en collision avec un bot");
					 if (collidedAgent is SuperBot)
					 {
						 if((collidedAgent as SuperBot).G
					 }
				}*/
				
			}
			
			//Perception
			/*if ((collidedAgent is Bot) && (collidedAgent != this)) {
				trace("mon champ de vision est en collision avec un bot "+ distanceBetweenTwoPoints(new Point(this.x, this.y), new Point(collidedAgent.x, collidedAgent.y)));
			}*/
			
			
			if ((collidedAgent.GetType() == AgentType.AGENT_RESOURCE) || (collidedAgent.GetType() == AgentType.AGENT_BOT_HOME))
			{
				//The last reached resource can't be seen
				if ((collidedAgent != lastReachedResource) || (lastReachedResource == null))
				{
					
					if (collidedAgent is Resource)
					{
						//trace("mon champ de vision est en collision avec une RESSOURCE "+ distanceBetweenTwoPoints(new Point(this.x, this.y), new Point(collidedAgent.x, collidedAgent.y)));
						seenResource = (collidedAgent as Resource);
					}
					if (collidedAgent is BotHome)
					{
						//trace("mon champ de vision est en collision une HOME "+ distanceBetweenTwoPoints(new Point(this.x, this.y), new Point(collidedAgent.x, collidedAgent.y)));
						seenResource = (collidedAgent as BotHome);
					}
				}
			}				
			
			if ((collidedAgent is Bot) && (collidedAgent != this))
			{
				seenSomeone = (collidedAgent as Bot);
				if (seenSomeone.GetTeamId() == this.teamId) {
					var seenOneFriend:SuperBot = (seenSomeone as SuperBot);
					if (seenOneFriend.GetSystemeExpert().GetFactValue(SuperFacts.IS_TENTACLE))
						seeATentacle = seenOneFriend;
				}
			}
		
		}
		
		public function GetSystemeExpert():SystemeExpert 
		{
			return systemeExpert;
		}
		
		public function GetPerceptionRadius() : Number
		{
			return perceptionRadius;
		}
		
		public function GetTentacleInfo():TentacleInfo 
		{
			return tentacleInfo;
		}
		
	}

}