<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Plock - plock, play, and print your think!</title>

<!-- Behavioral Meta Data -->
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<link rel="icon" type="image/png" href="img/small-logo-01.png">
<link href='http://fonts.googleapis.com/css?family=Roboto:400,900,900italic,700italic,700,500italic,400italic,500,300italic,300' rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Pacifico' rel='stylesheet' type='text/css'>
<link href='style.css?ver=1.1' rel='stylesheet' type='text/css'>
<link href='styleModal.css' rel='stylesheet' type='text/css'>
<!-- <link href='styleModal.css' rel='stylesheet' type='text/css'> -->

</head>

<jsp:useBean id="datas" scope="request" class="java.util.ArrayList" />
<%! int currentPage, PLOCK_PER_PAGE, totalPage, startNum, endNum; %>
<%
	// It comes through index.jsp, not Control.jsp (then, action==null)
	// OR empty search (then, action == list)
	if (datas.isEmpty()) {
		String action = request.getParameter("action");
		if (action == null)
			response.sendRedirect("Control.jsp");
	}
	try {
		this.currentPage = (Integer) session.getAttribute("currentPage");
		this.PLOCK_PER_PAGE = (Integer) session.getAttribute("PLOCK_PER_PAGE");
		this.totalPage = (Integer) session.getAttribute("totalPage");
		this.startNum = (Integer) session.getAttribute("startNum");
		this.endNum = (Integer) session.getAttribute("endNum");
	} catch (Exception e) {
		out.println(this.currentPage + ", " + this.PLOCK_PER_PAGE + ", " + this.totalPage + ", " + this.startNum
				+ ", " + this.endNum);
	}
%>

<body>

  <a name="ancre"></a>

  <!-- CACHE -->
  <div class="cache"></div>

  <!-- HEADER -->

  <div id="wrapper-header">
    <div id="main-header" class="object">
      <div class="logo">
        <a href="Control.jsp"><img src="img/logo.png" alt="Plock"></a>
      </div>

      <div id="main_tip_search">
        <form method="post" action="Control.jsp">
          <input type="text" name="search" id="tip_search_input" list="search" autocomplete=off required>
        </form>
      </div>
      <!-- The end of main_tip_search -->
      
        <!-- Trigger/Open The Modal -->
        <button id="modalBtn" class="modalButton">3D모델 다운로드(STL)</button>

        <!-- The Modal -->
        <div id="myModal" class="modal">

          <!-- Modal content -->
          <div class="modal-content">
            <div class="modal-header">
              <span class="close">&times;</span>
              <h2>필요한 블록 모델을 골라 다운로드 하세요!</h2>
            </div>
          <div class="modal-body">
            <a class="modalStlImage" href="stl/common.zip" download title="일반적인 STL 파일 다운로드">
            <img src="img/zipimg.png"/>
            <p>일반적인 STL</p>
            </a>
            <a class="modalStlImage" href="stl/smallTop.zip" download title="위가 작은 STL 파일 다운로드">
            <img src="img/zipimg.png"/>
            <p>위가 작은 STL</p>
            </a>
            <a class="modalStlImage" href="stl/smallBottom.zip" download title="아래가 작은 STL 파일 다운로드">
            <img src="img/zipimg.png"/>
            <p>아래가 작은 STL</p>
            </a>
            <a class="modalStlImage" href="stl/small.zip" download title="전체적으로 작은 STL 파일 다운로드">
            <img src="img/zipimg.png"/>
            <p>대체로 작은 STL</p>
            </a>
            <!-- <p>Some other text...</p> -->
          </div>
          <!-- <div class="modal-footer">
              <h3>Modal Footer</h3>
            </div> -->
          </div>
          <!-- The end of Modal content -->
        </div>
        <!-- The end of Modal -->
      
      <div id="stripes"></div>
    </div>
  </div>

  <!-- NAVBAR -->

  <div id="wrapper-navbar">
    <div class="navbar object">
      <div id="wrapper-sorting">
        <div id="wrapper-title-1">
          <div class="top-rated object">Have a nice day!</div>
          <div id="fleche-nav-1"></div>
        </div>
        <!--
        <div id="wrapper-title-2">
          <a href="#"><div class="recent object">Recent</div></a>
          <div id="fleche-nav-2"></div>
        </div>

        <div id="wrapper-title-3">
          <a href="#"><div class="oldies object">Oldies</div></a>
          <div id="fleche-nav-3"></div>
        </div>
        -->
      </div>
      <div id="wrapper-bouton-icon">
        <div id="bouton-ai">
          <img src="img/icon.png" alt="illustrator" title="Simulation" height="28" width="28">
        </div>

      </div>
    </div>
  </div>

  <!-- FILTER -->

  <div id="main-container-menu" class="object">
    <div class="container-menu">

      <div id="main-cross">
        <div id="cross-menu"></div>
      </div>

      <div id="main-small-logo">
        <div class="small-logo"></div>
      </div>

      <div id="main-premium-ressource">
        <div class="premium-ressource">
          <a href="#">Premium resources</a>
        </div>
      </div>

      <div id="main-themes">
        <div class="themes">
          <a href="#">Latest themes</a>
        </div>
      </div>

      <div id="main-psd">
        <div class="psd">
          <a href="#">PSD goodies</a>
        </div>
      </div>

      <div id="main-ai">
        <div class="ai">
          <a href="#">Illustrator freebies</a>
        </div>
      </div>

      <div id="main-font">
        <div class="font">
          <a href="#">Free fonts</a>
        </div>
      </div>

      <div id="main-photo">
        <div class="photo">
          <a href="#">Free stock photos</a>
        </div>
      </div>

    </div>
  </div>


  <!-- PORTFOLIO -->

  <div id="wrapper-container">

    <div class="container object">

      <div id="main-container-image">

        <section class="work">
        <c:forEach var="plock" items="${datas}" varStatus="status" begin="${startNum }" end="${endNum }">

          <figure class="white">
          
          <a href="Control.jsp?action=details&idx=${plock.getIdx()}">
          
          <img onerror="javascript:src='img/noimg.png'" src="${plock.getImage_url()}"alt="" />
            <dl>
              <dt>${plock.getTitle()}</dt>
              <dd>${plock.getC_date()}</dd>
            </dl>
          </a>
          <div id="wrapper-part-info">
            <div class="part-info-image">
              <img src="img/icon.png" alt="그림이 없습니다."/>
            </div>
            <div id="part-info">${plock.getTitle()}</div>
          </div>
          </figure>

        </c:forEach>
        </section>

      </div>

    </div>

    <div id="wrapper-oldnew">
        &nbsp;
        ${currentPage } / ${totalPage }
        <br>
      <div class="oldnew">
        <div class="wrapper-oldnew-prev">
          <a href="Control.jsp?action=list&nextPage=${currentPage-1}">
          <div id="oldnew-prev"></div>
          </a>
        </div>
        <div class="wrapper-oldnew-next">
          <a href="Control.jsp?action=list&nextPage=${currentPage+1}">
          <div id="oldnew-next"></div>
          </a>
        </div>
      </div>
    </div>

    <div id="wrapper-thank">
      <div class="thank">
        <div class="thank-text">
          <span style="letter-spacing: -2px;">plock</span>
        </div>
      </div>
    </div>

    <div id="main-container-footer">
      <div class="container-footer">

        <div id="row-1f">
          <div class="text-row-1f">
            <span style="font-weight: 600; font-size: 15px; color: #666; line-height: 250%; text-transform: uppercase; letter-spacing: 1.5px;">What is Platz</span><br>Platz is a blog showcasing
            hand-picked free themes, design stuff, free fonts and other resources for web designers.
          </div>
        </div>

        <div id="row-2f">
          <div class="text-row-2f">
            <span style="font-weight: 600; font-size: 15px; color: #666; line-height: 250%; text-transform: uppercase; letter-spacing: 1.5px;">How does it work</span><br>Platz offers you all the latest
            freebies found all over the fourth corners without to pay.
          </div>
        </div>

        <div id="row-3f">
          <div class="text-row-3f">
            <span style="font-weight: 600; font-size: 15px; color: #666; line-height: 250%; text-transform: uppercase; letter-spacing: 1.5px;">Get in touch!</span><br>Subscribe our RSS or follow us on
            Facebook, Google+, Pinterest or Dribbble to keep updated.
          </div>
        </div>

        <div id="row-4f">
          <div class="text-row-4f">
            <span style="font-weight: 600; font-size: 15px; color: #666; line-height: 250%; text-transform: uppercase; letter-spacing: 1.5px;">Newsletter</span><br>You will be informed monthly about
            the latest content avalaible.
          </div>

          <div id="main_tip_newsletter">
            <form>
              <input type="text" name="newsletter" id="tip_newsletter_input" list="newsletter" autocomplete=off required>
            </form>
          </div>
        </div>

      </div>
    </div>


    <div id="wrapper-copyright">
      <div class="copyright">
        <div class="copy-text object">
          Copyright © 2016. Template by
          <a sytle="font-weight: bold;" href="https://dcrazed.com/">
          Dcrazed &
          </a>
          Powered by
          <a sytle="font-weight: bold;" href="http://letsgo.woobi.co.kr/">
          Letsgo
          </a>
        </div>

        <div class="wrapper-navbouton">
          <div class="google object"><a href="http://www.google.com">g</a></div>
          <div class="facebook object"><a href="http://www.facebook.com">f</a></div>
          <div class="linkin object">i</div>
          <div class="dribbble object">d</div>
        </div>
      </div>
    </div>

  </div>



  <!-- SCRIPT -->

  <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
  <script type="text/javascript" src="js/jquery.scrollTo.min.js"></script>
  <script type="text/javascript" src="js/jquery.localScroll.min.js"></script>
  <script type="text/javascript" src="js/jquery-animate-css-rotate-scale.js"></script>
  <script type="text/javascript" src="js/fastclick.min.js"></script>
  <script type="text/javascript" src="js/jquery.animate-colors-min.js"></script>
  <script type="text/javascript" src="js/jquery.animate-shadow-min.js"></script>
  <script type="text/javascript" src="js/main.js"></script>
  <script>
  /* madal */
  //Get the modal
  var modal = document.getElementById('myModal');

  // Get the button that opens the modal
  var btn = document.getElementById("modalBtn");

  // Get the <span> element that closes the modal
  var span = document.getElementsByClassName("close")[0];

  // When the user clicks the button, open the modal 
  btn.onclick = function() {
      modal.style.display = "block";
  }

  // When the user clicks on <span> (x), close the modal
  span.onclick = function() {
      modal.style.display = "none";
  }

  // When the user clicks anywhere outside of the modal, close it
  window.onclick = function(event) {
      if (event.target == modal) {
          modal.style.display = "none";
      }
  }
  </script>
  <script>
  
    /* PRELOADER */

    function preloader() {
      if (document.images) {
        var img1 = new Image();
        var img2 = new Image();
        var img3 = new Image();
        var img4 = new Image();
        var img5 = new Image();
        var img6 = new Image();
        var img7 = new Image();
        var img8 = new Image();
        var img9 = new Image();
        var img10 = new Image();
        var img11 = new Image();
        var img12 = new Image();
        var img13 = new Image();
        var img14 = new Image();
        var img15 = new Image();
        var img16 = new Image();
        var img17 = new Image();
        var img18 = new Image();
        var img19 = new Image();
        var img20 = new Image();

        img1.src = "img/psd-4.jpg";
        img2.src = "img/font-1.jpg";
        img3.src = "img/psd-1.jpg";
        img4.src = "img/psd-2.jpg";
        img5.src = "img/ai-1.jpg";
        img6.src = "img/theme-2.jpg";
        img7.src = "img/psd-3.jpg";
        img8.src = "img/font-2.jpg";
        img9.src = "img/font-3.jpg";
        img10.src = "img/ai-2.jpg";
        img11.src = "img/icons-1.jpg";
        img12.src = "img/ui-1.jpg";
        img13.src = "img/font-5.jpg";
        img14.src = "img/theme-2.jpg";
        img15.src = "img/psd-5.jpg";
        img16.src = "img/icons-3.jpg";
        img17.src = "img/font-4.jpg";
        img18.src = "img/theme-3.jpg";
        img19.src = "img/font-6.jpg";
        img20.src = "img/theme-4.jpg";
      }
    }
    function addLoadEvent(func) {
      var oldonload = window.onload;
      if (typeof window.onload != 'function') {
        window.onload = func;
      } else {
        window.onload = function() {
          if (oldonload) {
            oldonload();
          }
          func();
        }
      }
    }
    addLoadEvent(preloader);
  </script>


</body>


</html>
