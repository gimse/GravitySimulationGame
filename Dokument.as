package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	
	
	public class Dokument extends MovieClip {
		
		//keycodene for for tallene på tataturet(0,1,...,9)
		private var tallKeyCode:Array=[48,49,50,51,52,53,54,55,56,57];
		private var valgtMasse=1;
		
		var sirkler:Array=new Array();
		
		var sorteringArray:Array;
		
		public function Dokument() {
			// constructor code
			stage.addEventListener(MouseEvent.CLICK, museTrykkHjelp);
			
			bakgrunn.addEventListener(MouseEvent.CLICK, museTrykk);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, tasteTrykk);
			slettAlle_btn.addEventListener(MouseEvent.CLICK, slettAlle);
			
			//gjør at musen ikke fungerer på hjelpee teksen
			hjelp_mc.mouseEnabled=false;
			
		}
		private function tasteTrykk(evt:KeyboardEvent):void{
			//går igjennom tall-keycodene
			for (var tastaturTall=0;tastaturTall<tallKeyCode.length;tastaturTall++){
				if(evt.keyCode==tallKeyCode[tastaturTall]){
					valgtMasse=tastaturTall;
					masse_comp.value=tastaturTall;
				}
			}
			//endre v0 farten ved bruk av taster
			if(evt.keyCode==87){
				//w
				Yfart_comp.value++;
			}
			if(evt.keyCode==83){
				//s
				Yfart_comp.value--;
			}
			if(evt.keyCode==68){
				//d
				Xfart_comp.value++;
			}
			if(evt.keyCode==65){
				//a
				Xfart_comp.value--;
			}
			
		}
		private function museTrykk(evt:MouseEvent):void{
			leggTilSirkel(mouseX,mouseY,masse_comp.value,Xfart_comp.value,-Yfart_comp.value,Zfart_comp.value);
		}
		private function leggTilSirkel(Xposisjon:Number,Yposisjon:Number,masse:Number,v0x:Number,v0y:Number,v0z:Number){
			//Legger til sirkelen
			var sirkel:Sirkel= new Sirkel();
			sirkel.x=Xposisjon;
			sirkel.y=Yposisjon;
			sirkel.z=0;
			sirkel.masse=masse;
			sirkel.v0x=v0x;
			sirkel.v0y=v0y;
			sirkel.v0z=v0z;
			sirkler.push(sirkel);
			//trace("masse: "+String(sirkel.masse));
			addChild(sirkel);
		}
		function slettAlle(evt:MouseEvent){
			//sletter alle sirklene
			for each (var sirkel1 in sirkler){
				removeChild(sirkel1);
			}
			sirkler=new Array();;
		}
		function museTrykkHjelp(evt:MouseEvent){
			hjelp_mc.play();
			stage.removeEventListener(MouseEvent.CLICK, museTrykkHjelp);
		}
	}
	
}
