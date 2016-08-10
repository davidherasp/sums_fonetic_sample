<%--
    Document   : champs
    Created on : 28-jul-2016, 0:54:32
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

    <title>Lanes and champs</title>

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

    <style>
    #treemap_container {
        min-width: 300px;
        max-width: 600px;
        margin: 0 auto;
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
                        <h2 style="color: white">Wins per lane > champs > sums</h2>
                      </div>
                  <!-- Collect the nav links, forms, and other content for toggling -->
                      <div class="collapse navbar-collapse" id="navigation-example-2">
                      </div><!-- /.navbar-collapse -->
                    </div><!-- /.container-->
                </nav>
            </div>
        </div>
    </div>

    <div class="main">
        <div class="section">
         <div class="container tim-container" style="height: 500px;">
             <c:if test="${champs != null}">
             <div id="treemap_container">
                 
             </div>
             </c:if>
             <c:if test="${champs == 'empty'}">
                 <h4 class="text-center">Nothing to show here yet...</h4>
             </c:if>
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

<!--     Treemap chart          -->
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/heatmap.js"></script>
<script src="https://code.highcharts.com/modules/treemap.js"></script>


<script>
    <c:if test="${champs != null}">
        $(function () {
        var data = ${champs},
            points = [],
            regionP,
            regionVal,
            regionI = 0,
            countryP,
            countryI,
            causeP,
            causeI,
            region,
            country,
            cause,
            causeName = {
                'Flash-Teleport':'Flash, Teleport',
                'Flash-Ignite': 'Flash, Ignite',
                'Flash-Heal': 'Flash, Heal',
                'Flash-Exhaust': 'Flash, Exhaust',
                'Flash-Smite': 'Flash, Smite',
                'Flash-Ghost': 'Flash, Ghost',
                'Flash-Barrier': 'Flash, Barrier',
                'Flash-Cleanse': 'Flash, Cleanse',
                'Flash-Clarity': 'Flash, Clarity',
                
                'Teleport-Flash': 'Teleport, Flash',
                'Teleport-Ignite': 'Teleport, Ignite',
                'Teleport-Heal': 'Teleport, Heal',
                'Teleport-Exhaust': 'Teleport, Exhaust',
                'Teleport-Smite': 'Teleport, Smite',
                'Teleport-Ghost': 'Teleport, Ghost',
                'Teleport-Barrier': 'Teleport, Barrier',
                'Teleport-Cleanse': 'Teleport, Cleanse',
                'Teleport-Clarity': 'Teleport, Clarity',
                
                'Ignite-Flash': 'Ignite, Flash',
                'Ignite-Teleport':'Ignite, Teleport',
                'Ignite-Heal': 'Ignite, Heal',
                'Ignite-Exhaust': 'Ignite, Exhaust',
                'Ignite-Smite': 'Ignite, Smite',
                'Ignite-Ghost': 'Ignite, Ghost',
                'Ignite-Barrier': 'Ignite, Barrier',
                'Ignite-Cleanse': 'Ignite, Cleanse',
                'Ignite-Clarity': 'Ignite, Clarity',
                
                'Heal-Flash': 'Heal, Flash',
                'Heal-Teleport':'Heal, Teleport',
                'Heal-Exhaust': 'Heal, Exhaust',
                'Heal-Smite': 'Heal, Smite',
                'Heal-Ghost': 'Heal, Ghost',
                'Heal-Barrier': 'Heal, Barrier',
                'Heal-Cleanse': 'Heal, Cleanse',
                'Heal-Clarity': 'Heal, Clarity',
                'Heal-Ignite': 'Heal, Ignite',
                
                'Exhaust-Flash': 'Exhaust, Flash',
                'Exhaust-Teleport':'Exhaust, F: Teleport',
                'Exhaust-Heal': 'Exhaust, Heal',
                'Exhaust-Smite': 'Exhaust, Smite',
                'Exhaust-Ghost': 'Exhaust, Ghost',
                'Exhaust-Barrier': 'Exhaust, Barrier',
                'Exhaust-Cleanse': 'Exhaust, Cleanse',
                'Exhaust-Clarity': 'Exhaust, Clarity',
                'Exhaust-Ignite': 'Exhaust, Ignite',
                
                'Smite-Flash': 'Smite, Flash',
                'Smite-Teleport':'Smite, Teleport',
                'Smite-Heal': 'Smite, Heal',
                'Smite-Exhaust': 'Smite, Exhaust',
                'Smite-Ghost': 'Smite, Ghost',
                'Smite-Barrier': 'Smite, Barrier',
                'Smite-Cleanse': 'Smite, Cleanse',
                'Smite-Clarity': 'Smite, Clarity',
                'Smite-Ignite': 'Smite, Ignite',
                
                'Ghost-Flash': 'Ghost, Flash',
                'Ghost-Teleport':'Ghost, Teleport',
                'Ghost-Heal': 'Ghost, Heal',
                'Ghost-Exhaust': 'Ghost, Exhaust',
                'Ghost-Smite': 'Ghost, Smite',
                'Ghost-Barrier': 'Ghost, Barrier',
                'Ghost-Cleanse': 'Ghost, Cleanse',
                'Ghost-Clarity': 'Ghost, Clarity',
                'Ghost-Ignite': 'Ghost, Ignite',
                
                'Barrier-Flash': 'Barrier, Flash',
                'Barrier-Teleport':'Barrier, Teleport',
                'Barrier-Heal': 'Barrier, Heal',
                'Barrier-Exhaust': 'Barrier, Exhaust',
                'Barrier-Smite': 'Barrier, Smite',
                'Barrier-Ghost': 'Barrier, Ghost',
                'Barrier-Cleanse': 'Barrier, Cleanse',
                'Barrier-Clarity': 'Barrier, Clarity',
                'Barrier-Ignite': 'Barrier, Ignite',
                
                'Cleanse-Flash': 'Cleanse, Flash',
                'Cleanse-Teleport':'Cleanse, Teleport',
                'Cleanse-Heal': 'Cleanse, Heal',
                'Cleanse-Exhaust': 'Cleanse, Exhaust',
                'Cleanse-Smite': 'Cleanse, Smite',
                'Cleanse-Ghost': 'Cleanse, Ghost',
                'Cleanse-Barrier': 'Cleanse, Barrier',
                'Cleanse-Clarity': 'Cleanse, Clarity',
                'Cleanse-Ignite': 'Cleanse, Ignite',
                
                'Clarity-Flash': 'Clarity, Flash',
                'Clarity-Teleport':'Clarity, Teleport',
                'Clarity-Heal': 'Clarity, Heal',
                'Clarity-Exhaust': 'Clarity, Exhaust',
                'Clarity-Smite': 'Clarity, Smite',
                'Clarity-Ghost': 'Clarity, Ghost',
                'Clarity-Barrier': 'Clarity, Barrier',
                'Clarity-Cleanse': 'Clarity, Cleanse',
                'Clarity-Ignite': 'Clarity, Ignite'
            };

        for (region in data) {
            if (data.hasOwnProperty(region)) {
                regionVal = 0;
                regionP = {
                    id: 'id_' + regionI,
                    name: region,
                    color: Highcharts.getOptions().colors[regionI]
                };
                countryI = 0;
                for (country in data[region]) {
                    if (data[region].hasOwnProperty(country)) {
                        countryP = {
                            id: regionP.id + '_' + countryI,
                            name: country,
                            parent: regionP.id
                        };
                        points.push(countryP);
                        causeI = 0;
                        for (cause in data[region][country]) {
                            if (data[region][country].hasOwnProperty(cause)) {
                                causeP = {
                                    id: countryP.id + '_' + causeI,
                                    name: causeName[cause],
                                    parent: countryP.id,
                                    value: Math.round(+data[region][country][cause])
                                };
                                regionVal += causeP.value;
                                points.push(causeP);
                                causeI = causeI + 1;
                            }
                        }
                        countryI = countryI + 1;
                    }
                }
                regionP.value = Math.round(regionVal / countryI);
                points.push(regionP);
                regionI = regionI + 1;
            }
        }
        $('#treemap_container').highcharts({
            series: [{
                type: 'treemap',
                layoutAlgorithm: 'squarified',
                allowDrillToNode: true,
                animationLimit: 1000,
                dataLabels: {
                    enabled: false
                },
                levelIsConstant: false,
                levels: [{
                    level: 1,
                    dataLabels: {
                        enabled: true
                    },
                    borderWidth: 3
                }],
                data: points
            }],
            subtitle: {
                text: 'Click to drill down into champions and then into summoners'
            },
            title: {
                text: 'Wins per lane'
            }
        });
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
