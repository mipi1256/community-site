<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Game Page</title>

  <%@ include file="../include/static-head.jsp" %>


  <link rel="stylesheet" href="/assets/css/header.css">
  <link rel="stylesheet" href="/assets/css/gamerps.css" >
  <link rel="stylesheet" href="/assets/css/snb.css" >
    
</head>
<body>

  <!-- 헤더 -->
  <%@ include file="../include/header.jsp" %>
  
  <!-- 사이드바 -->
  <%@ include file="../include/snb.jsp" %>

  <!-- 게임 화면 -->

  <div class="wrapper">
    <section class="rps">
      <h2> 가위바위보 </h2>



      <!-- 베팅금액 입력하기 -->
      <div class="rps-bet">

        <!-- <form id="rps-betting" action="/home/rps/bet" method="post"> -->
          <input type="text" id="bet-point" name="bp" placeholder="베팅 금액을 입력해주세요">P <br>
          <div id="bet-btn">
            <button>제출</button>
          </div>
        <!-- </form> -->

      </div>
      


      
      <!-- 가위바위보 선택 -->
      <div class="rps-game">

        <!-- <form id="gameForm" action="/home/rps/game" method="POST">
          <input type="hidden" id="choiceInput" name="choice">
        </form> -->
      
        <button id="rock" class="rps-btn" ><img src="/assets/img/rock_image.jpg" alt="Rock"></button>
        <button id="paper" class="rps-btn" ><img src="/assets/img/paper_image.jpg" alt="Paper"></button>
        <button id="scissors" class="rps-btn" ><img src="/assets/img/scissors_image.jpg" alt="Scissors"></button>  

      </div>

      <!-- 가위바위보 진행중 -->
      <div class="progress-box">
        <div class="progress" role="progressbar" aria-label="Example 20px high" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" style="height: 20px">
          <div class="progress-bar"></div>
        </div>
      </div>

      <!-- 가위바위보 결과 -->

      <div class="result">
        <div id="win">이겼습니다! 원금의 2배 획득</div>
        <div id="draw">무승부입니다.</div>
        <div id="lose">패배입니다...</div>
        <a class="btn btn-primary" href="/home/rps" role="button">다시 하기</a>
      </div>

      
    </section>
    
  </div>
  





  <script>
    // 베팅
    const $betButton = document.getElementById('bet-btn'); // 베팅 버튼
    const $betPoint = document.getElementById('bet-point'); // 베팅 포인트

    const $rpsBet = document.querySelector('.rps-bet'); // 베팅 영역
    const $rpsArea = document.querySelector('.rps-game'); // 게임 영역
    const $form = document.getElementById('rps-betting') // form 태그

    const myPoint = 30000; // 내 포인트
    const minPoint = 5000; // 최소 베팅 포인트
    let betPoint = -1; // 입력 베팅 포인트

    const $rpsBtn = document.querySelectorAll('.rps-btn'); // 가위바위보 최종 버튼
    let rpsResult; // 가위바위보 결과 from 서버

    $betButton.onclick = e => {
      console.log("베팅 버튼 클릭");
      betPoint = $betPoint.value.trim();
      console.log(betPoint);

      if (isNaN(betPoint)) { // 문자열로 입력한 경우
        alert('올바른 형식으로 입력해주세요.');
        event.preventDefault(); // form submit 중단
        return;
      } else if (betPoint > myPoint) { // 자신의 포인트보다 더 많은 금액을 베팅한 경우
        alert('포인트가 부족합니다.');
        return;
      } else if (betPoint < minPoint) {
        alert('최소 5000P이상 베팅하셔야 합니다.');
        return;



      } else {

        $rpsBet.style.display = 'none';
        $rpsArea.style.display = 'block';

      }

      

    };

    $resultScreen = document.querySelector('section.rps .result');

    // 결과 화면
    function whatResultOnScreen(rr) { // rr : 가위바위보 결과 (WIN, DRAW, LOSE 중 하나)
      console.log("스크린 화면 결정 스크립트 실행!");
      console.log('rr: ', rr);

      $resultScreen.style.display = 'block';

      if (rr === 'WIN') {
        console.log("승리");
        document.getElementById('win').style.display = 'block';
        document.getElementById('draw').style.display = 'none';
        document.getElementById('lose').style.display = 'none';

      } else if (rr === 'DRAW') {
        document.getElementById('draw').style.display = 'block';
        document.getElementById('win').style.display = 'none';
        document.getElementById('lose').style.display = 'none';

      } else { // LOSE
        document.getElementById('lose').style.display = 'block';
        document.getElementById('win').style.display = 'none';
        document.getElementById('draw').style.display = 'none';

      }


    }




    // 가위바위보 입력값을 서버에 전송
    function sendChoice(choice) {
      fetch('/home/rps/game', {
          method: 'POST',
          headers: {
              'content-type': 'application/json'
          },
          body: JSON.stringify({ 
            'betPoint': betPoint,
            'choice': choice 
          })
      })
      .then(response => response.text())
      .then(data => {
          console.log('Server response:', data);
          // Handle server response as needed
          rpsResult = data;
      })
      .catch(error => {
          console.error('There was a problem with the fetch operation:', error);
      });

      $rpsArea.style.display = 'none';
      document.querySelector('.progress-box').style.display = 'block';

      // 2초 뒤 실행
      setTimeout(function() {
        console.log('rpsResult: ', rpsResult);
        document.querySelector('.progress-box').style.display = 'none';
        whatResultOnScreen(rpsResult);
      }, 2000);

      
      
    }


    // 가위 or 바위 or 보 버튼 중 하나를 클릭 시
    document.getElementById("scissors").addEventListener("click", function() {
        sendChoice("scissors");
    });

    document.getElementById("rock").addEventListener("click", function() {
        sendChoice("rock");
    });

    document.getElementById("paper").addEventListener("click", function() {
        sendChoice("paper");
    });





  </script>
  
</body>
</html>