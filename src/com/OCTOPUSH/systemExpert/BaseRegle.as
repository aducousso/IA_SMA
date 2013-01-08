package com.OCTOPUSH.systemExpert 
{
	/**
	 * ...
	 */
	public class BaseRegle extends Array
	{
		private var regles:Array; 

		public function BaseRegle() 
		{
				regles = new Array();
		}
		
		public function AddRegle(_premices:Array,_conclusion:Fait, _poid:int) : void
		{
			var _labelsDesPremices : Array = new Array();
			for (var i:int = 0; i < _premices.length; i++)
			{
				_labelsDesPremices.push((_premices[i] as Fait).GetLabel())
			}
			var regle:Regle = new Regle(_labelsDesPremices,_conclusion.GetLabel(), _poid);
			regles.push(regle);
		}
		
		public function GetRegles() : Array
		{
			return regles;
		}
		
		
	}

}