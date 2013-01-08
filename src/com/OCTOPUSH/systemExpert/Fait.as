package  com.OCTOPUSH.systemExpert
{
	/**
	 * ...
	 * @author ADucousso
	 */
	public class Fait 
	{
		private var label:String; // nom du fait
		private var etat:Boolean; //état du fait : Vrai ou Faux
		private var _poid:int;
		
		public function Fait(_label:String) 
		{
			label  = _label;
			etat = false;
			_poid = 0;
		}
		
		public function GetLabel() : String
		{
			return label;
		}
		
		public function GetEtat() : Boolean
		{
			return etat;
		}
		
		public function SetEtat(_etat:Boolean) : void
		{
			etat = _etat;
		}
		
		public function Getpoid():int 
		{
			return _poid;
		}
		
		public function SetPoid(value:int):void 
		{
			_poid = value;
		}
	}

}