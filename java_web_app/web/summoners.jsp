<%-- 
    Document   : summoners
    Created on : 13-jul-2016, 14:09:37
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

    <title>Summoners</title>

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
    
    <!--     Pie charts          -->
    <style>
        .chartdiv {
            width: 100%;
            height: 500px;
            font-size: 20px;
        }
    </style>
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
          <a class="btn btn-icon icon-prev" type="button" onclick="goBack()"><i class="fa fa-angle-left"></i></a>
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
    
    <div id="navbar-full">
        <div id="navbar">
            <div class="navigation-example" style="background-image: url('http://ddragon.leagueoflegends.com/cdn/img/champion/splash/${skinName}.jpg');">
                <nav class="navbar navbar-ct-transparent" role="navigation-demo" style="background:rgba(0,0,0,0.25);">
                    <div class="container">
                      <!-- Brand and toggle get grouped for better mobile display -->
                      <div class="navbar-header">
                        <h2 style="color: white">Summoner spells win per lane</h2>
                      </div>
                      
                  <!-- Collect the nav links, forms, and other content for toggling -->
                      <div class="collapse navbar-collapse" id="navigation-example-2">
                      </div><!-- /.navbar-collapse -->
                    </div><!-- /.container-->
                </nav>    
            </div>
        </div>
        
        <div id="carousel">
            <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
            <div class="carousel slide" data-ride="carousel">

                  <!-- Indicators -->
                  <ol class="carousel-indicators">
                    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                    <li data-target="#carousel-example-generic" data-slide-to="3"></li>
                  </ol>

                  <!-- Wrapper for slides -->
                  <div class="carousel-inner">
                    <div class="item active">
                      <h3>Top</h3>
                      <c:choose>
                          <c:when test="${top != null}">
                              <div id="chartdivtop" class="chartdiv"></div>
                          </c:when>
                          <c:otherwise>
                              <h4 class="chartdiv text-center">Nothing to show here yet</h4>
                          </c:otherwise>
                      </c:choose>
                    </div>
                    <div class="item">
                      <h3>Jungle</h3>
                      <c:choose>
                          <c:when test="${jun != null}">
                              <div id="chartdivjun" class="chartdiv"></div>
                          </c:when>
                          <c:otherwise>
                              <h4 class="chartdiv text-center">Nothing to show here yet</h4>
                          </c:otherwise>
                      </c:choose>
                    </div>
                    <div class="item">
                      <h3>Mid</h3>
                      <c:choose>
                          <c:when test="${mid != null}">
                              <div id="chartdivmid" class="chartdiv"></div>
                          </c:when>
                          <c:otherwise>
                              <h4 class="chartdiv text-center">Nothing to show here yet</h4>
                          </c:otherwise>
                      </c:choose>
                    </div>
                    <div class="item">
                      <h3>Bot</h3>
                      <c:choose>
                          <c:when test="${bot != null}">
                              <div id="chartdivbot" class="chartdiv"></div>
                          </c:when>
                          <c:otherwise>
                              <h4 class="chartdiv text-center">Nothing to show here yet</h4>
                          </c:otherwise>
                      </c:choose>
                    </div>
                  </div>

                  <!-- Controls -->
                  <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
                    <span class="fa fa-angle-left"></span>
                  </a>
                  <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
                    <span class="fa fa-angle-right"></span>
                  </a>
            </div>
        </div> <!-- end carousel -->
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

<!--     Pie charts          -->
<script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
<script src="https://www.amcharts.com/lib/3/pie.js"></script>
<script src="https://www.amcharts.com/lib/3/themes/light.js"></script>
<script src="https://www.amcharts.com/lib/3/themes/none.js"></script>

<script>
    <c:if test="${top != null}">
    var charttop = AmCharts.makeChart( "chartdivtop",
    {
        "type": "pie",
        "theme": "light",
        "dataProvider": ${top},
        "titleField": "summoners",
        "valueField": "wins",
        "labelRadius": 20,

        "radius": "30%",
        "innerRadius": "65%",
        "labelText": "[[title]]",
        "export": {
          "enabled": true
        }
    });
    </c:if>
    
    <c:if test="${jun != null}">
    var chartjun = AmCharts.makeChart( "chartdivjun",
    {
        "type": "pie",
        "theme": "light",
        "dataProvider": ${jun},
        "titleField": "summoners",
        "valueField": "wins",
        "labelRadius": 20,

        "radius": "30%",
        "innerRadius": "65%",
        "labelText": "[[title]]",
        "export": {
          "enabled": true
        }
    });
    </c:if>
    
    <c:if test="${mid != null}">
    var chartmid = AmCharts.makeChart( "chartdivmid", 
    {
        "type": "pie",
        "theme": "light",
        "dataProvider": ${mid},
        "titleField": "summoners",
        "valueField": "wins",
        "labelRadius": 20,

        "radius": "30%",
        "innerRadius": "65%",
        "labelText": "[[title]]",
        "export": {
          "enabled": true
        }
    });
    </c:if>
    
    <c:if test="${bot != null}">
    var chartbot = AmCharts.makeChart( "chartdivbot", 
    {
        "type": "pie",
        "theme": "light",
        "dataProvider": ${bot},
        "titleField": "summoners",
        "valueField": "wins",
        "labelRadius": 20,

        "radius": "30%",
        "innerRadius": "65%",
        "labelText": "[[title]]",
        "export": {
          "enabled": true
        }
    });
    </c:if>
</script>

<script>
function goBack() {
    window.history.back();
}
</script>

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-69985612-2', 'auto');
  ga('send', 'pageview');

</script>
</html>

