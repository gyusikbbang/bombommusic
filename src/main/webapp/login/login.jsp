
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Security-Policy">
    <!-- CORS 설정 -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" >
    <script src="https://developers.kakao.com/sdk/js/kakao.min.js" ></script>
      <script src="https://apis.google.com/js/platform.js" async defer></script>



    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.2/rollups/aes.js"></script>



    <link href="style.css" rel="stylesheet">
    <title>Document</title>
</head>
<body>
 
<div class="container" id="container">
  <div class="form-container sign-up-container">
    <form method="post" action="user_signup.jsp"> <!--회원가입 포스트-->
      
      <h1>Create an account</h1>
      <div class="sns-container">
      
     
        
       
        <a id="kakao-login-btn" class="sns"><img src="kakao.png" alt="카카오" onclick="kakao();"></a>
        
         



         
         
         
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <script>
 
          Kakao.init('48e8b0f3057251a1da5532aa7fe1abf5'); //발급받은 키 중 javascript키를 사용해준다.
            console.log(Kakao.isInitialized()); // sdk초기화여부판단
    //카카오 회원가입
    function kakao() {
  Kakao.Auth.login({
    success: function (res) {
      var accessToken = Kakao.Auth.getAccessToken(); // 수정: access_token을 가져오는 방법 변경
      Kakao.API.request({
        url: '/v2/user/me',
        success: function (res) {
          console.log(res);
          var memberEmail = res.kakao_account.email;
          var memberId = res.id;
          var memberName = res.properties.nickname;

          var memberPw = btoa(memberId);

          var form = document.createElement('form');
          form.method = 'post';
          form.action = 'kakao_signup.jsp';

          var memberIdInput = document.createElement('input');
          memberIdInput.type = 'hidden';
          memberIdInput.name = 'memberId';
          memberIdInput.value = memberId;

          var memberNameInput = document.createElement('input');
          memberNameInput.type = 'hidden';
          memberNameInput.name = 'memberName';
          memberNameInput.value = memberName;

          var memberEmailInput = document.createElement('input');
          memberEmailInput.type = 'hidden';
          memberEmailInput.name = 'memberEmail';
          memberEmailInput.value = memberEmail;

          var memberPwInput = document.createElement('input');
          memberPwInput.type = 'hidden';
          memberPwInput.name = 'memberPw';
          memberPwInput.value = memberPw;

          form.appendChild(memberIdInput);
          form.appendChild(memberNameInput);
          form.appendChild(memberEmailInput);
          form.appendChild(memberPwInput);

          document.body.appendChild(form);
          form.submit();
        },
        fail: function (error) {
          console.log(error);
        },
      });
    },
    fail: function (error) {
      console.log(error);
    },
  });
}
  
    </script>

    
      </div>
      <span>or use your email for registration</span>

      <input type="text" placeholder="ID" name="memberId" required/>
      <input type="password" placeholder="Password" name = "memberPw" required/>
      <input type="text" placeholder="name" name = "memberName" required/>
      <input type="text" placeholder="Phone" name="memberPhone" required/>
      <input type="email" placeholder="Email" name = "memberEmail" required/>
      <input type="text" placeholder="Address" name = "memberAdrr" required/>
      
      <button>Sign Up</button>
    </form>
  </div>
  <div class="form-container sign-in-container">
    <form method="post" action="loginPro.jsp"> <!--로그인 포스트-->
      <h1>Sign in</h1>
      <div class="sns-container">

        <a class="sns"><img src="kakao.png" alt="카카오" id="kakao-login-btn" onclick="kakaolg();"></a>
        <!-- Kakao Login -->
    
        <script type="text/javascript">
          Kakao.init('48e8b0f3057251a1da5532aa7fe1abf5'); // 발급받은 키 중 javascript 키를 사용
        
          // 카카오 로그인
          function kakaolg() {
  Kakao.Auth.login({
    success: function (res) {
      var accessToken = Kakao.Auth.getAccessToken(); // 수정: access_token을 가져오는 방법 변경
      Kakao.API.request({
        url: '/v2/user/me',
        success: function (res) {
          console.log(res);
          var memberEmail = res.kakao_account.email;
          var memberId = res.id;
          var memberName = res.properties.nickname;

          var form = document.createElement("form");
          form.method = "POST";
          form.action = "kakaopro.jsp";

          var inputMemberId = document.createElement("input");
          inputMemberId.type = "hidden";
          inputMemberId.name = "memberId";
          inputMemberId.value = memberId;
          form.appendChild(inputMemberId);

          var inputMemberName = document.createElement("input");
          inputMemberName.type = "hidden";
          inputMemberName.name = "memberName";
          inputMemberName.value = memberName;
          form.appendChild(inputMemberName);

          var inputMemberEmail = document.createElement("input");
          inputMemberEmail.type = "hidden";
          inputMemberEmail.name = "memberEmail";
          inputMemberEmail.value = memberEmail;
          form.appendChild(inputMemberEmail);

          var inputMemberPw = document.createElement("input");
          inputMemberPw.type = "hidden";
          inputMemberPw.name = "memberPw";
          inputMemberPw.value = memberId; // 이 부분을 원하는 비밀번호 값으로 변경
          form.appendChild(inputMemberPw);

          document.body.appendChild(form);
          form.submit();
        },
        fail: function (error) {
          console.log(error);
        },
      });
    },
    fail: function (error) {
      console.log(error);
    },
  });
}
        </script>
       
        
        
        
        
        
        
        
        
      </div>
      <span>or use your account</span>
      <input type="text" placeholder="ID" name ="memberId" required/>
      <input type="password" placeholder="Password" name="memberPw"  required/>
      <a href="#">Forgot your password?</a>
      <button>Sign In</button>
    </form>
  </div>
  <div class="overlay-container">
    <div class="overlay">
      <div class="overlay-panel overlay-left">
        <h1>Thank you for signing up
</h1>
        <p>To keep connected with us please login with your personal info</p>
        <button class="ghost" id="signIn">Sign In</button>
      </div>
      <div class="overlay-panel overlay-right">
        <h1>Hello, everyone
        </h1>
        <div class="talk"><p>If you are not a member, please press the membership button to sign up</p></div>
        <button class="ghost" id="signUp">Sign Up</button>
        
        <script>
            const signUpButton = document.getElementById('signUp');
            const signInButton = document.getElementById('signIn');
            const container = document.getElementById('container');
            
            signUpButton.addEventListener('click', () => {
              container.classList.add("right-panel-active");
            });
            
            signInButton.addEventListener('click', () => {
              container.classList.remove("right-panel-active");
            });
        </script>
      </div>
    </div>
  </div>
</div>
</body>
</html>