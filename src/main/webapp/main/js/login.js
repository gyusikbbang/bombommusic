let loginText = document.getElementsByClassName("loginText");
    id = session.getAttribute("id");

loginTextChange();

function loginTextChange(){
    if(id !== null){
        loginText.innerText="�α׾ƿ�";
    }
}