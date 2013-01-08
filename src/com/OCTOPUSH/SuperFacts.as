package com.OCTOPUSH 
{
	import com.OCTOPUSH.systemExpert.*;
	/**
	 * ...
	 * @author ADB
	 */
	public class SuperFacts 
	{
		public static const NOTHING_SEEN:Fait			= new Fait("Nothing seen");
		public static const SEE_RESOURCE:Fait			= new Fait("Resource seen");
		public static const REACHED_RESOURCE:Fait		= new Fait("Resource reached");
		public static const GOT_RESOURCE:Fait 			= new Fait("Got resource" );
		public static const NO_RESOURCE:Fait 			= new Fait("Got no resource" );
		//public static const BIGGER_RESOURCE:Fait 		= new Fait("Resource is bigger" );
		//public static const SMALLER_RESOURCE:Fait 		= new Fait("Resource is smaller" );
		public static const CHANGE_DIRECTION_TIME:Fait	= new Fait("Time to change direction");
		
		//public static const SEEING_HOME:Fait			= new Fait("Seeing home");
		//public static const NOT_SEEING_HOME:Fait		= new Fait("Not seeing home");
		//public static const GO_HOME:Fait				= new Fait("Go home");
		public static const AT_HOME:Fait				= new Fait("At home");
		public static const NOWHERE:Fait				= new Fait("No where");
		public static const ALREADY_IN_RESOURCE:Fait	= new Fait("Already inside a resource");

		public static const CHANGE_DIRECTION:Fait		= new Fait("Changing direction");
		public static const GO_TO_RESOURCE:Fait			= new Fait("Going to resource");
		public static const TAKE_RESOURCE:Fait 			= new Fait("Taking Resource." );
		public static const PUT_DOWN_RESOURCE:Fait 		= new Fait("Putting down Resource." );
			
		//public static const SEE_ENEMY_BASE:Fait 		= new Fait("See enemy base");
		public static const SEE_TENTACLE:Fait 			= new Fait("See tentacle");
		//public static const SEE_BASE_TENTACLE:Fait 		= new Fait("See base tentacle");
		
		public static const CREATE_TENTACLE:Fait		= new Fait("Create a new tentacle");
		public static const IS_TENTACLE:Fait			= new Fait("Is in a tentacle");
		public static const NO_TENTACLE:Fait			= new Fait("Is not in a tantacle");
		public static const MEET_TENTACLE:Fait			= new Fait("Meet a tentacle to grow it");
		public static const INTEREST_MEET_OTHER_TENTACLE:Fait	= new Fait("If interesting to meet an other tentacle");
		public static const ROTATE_TENTACLE:Fait		= new Fait("Rotate the tentacle around the root");
		
		
		public static const IS_THE_ROOT:Fait			= new Fait("I am the root");
		public static const IS_THE_HEAD:Fait			= new Fait("I am the head");
		public static const IS_A_LINK:Fait				= new Fait("I am a link");
		
		public static const STAY_IN_THE_TENTACLE_RESOURCE:Fait	= new Fait("Stay in the tentacle resource");
		public static const FOLLOW_THE_PREVIOUS:Fait	= new Fait("Follow the previous link");
	}

}