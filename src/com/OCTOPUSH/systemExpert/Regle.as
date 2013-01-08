package  com.OCTOPUSH.systemExpert
{
	/**
	 * ...
	 */
	public class Regle 
	{
		private var premices:Array; //un tableau de faits premices
		private var conclusion:String;// un fait de conclusion
		private var poid:int; //poid du choix de la regle afin de resoudre le pb de logique parrallele
									
		public function Regle(_premices:Array,_conclusion:String, _poid:int) 
		{
			premices = _premices;
			conclusion = _conclusion;
			poid = _poid;
		}
		
		public function GetPremices() : Array
		{
			return premices;
		}
		
		public function GetConclusion() : String
		{
			return conclusion;
		}
		
		public function GetPoid() : int
		{
			return poid;
		}
		
		public function SetPoid(_poid:int) : void
		{
			poid = _poid;
		}
		
		
	}

}