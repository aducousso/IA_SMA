package  com.OCTOPUSH.systemExpert
{
	import com.OCTOPUSH.systemExpert.Fait
	/**
	 * ...
	 */
	public class BaseFait extends Array
	{
		private var faits:Array; 
		
		public function BaseFait() 
		{
				faits = new Array();
		}
		
		public function AddFait(_label:String,_etat:Boolean) : void
		{
			var fait:Fait = new Fait(_label);
			fait.SetEtat(_etat);
			faits.push(fait);
		}
		
		public function GetFaits() : Array
		{
			return faits;
		}
		
		public function GetFait(_label:String):Fait
		{
			for (var i:int = 0; i != faits.length; i++)
			{
				var fait:Fait = (faits[i] as Fait);
				if (fait.GetLabel()== _label)
				{
					return fait;
				}
			}
			return null;
		}
		
	}

}