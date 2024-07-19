
let micastart = new Audio();
micastart.src = '������ȿ����.mp3';

let micastop = new Audio();
micastop.src = '������ȿ����.mp3';

let micout = new Audio(); 
micout.src = '������ȿ��.mp3';

micout.volume = 0.5;

const micmodal_wrap = document.querySelector('.micmodal_wrap')
const micmodal_bg = document.querySelector('.micmodal_bg')

//Show micmodal
document.querySelector('#mic').addEventListener('click', () => {
  open()
})

//Hide micmodal
document.querySelector('.micmodal_x').addEventListener('click', () => {
  close()
})

//Hide micmodal
window.addEventListener('click', (e) => {
  e.target === micmodal_bg ?  close() : false
})
function close(){
  micmodal_wrap.classList.remove('show-micmodal');
  micmodal_bg.classList.remove('show-micmodal');
  stop();
  outplay();

}

function mplay() {
  if (micout.playing) 
    micout.pause();


  if (micastart.playing) 
    micastart.pause();  

  if (micastop.playing) 
    micastop.pause();
  else 
    micastop.play();
}

function outplay() {
  if (micastop.playing) 
    micastop.pause();

  if (micastart.playing) 
    micastart.pause();

  if (micout.playing) 
    micout.pause();
  else 
    micout.play();
}

function splay() {
  if (micastop.playing) 
    micastop.pause();

  if (micastop.playing) 
    micastop.pause();

  if (micastart.playing) 
    micastart.pause();
  else 
    micastart.play();

}

function open(){
  micmodal_wrap.classList.add('show-micmodal')
  micmodal_bg.classList.add('show-micmodal')
}

      var micstatus = document.querySelector("#micstatus");
      const micstart = document.getElementById('micstart');
      const micnone = document.getElementById('micnone');
        var SpeechRecognition = SpeechRecognition || webkitSpeechRecognition;
        var SpeechGrammarList = SpeechGrammarList || webkitSpeechGrammarList;
        var SpeechRecognitionEvent = SpeechRecognitionEvent || webkitSpeechRecognitionEvent;
        var isRecognizing = false;

      if ('SpeechRecognition' in window) {
         // Speech recognition support. Talk to your apps!
          console.log("�����ν��� �����ϴ� �������Դϴ�.")
      }

      try {
            var speech = new (window.SpeechRecognition || window.webkitSpeechRecognition || window.mozSpeechRecognition || window.msSpeechRecognition)();
        } catch(e){
            console.error(e);
        }
        var result;
        var proCate = "all";

        var speechRecognitionList = new SpeechGrammarList();
        speech.lang = 'ko-KR'; //�����ϰ� ����� �ҵ� .
        speech.grammars = speechRecognitionList;

        speech.interimResults = false; // true: �߰� ����� ��ȯ, false: ���� ����� ��ȯ
        speech.continious = true; // true: �����ν��� ����ؼ� ����, false: �����ν��� �ѹ��� ����
        speech.maxAlternatives = 20000;


        function stop(){
          speech.stop();
            micstatus.innerHTML = "������ ����Ǿ����ϴ� ����ũ�� �ٽ� Ȱ��ȭ ���ּ���";

            isRecognizing = false;
            if (micstart.style.display === 'block') {
              micstart.style.display = 'none';
              }


            if (micnone.style.display === 'none') {
              micnone.style.display = 'block';
          } 
            
        }
          
    

       function speechsearch(){
          if (micnone.style.display === 'block') {
             micnone.style.display = 'none';
              }
         
     
          if (micstart.style.display === 'none') {
             micstart.style.display = 'block';
          }



          speech.start();
          setTimeout(function() {
              stop();
           }, 13000);
           isRecognizing = true;

           speech.onstart = function(){
              
               micstatus.innerHTML = "��� �� �Դϴ�...";
               
           };
        

           speech.onresult = function(event) {
             result = event.results[0][0].transcript.toLowerCase();            
             if (result == null) {
               speech.stop();
             } 
    
          
            micstatus.innerHTML = result + " �� �˻��մϴ�.";
            speech.stop();
         

          setTimeout(function() {
           location.replace("productSearch.jsp?proName="+result+"&&proCate="+proCate);
         }, 3000);
             
         
            
         };
   

       
            speech.onspeechstart =function(event){
            micstatus.innerHTML = "�Ҹ�����...";
         };
  
         
         


       }