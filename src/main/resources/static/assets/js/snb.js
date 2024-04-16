// friends의 경우 서버에서 비동기 통신으로 친구 목록을 불러와서
// 객체 디스트럭처링 후 친구 user의 image 컬럼에 들어있는 image 주소를 불러와서
// img src 에 넣으면 된다. (innerHTML로 tag 추가, spring-webmvc의 detail.jsp 파일의 reply 참고)


    
    // 사용자가 현재 머물고 있는 페이지 버튼에 active 스타일 부여 (list.jsp 참고)
    // function appendPageActive() {

    //   // 현재 서버에서 넘겨준 페이지
    //   const currPage = '${}'

    //   if (currPage === '') {
    //     document.getElementById('home').add('active');
    //   } else if () {
    //     document.getElementById('game').add('active');
    //   } else if () {
    //     document.getElementById('secondhand').add('active');
    //   } else if () {
    //     document.getElementById('sports').add('active');
    //   } else if () {
    //     document.getElementById('all').add('active');
    //   } else if () {
    //     document.getElementById('game-board').add('active');
    //   } else if () {
    //     document.getElementById('movie-board').add('active');
    //   } else if () {
    //     document.getElementById('trip-board').add('active');
    //   }

    // }

    /* 친구 정보 */
    const $friends = document.querySelector('.friends');
    const $userInformation = document.getElementById('user-information');
    const $xBtn = document.getElementById('x-btn');

    $friends.onclick = e => {
      if(!e.target.matches('.friend')) return;
      e.preventDefault();
      
      // #user-information 의 p태그가 누른 대상의 닉네임이 되어야 한다.
      $userInformation.style.display = 'block';
      $userInformation.classList.add("animate");

      // 애니메이션이 끝나면 animate 클래스 제거하기
      setTimeout(function() {
          image.classList.remove("animate");
      }, 500); // Adjust the duration to match the transition duration
      
    };

    $xBtn.onclick = e => {
      console.log('x버튼 클릭');
      $userInformation.style.display = 'none';
    }




    /* 채팅 모달창 */
    // const $modal = document.getElementById();

    // addEventListener('click', () => {
    //   $modal.style.display = 'block';
    // });


    // appendPageActive();