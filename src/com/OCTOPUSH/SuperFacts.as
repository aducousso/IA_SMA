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
		
		public static const AT_HOME:Fait				= new Fait("At home");
		public static const NOWHERE:Fait				= new Fait("No where");
		public static const ALREADY_IN_RESOURCE:Fait	= new Fait("Already inside a resource");

		public static const CHANGE_DIRECTION:Fait		= new Fait("Changing direction");
		public static const GO_TO_RESOURCE:Fait			= new Fait("Going to resource");
		public static const TAKE_RESOURCE:Fait 			= new Fait("Taking Resource." );
		public static const PUT_DOWN_RESOURCE:Fait 		= new Fait("Putting down Resource." );
		public static const ORDER_TO_STOP:Fait 			= new Fait("A bot give me an order to stop my activity" );
		public static const WAIT_HERE:Fait 				= new Fait("I stay here" ); 
		
		public static const SEE_TENTACLE:Fait 			= new Fait("See tentacle");
		public static const CREATE_TENTACLE:Fait		= new Fait("Create a new tentacle");
		public static const IS_TENTACLE:Fait			= new Fait("Is in a tentacle");
		public static const NO_TENTACLE:Fait			= new Fait("Is not in a tantacle");
		public static const MEET_TENTACLE:Fait			= new Fait("Meet a tentacle to grow it");
		public static const INTEREST_MEET_OTHER_TENTACLE:Fait	= new Fait("If interesting to meet an other tentacle");
		public static const ROTATE_TENTACLE:Fait		= new Fait("Rotate the tentacle around the root");
		public static const BEST_RESOURCE_SEEN:Fait		= new Fait("See a resource different root resource");
		
		public static const TENTACLE_NOT_HOOKED:Fait	= new Fait("The tentacle has no Head Resource");
		public static const TENTACLE_HOOKED:Fait		= new Fait("The tentacle has a Head Resource");
		
		public static const GO_TO_BEST_RESOURCE:Fait	= new Fait("Going to the best resource");
		public static const GO_TO_TARGET_RESOURCE:Fait = new Fait("Going to the target resource of the tentacle");
		public static const EAT_TARGET_RESOURCE:Fait	= new Fait("Eat the target resource");
		public static const IN_THE_TARGET_RESOURCE:Fait	= new Fait("Inside the target resource of the tentacle");
		
		public static const TENTACLE_TOO_LONG:Fait 		= new Fait("Check if the size of the tentacle is too long");
		public static const SEE_HIS_HOME:Fait			= new Fait("Seeing home");
		public static const SEE_ENNEMY_HOME:Fait		= new Fait("Seeing ennemy home");
		
		public static const HOME_BECOME_ROOT:Fait			= new Fait("Our home become the tentacle root");
		public static const ENNEMY_HOME_BECOME_TARGET:Fait	= new Fait("Ennemy home become the tentacle target");
		public static const ROOT_NOT_HOME:Fait			= new Fait("The tentacle root is not my home");
		public static const TARGET_NOT_ENNEMY_HOME:Fait	= new Fait("The tentacle target is not the ennemy home");
		public static const TARGETROOT_SAME:Fait		= new Fait("The target and the root never be the same");
		
		public static const HAS_RESOURCE:Fait			= new Fait("Carry a resource");
		public static const GIVE_HIM_RESOURCE:Fait		= new Fait("Give the resource to his last link");
		public static const GO_TO_GIVE_RESOURCE:Fait	= new Fait("Bring the resource to his last link");
		public static const TOUCH_YOUR_LAST_FRIEND:Fait	= new Fait("Him and the last bot are in contact"); 
		
		public static const GO_TO_STOCK_IN_ROOT_RESOURCE:Fait	= new Fait("Bring the resource in the root resource");
		public static const IN_THE_ROOT_RESOURCE:Fait	= new Fait("Is in the root resource");
		public static const STOCK_IN_ROOT_RESOURCE:Fait	= new Fait("Grow the root resource");
		
		public static const IS_THE_ROOT:Fait			= new Fait("I am the root");
		public static const IS_THE_HEAD:Fait			= new Fait("I am the head");
		public static const IS_A_LINK:Fait				= new Fait("I am a link");
		
		public static const STAY_IN_THE_TENTACLE_RESOURCE:Fait	= new Fait("Stay in the tentacle resource");
		public static const FOLLOW_THE_PREVIOUS:Fait	= new Fait("Follow the previous link");
		public static const FOLLOW_NEXT_SECURE:Fait		= new Fait("Follow the next link -accordeon secure-");
		public static const FOLLOW_PREVIOUS_SECURE:Fait	= new Fait("Follow the previous link -accordeon secure-");
		public static const NEXT_LINK_TOO_FAR:Fait 		= new Fait("If the next exceed the average distance");
		public static const PREVIOUS_LINK_TOO_FAR:Fait 	= new Fait("If the previous exceed the average distance");		
		
		public static const RESOURCE_TARGET_EMPTY:Fait	= new Fait("If the target resource is empty");
		
	}

}