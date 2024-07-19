var slides = document.querySelector('.slides'),//ul
    slide = document.querySelectorAll('.slides li')
    currentIdx = 0,
    slideCount = slide.length,
    slideWidth = 300,
    slideMargin = 30,
    prevBtn = document.querySelector('.prev'),
    nextBtn = document.querySelector('.next');
    
makeColne();

function makeColne(){
    for(var i=0; i<slideCount; i++){
        //a.cloneNode(), a.cloneNode(true)
        var cloneSlide = slide[i].cloneNode(true);
        cloneSlide.classList.add('clone');
        //a.appendChild(b) 요소 뒤에 추가
        slides.appendChild(cloneSlide);
    }
    for(var i=slideCount-1; i>=0; i--){
        //a.cloneNode(), a.cloneNode(true)
        var cloneSlide = slide[i].cloneNode(true);
        cloneSlide.classList.add('clone');
        //a.prepend(b) 요소 앞에 추가
        slides.prepend(cloneSlide);
    }
    updateWidth();// ul 넓이 지정하는 함수
    setInitialPos();// 초기위치 잡는 함수: 앞뒤로 복제된 슬라이드 말고 초기 슬라이드를 가운데로 위치시킴

    setTimeout(function(){
        slides.classList.add('animated');
    },100);
}

function updateWidth(){//복제된 전체 슬라이드 길이만큼 넓이 지정
    var currentSlides = document.querySelectorAll('.slides li');
    var newSlideCount = currentSlides.length;

    var newWidth = (slideWidth + slideMargin)*newSlideCount - slideMargin +'px';
                    //(슬라이드 넓이+오른쪽 margin)*슬라이드 개수 - 마지막 슬라이드 margin +'px'
    slides.style.width = newWidth;
}

function setInitialPos(){
    var initialTranlateValue = -(slideWidth + slideMargin)*slideCount;//왼쪽으로 이동하므로 -
    //slides {transform:translateX(-000px);}
    slides.style.transform = 'translateX(' + initialTranlateValue+ 'px)';
}

nextBtn.addEventListener('click', function(){
    moveSlides(currentIdx + 1);
});

prevBtn.addEventListener('click', function(){
    moveSlides(currentIdx - 1);
});

//슬라이드 움직이게 하는 함수
function moveSlides(num){
    slides.style.left = -num * (slideWidth+slideMargin) + 'px';
    currentIdx = num;
    console.log(currentIdx, slideCount);


    if(currentIdx == slideCount || currentIdx == -slideCount){//마지막 슬라이드 보여주고 있으면
        setTimeout(function(){
            slides.classList.remove('animated');// 바뀌는거 티안나게 애니메이션 끔
            slides.style.left = '0px';
            currentIdx = 0;
        }, 500)//0.5s 이후(슬라이드 움직인 후)

        setTimeout(function(){
            slides.classList.add('animated');// 바뀌는거 티안나게 애니메이션 킴
        }, 600)//위에 함수 실행 이후
    }
}

//슬라이드 자동으로 움직이게 하는 함수
var timer = undefined;

function autoSlide(){
    if(timer == undefined){
        timer = setInterval(function(){
            moveSlides(currentIdx + 1);
        }, 5000);
    }
}
autoSlide();


