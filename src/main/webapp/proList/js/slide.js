document.querySelector('.btn1').addEventListener('click', function(){
    document.querySelector('.image_container').style.transform = 'translate(0)'; 
})

document.querySelector('.btn2').addEventListener('click', function(){
    document.querySelector('.image_container').style.transform = 'translate(-100vw)';  
})

document.querySelector('.btn3').addEventListener('click', function(){
    document.querySelector('.image_container').style.transform = 'translate(-200vw)';  
})

var i = 1;

document.querySelector('.next').addEventListener('click', function(){
    if (i == 1) {
        document.querySelector('.image_container').style.transform = 'translate(-100vw)';
        i += 1;
    } 
    else if (i == 2){
        document.querySelector('.image_container').style.transform = 'translate(-200vw)'; 
        i += 1;
    }
})

document.querySelector('.prev').addEventListener('click', function(){
    if (i == 2) {
        document.querySelector('.image_container').style.transform = 'translate(0)';
        i -= 1;
    } 
    else if (i == 3){
        document.querySelector('.image_container').style.transform = 'translate(-100vw)'; 
        i -= 1;
    }
})