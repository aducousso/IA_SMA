package  com.OCTOPUSH.systemExpert
{
	import com.novabox.expertSystem.Fact;
	import com.OCTOPUSH.systemExpert.BaseFait;
	import com.OCTOPUSH.systemExpert.BaseRegle;
	/**
	 * ...
	 */
	public class SystemeExpert 
	{
		
		private var baseR:BaseRegle;
		private var baseF:BaseFait;
	
		
		public function SystemeExpert(_baseF:BaseFait,_baseR:BaseRegle) 
		{
			baseR = _baseR;
			baseF = _baseF;
		}
		
		public function AddRegle(_premices:Array,_conclusion:Fait, _poid:int) : void
		{
			for (var i:int = 0; i < _premices.length; i++)
			{
				var fait:Fait = (_premices[i] as Fait);
				VerifieSiFaitExisteSinonAjouteOuMaJ(fait);
			}
			
			VerifieSiFaitExisteSinonAjouteOuMaJ(_conclusion);
			
			baseR.AddRegle(_premices, _conclusion, _poid);
		}
		
		public function VerifieSiFaitExisteSinonAjouteOuMaJ(_fait:Fait) : void
		{
			if (baseF.GetFait(_fait.GetLabel()) == null)
				baseF.AddFait(_fait.GetLabel(), false);
			else {
				if (_fait.Getpoid() > baseF.GetFait(_fait.GetLabel()).Getpoid())
					baseF.GetFait(_fait.GetLabel()).SetPoid(_fait.Getpoid());
			}
				
		}
		
		public function SetFactValue(_fait:Fait, _etat:Boolean) : void
		{
			VerifieSiFaitExisteSinonAjouteOuMaJ(_fait);
			GetBaseFait().GetFait(_fait.GetLabel()).SetEtat(_etat);
		}
		
		public function GetFactValue(_fait:Fait) : Boolean
		{
			VerifieSiFaitExisteSinonAjouteOuMaJ(_fait);
			return GetBaseFait().GetFait(_fait.GetLabel()).GetEtat();
		}
		
		public function RealiserChainageAvant() : void
		{
			var mr : MoteurInference = new MoteurInference(this);
			mr.ChainageAvant();
			for (var i:int = 0; i != mr.GetConclusionsModifiees().length; i++)
			{
				var fait:Fait = (mr.GetConclusionsModifiees()[i] as Fait);
				//trace(fait.GetLabel()+" : "+fait.GetEtat());
			}
		}
		
		public function RealiserChainageArriere() : void
		{
			var mr : MoteurInference = new MoteurInference(this);
			mr.ChainageArriere();
			
		}
		
		public function SetBaseRegle(_baseR:BaseRegle) : void
		{
			baseR = _baseR;
		}
		
		public function GetBaseFait() : BaseFait
		{
			return baseF;
		}
		
		public function GetBaseRegle():BaseRegle 
		{
			return baseR;
		}
		
		public function ResetFacts():void
		{
			//initialisation des faits à false
			for (var i:int = 0; i < GetBaseFait().GetFaits().length; i++) {
				(Fait)(GetBaseFait().GetFaits()[i]).SetEtat(false);
				(Fait)(GetBaseFait().GetFaits()[i]).SetPoid(0);
			}
		}
		
	}

}