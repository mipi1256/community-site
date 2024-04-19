<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>

  <!-- 폰트 -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Dongle&display=swap" rel="stylesheet">


  <%@ include file="../include/static-head.jsp" %>
  <link rel="stylesheet" href="/assets/css/market.css">
  <link rel="stylesheet" href="/assets/css/snb.css">



</head>

<body>

  <%@ include file="../include/snb.jsp" %>


  <!-- 가운데 Content -->
  <div class="wrapper">

    <!-- ContentBox 내용 제일 위-->
    <div class="content-box">


      <%@ include file="../market/subMarketUserHeader.jsp" %>
      <!-- Head 내용 -->



      <!-- Title 내용 -->


      <div class="title">


        <div class="titleContentBox">
          <span>#작성자 : </span><span id="textWriter">${b.textWriter}</span><span>(본인인증완료)</span>
          <span>#신용도 : </span><span id="rate">9.3/10</span>
          <span>#작성시간 : </span><span id="updateDate">${b.updateDate}</span><br>
          <span>#제목 : </span><span id="textTitle">${b.textTitle}</span>
          <span>#가격 : </span><span id="price">200000</span><span>원</span>
          <span>#판매자 선호 거래지역 : </span><span id="location">신촌역</span>
        </div>
      </div>




      <!-- Content 내용 -->
      <div class="content-group">
        <div class="Content1">
          <span class="content-Write"><a href="/market/write">글쓰기</a></span>
          <span class="content-Del">삭제</span>
          <span id="modifyBtn" class="content-Rev" type="button" data-bs-toggle="modal"
            data-bs-target="#editModal">수정</span>
          <!-- data-bs-target="#editModal" 속성은 Bootstrap의 JavaScript 모달 -->
          <span class="content-AddFav">상품 즐겨찾기</span>
          <span class="content-Otherproduct">#판매자의 다른상품</span>

        </div>
        <br>
        <div class="ContentBox">
          <span>#글번호 : </span><span id="boardNo">${b.boardNo}</span>
          <img id="ContentImg" src="https://img3.yna.co.kr/etc/inner/EN/2023/08/13/AEN20230813000200315_01_i_P2.jpg" />
          <div class="normal" id="textContent">${b.textContent}</div>
        </div>
        <!-- 지도 -->
        <%@ include file="../market/subMap.jsp" %>
      </div>


      <!-- 수정 내용 입력 모달 -->
      <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel"
        aria-hidden="true">

        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="editModalLabel">내용 수정</h5>
            </div>

            <div class="modal-body">
              <!-- 내용 수정 폼 -->
              <form id="editForm">
                <div class="form-group">
                  <label for="editedContent">수정할 내용</label>
                  <textarea class="form-control-lg" id="editedContent" rows="10"></textarea>
                </div>
              </form>
            </div>


            <div class="modal-footer">
              <!-- 닫기 버튼 -->
              <button type="button" class="btn btn-secondary" id="closeBtn" data-dismiss="modal">닫기</button>
              <!-- 수정 완료 버튼 -->
              <button type="button" class="btn btn-primary" id="saveEdit">수정 완료</button>
            </div>
          </div>
        </div>
      </div>

      <!-- Reply 내용 -->
      <%@ include file="../market/subMarketReply.jsp" %>

      <!-- 광고 영역 -->
      <%@ include file="../market/subMarketAD.jsp" %>

    </div>

  </div>





  <script>
    const URL = '/market';
    const bno = '${b.boardNo}';

    // 수정 버튼 이벤트 발생
    const $modifyBtn = document.getElementById('modifyBtn');
    const $saveBtn = document.getElementById('saveEdit');
    const $editedContent = document.getElementById('editedContent');
    const $boardNo = document.getElementById('boardNo'); //. 찍기
    const $closeBtn = document.getElementById('closeBtn');


    $modifyBtn.onclick = e => {
      console.log('수정 버튼 이벤트 발생!');

      $editedContent.value = document.getElementById('textContent').textContent;
      console.log($editedContent.value);
      makeModifyClickHandler();
      makeCloseClickHandler();
    }

    function makeCloseClickHandler() {
      $closeBtn.onclick = e => {
        console.log('닫기 버튼 클릭!');
        const modal = document.getElementById('editModal');
        modal.style.display = "none"; // 모달을 숨김
        
      };
    }

    function makeModifyClickHandler() {


      if ($saveBtn) {
        $saveBtn.onclick = e => {
          if ($editedContent.value === '') {
            alert('내용은 필수입니다.');
            return;
          }

          const payload = {
            text: $editedContent.value,
            boardNo: $boardNo
          };

          const requestInfo = {
            method: 'PUT',
            headers: {
              'content-type': 'application/json; charset=utf-8'
            },
            body: JSON.stringify(payload)
          };

          fetch(URL, requestInfo)

            .then(res => {
              console.log(res.status);
              if (res.status === 200) {
                alert('내용 정상 변경');
                return res.text();
              } else {
                alert('입력값에 문제가 있습니다.');
                return res.text();
              }
            })

            .then(data => {
              console.log('응답 성공!', data);
              $editedContent.value = '';

            });

        };
      }
    }


    /* 친구 정보 
    const $friends = document.querySelector('.friends');
    const $userInformation = document.getElementById('user-information');
    const $xBtn = document.getElementById('x-btn');

    $friends.onclick = e => {
      if (!e.target.matches('.friend')) return;
      e.preventDefault();

      // #user-information 의 p태그가 누른 대상의 닉네임이 되어야 한다.
      $userInformation.style.display = 'block';

    };

    $xBtn.onclick = e => {
      console.log('x버튼 클릭');
      $userInformation.style.display = 'none';
    }


    const $del = document.querySelector('.content-Del');
    $del.onclick = e => {
      if (!e.target.matches('.del')) return;
      e.preventDefault();

      $userInformation.style.display = 'block';
    };

    $xBtn.onclick = e => {
      console.log('x버튼 클릭');
      $userInformation.style.display = 'none';

    }

    */
  </script>


</body>

</html>