<%-- 
    Document   : welcome
    Created on : 13-jul-2016, 0:54:10
    Author     : david
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <link rel="icon" type="image/png" href="/assets/paper_img/favicon.png">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

    <title>Home</title>

    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />
    
    <link href="/bootstrap3/css/bootstrap.css" rel="stylesheet" />
    <link href="/assets/css/ct-paper.css" rel="stylesheet"/>
    <link href="/assets/css/demo.css" rel="stylesheet" /> 
    <link href="/assets/css/examples.css" rel="stylesheet" /> 
        
    <!--     Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Montserrat' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300' rel='stylesheet' type='text/css'>
      
</head>
<body> 
    <nav class="navbar navbar-default" role="navigation-demo" id="demo-navbar">
      <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navigation-example-2">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="http://sums.dheraspi.es">Summoner Spells</a>
        </div>
    
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="navigation-example-2">
          <ul class="nav navbar-nav navbar-right">
            <li>
                <a href="https://twitter.com/davidherasp" target="_blank" class="btn btn-simple"><i class="fa fa-twitter"></i> Twitter</a>
            </li>
            <li>
                <a href="https://www.facebook.com/davidherasp" target="_blank" class="btn btn-simple"><i class="fa fa-facebook"></i> Facebook</a>
            </li>
            <li>
                <a href="https://github.com/davidherasp" target="_blank" class="btn btn-simple"><i class="fa fa-github"></i> Github</a>
            </li>
            <li>
                <a href="mailto:davidherasp@gmail.com" target="_blank" class="btn btn-simple btn-tooltip" data-toggle="tooltip" data-placement="bottom" title="" data-original-title="davidherasp@gmail.com"><i class="fa fa-envelope"></i> Email</a>
            </li>
           </ul>
        </div><!-- /.navbar-collapse -->
      </div><!-- /.container-->
    </nav>         
    
    <div class="wrapper">
        <div class="landing-header" style="background-image: url('http://ddragon.leagueoflegends.com/cdn/img/champion/splash/${skinName}.jpg');">
            <div class="container">
                <div class="motto ">
                    <c:choose>
                    <c:when test="${summoner.profileIconID < 0}">
                    <img src="http://ddragon.leagueoflegends.com/cdn/6.15.1/img/profileicon/0.png" alt="Circle Image" class="img-circle img-responsive">    
                    </c:when>
                    <c:otherwise>
                    <img src="http://ddragon.leagueoflegends.com/cdn/6.15.1/img/profileicon/${summoner.profileIconID}.png" alt="Circle Image" class="img-circle img-responsive">    
                    </c:otherwise>
                    </c:choose>
                    
                    <h2 class="title-uppercase" style="color: white">Welcome ${summoner.name}</h2>
                    <h3 style="color: white">Choose wisely</h3>
                    <div class="navbar">
                        <button class="btn btn-info btn-fill" data-toggle="modal" data-target="#myModal">
                          README
                        </button>
                        <a class="btn btn-neutral btn-fill" href="lane_champs_sums">Wins per lane > champ > summoners</a>
                        <a class="btn btn-neutral btn-fill" href="lane_sums">Wins per lane & summoners</a>
                    </div>
                </div>
            </div>    
        </div>    
    </div>
    
    <footer class="footer-demo section-dark">
        <div class="container">
            <nav class="pull-left">
                <ul>
                    <li>
                        <a href="http://www.creative-tim.com">
                            Creative Tim made this UI
                        </a>
                    </li>
                    <li>
                        <a href="http://blog.creative-tim.com">
                           Check its blog
                        </a>
                    </li>
                </ul>
            </nav>
            <div class="copyright pull-right">
                &copy; 2016, made with <i class="fa fa-heart heart"></i> by <a href="http://about.dheraspi.es" target="_blank">davidherasp</a>
            </div>
        </div>
    </footer>
                    
    <!-- Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title" id="myModalLabel">Notice that...</h4>
          </div>
          <div class="modal-body">
              <p>The data that's being downloaded is all the ranked games you've played since day 1, and it takes time. If you played like 100 games it shouldn't take more than a few minutes. But if you have played around 5000 games, take a sit and relax or just go catch some Pokémons.</p>
              <p>I promise you that your data will be there sooner or later.</p>
              <p>If you need some help, have some questions, or want to talk with me, business or not, send me an email to <a href="mailto:davidherasp@gmail.com" target="_blank">davidherasp@gmail.com</a></p>
          </div>
          <div class="modal-footer">
            <div class="center-block">
                <button type="button" class="btn btn-default btn-simple" data-dismiss="modal">Got it!</button>
            </div>
          </div>
        </div>
      </div>
    </div>

</body>

<script src="/assets/js/jquery-1.10.2.js" type="text/javascript"></script>
<script src="/assets/js/jquery-ui-1.10.4.custom.min.js" type="text/javascript"></script>

<script src="/bootstrap3/js/bootstrap.js" type="text/javascript"></script>

<!--  Plugins -->
<script src="/assets/js/ct-paper-checkbox.js"></script>
<script src="/assets/js/ct-paper-radio.js"></script>
<script src="/assets/js/bootstrap-select.js"></script>
<script src="/assets/js/bootstrap-datepicker.js"></script>

<script src="/assets/js/ct-paper.js"></script>

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-69985612-2', 'auto');
  ga('send', 'pageview');

</script>
    
</html>
