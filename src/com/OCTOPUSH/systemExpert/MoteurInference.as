package  com.OCTOPUSH.systemExpert
{
	/**
	 * ...
	 */
	public class MoteurInference 
	{
		private var baseR:BaseRegle;
		private var baseF:BaseFait;
		private var conclusionsModifiees:Array;
		private var premicesModifiees:Array;
		
		
		public function MoteurInference(_systemeExpert:SystemeExpert) 
		{
			baseR = _systemeExpert.GetBaseRegle();
			baseF = _systemeExpert.GetBaseFait();
			conclusionsModifiees = new Array();
			premicesModifiees = new Array();
		}
	
		public function FaitEstVrai(_label:String):Boolean
		{
			var fait:Fait = baseF.GetFait(_label);
			if (fait.GetEtat() == true)
				return true;
			else
				return false;
		}
		
		public function ToutesPremicesVraies(_premices:Array):Boolean
		{
			var i:int = 0;
			while (i != _premices.length)
			{
				if(FaitEstVrai(_premices[i])==false)
					return false;
				else
					i++;
			}
			return true;
		}
		
		
		public function PremiereRegle():Regle //trouver la premiere regles où toutes les prémices sont vraies et la conclusion est fausse
		{
			var i:int = 0;
			while (i != baseR.GetRegles().length)
			{
				var regle:Regle = (baseR.GetRegles()[i] as Regle);
				if(ToutesPremicesVraies(regle.GetPremices())== true && FaitEstVrai(regle.GetConclusion()) ==false)
					return regle;
				else 
					i++;
				
			}
			return null;
		}
		
		public function ChainageAvant() : void
		{
				var regle:Regle = PremiereRegle();
				while (regle != null)
				{
					var fait:Fait = baseF.GetFait(regle.GetConclusion());
					fait.SetEtat(true);
					if(fait.Getpoid() < regle.GetPoid())
						fait.SetPoid(regle.GetPoid());
					conclusionsModifiees.push(fait);
					regle = PremiereRegle();
				}
		}
		
		public function FaitsInitiaux() : Array
		{
			var FaitsInitiaux:Array = new Array() ;
			for (var i:int = 0 ; i != baseR.GetRegles().length;i++ )
			{
				var regle1:Regle = (baseR.GetRegles()[i] as Regle);
				for (var l:int = 0 ; l != regle1.GetPremices().length; l++)
				{
					var premice1:String = (regle1.GetPremices()[l] as String);
					var total:int = 0;		
					for (var j:int = 0 ; j != baseR.GetRegles().length;j++ )
					{	
						var regle2:Regle = (baseR.GetRegles()[j] as Regle);	
						if (regle2.GetConclusion() == premice1)
							total++;
					}
					if (total == 0)
						if(FaitsInitiaux.indexOf(premice1)==-1)
							FaitsInitiaux.push(premice1);
				}
			}
			return FaitsInitiaux;
		}
		

		public function FaitsTerminaux() : Array
		{
			var FaitsTerminaux:Array = new Array();
			for (var i:int = 0 ; i != baseR.GetRegles().length;i++ )
			{
					var total:int;
				var regle1:Regle = (baseR.GetRegles()[i] as Regle);
				for (var j:int = 0 ; j != baseR.GetRegles().length;j++ )
				{
					var regle2:Regle = (baseR.GetRegles()[j] as Regle);
					if (regle2.GetPremices().indexOf(regle1.GetConclusion()) != -1)
						total ++;
						
				}
					if(total==0)
						if (FaitsTerminaux.indexOf(regle1.GetConclusion()) == -1)
								FaitsTerminaux.push(baseF.GetFait(regle1.GetConclusion()));
			}
			return FaitsTerminaux;
		}
		
		public function AppelRecursif(_param:String, _premicesInterrogées:Array) : void
		{
				for (var j:int = 0; j != baseR.GetRegles().length; j++)
				{
					var regle:Regle = (baseR.GetRegles()[j] as Regle);
					if (regle.GetConclusion() == _param)
					{
						for (var k:int = 0; k != regle.GetPremices().length; k++)
						{
							var labelPremice:String = (regle.GetPremices()[k] as String);
							var premice:Fait = baseF.GetFait(labelPremice);
							if (premice.GetEtat() == false)
							{
								if (FaitsInitiaux().indexOf(premice.GetLabel()) != -1)
									if(_premicesInterrogées.indexOf(premice.GetLabel())==-1)
										_premicesInterrogées.push(premice.GetLabel());
								else
									AppelRecursif(premice.GetLabel(),_premicesInterrogées);
							}
						}
					
					}
				}
		}
		
		
		
		public function ChainageArriere() : void
		{
			var PremicesInterrogées:Array = new Array();
			var ft:Array = FaitsTerminaux();
			for (var i:int = 0; i != ft.length; i++)
			{
				
				var FaitTerminal:String = (ft[i] as String);
				AppelRecursif(FaitTerminal,PremicesInterrogées);
				
			}
			trace("premices : ");
			for (var j:int = 0; j != PremicesInterrogées.length; j++)
			{
				var premice:String = (PremicesInterrogées[j] as String);
				trace("Quel est l'état de la premice "+premice+" : ");
			}
		}

		
		
		public function GetConclusionsModifiees() : Array
		{
			return conclusionsModifiees;
		}
		
		public function GetPremicesModifiees() : Array
		{
			return premicesModifiees;
		}
		
	}

}