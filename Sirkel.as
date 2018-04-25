package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Sirkel extends MovieClip {
		//6,7×10-11 .Den virkelig konstanten
		var gravitasjonskonstanten:Number =  0.0067;
		var radius:int=5;
		
		//konstaner
		public var masse:Number;
		//akselerasjon(det blir mere hvor mye den flytter seg hver frame, for de den ender på deg hele tiden)
		private var a:Number;
		
		private var ax:Number;
		private var ay:Number;
		private var az:Number;
		//fart(simpel x og y)
		private var vx:Number;
		private var vy:Number;
		private var vz:Number;
		//Start fart
		public var v0x:Number;
		public var v0y:Number;
		public var v0z:Number;
		
		public function Sirkel() {
			// constructor code
			masse_txt.restrict="0-9";
			addEventListener(Event.ADDED_TO_STAGE, lagtTilStage);
			addEventListener(Event.REMOVED_FROM_STAGE, fjernetFraStage);
			addEventListener(Event.ENTER_FRAME, oppdater);
		}
		private function lagtTilStage(evt:Event){
			//oppdaterer tekstfeltet i sirkelen
			masse_txt.text=String(masse);
			vx=v0x;
			vy=v0y;
			vz=v0z;
		}
		private function oppdater(evt:Event){
			//kopierer spillere Arrayen fra parent
			var sirkler:Array=MovieClip(parent).sirkler;
			//nullstiller  akseleasjon
			ax=0;
			ay=0;
			az=0;
			for (var s:uint=0;s<sirkler.length;s++){
				//regner ut avstanden
				var xdistanse:Number=sirkler[s].x-x;
				var ydistanse:Number=sirkler[s].y-y;
				var zdistanse:Number=sirkler[s].z-z;
				var distanse:Number=Math.sqrt(xdistanse*xdistanse+ydistanse*ydistanse+zdistanse*zdistanse);
				//denne gjør bland annet at den ikke går mot seg selv, og at man slipper en super akselerasjon
				if(distanse>radius){
					//regner ut akselerasjonen(Dette er hoved formelen :) )
					ax+=xdistanse*gravitasjonskonstanten*sirkler[s].masse/(distanse^3);
					ay+=ydistanse*gravitasjonskonstanten*sirkler[s].masse/(distanse^3);
					az+=zdistanse*gravitasjonskonstanten*sirkler[s].masse/(distanse^3);
				}
				
			}
			//regner ut farten
			vx+=ax;
			vy+=ay;
			vz+=az;
			
			//beveger på sirklene
			x+=vx;
			y+=vy;
			z+=vz;
			
			
			//oppdater hvilkene av sirklene fom ligger øvers
			for (var v:uint=0;v<sirkler.length;v++){
				if(z>sirkler[v].z && MovieClip(parent).getChildIndex(this)>MovieClip(parent).getChildIndex(sirkler[v])){
					MovieClip(parent).swapChildren(this,MovieClip(parent).sirkler[v]);
				}
			}
		}
		function fjernetFraStage(evt:Event){
			removeEventListener(Event.ADDED_TO_STAGE, lagtTilStage);
			removeEventListener(Event.REMOVED_FROM_STAGE, fjernetFraStage);
			removeEventListener(Event.ENTER_FRAME, oppdater);
		}
		
	}
}
