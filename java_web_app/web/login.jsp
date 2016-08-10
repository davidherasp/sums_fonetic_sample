<%-- 
    Document   : index
    Created on : 12-jul-2016, 21:39:01
    Author     : david heras pino
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <link rel="icon" type="image/png" href="/assets/paper_img/favicon.png">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

    <title>Summoner Spells Login</title>

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
    
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
</head>
<body>
    <nav class="navbar navbar-ct-transparent navbar-fixed-top" role="navigation-demo" id="register-navbar">
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
        <div class="register-background">
            <div class="filter-black"></div>
                <div class="container">
                    <div class="row">
                        <div class="col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3 col-xs-10 col-xs-offset-1 ">
                            <div class="register-card">
                                <h3 class="title">Login</h3>
                                <h6 class="title text-danger">${errores.name}</h6>
                                <h6 class="title text-danger">${errores.region}</h6>
                                <form class="register-form" action="/app/validate">
                                    <label>Summoner</label>
                                    <input type="text" class="form-control" name="name" placeholder="Summoner name" value="${old.name}">

                                    <label>Region</label>
                                    <select name="region" class="form-control">
                                        <option value="EUW">EU West</option>
                                        <option value="EUNE">EU Nordic & East</option>
                                        <option value="NA">North America</option>
                                        <option value="LAN">LAN</option>
                                        <option value="LAS">LAS</option>
                                        <option value="BR">Brazil</option>
                                        <option value="TR">Turkey</option>
                                        <option value="RU">Russia</option>
                                        <option value="OCE">Oceania</option>
                                        <option value="KR">Korea</option>
                                        <option value="JP">Japan</option>
                                    </select>
                                    <button class="btn btn-info btn-block" type="submit">Go</button>
                                </form>
                                <a class="btn btn-warning" href="http://eepurl.com/caISOP" target="_blank">Subscribe</a>
                            </div>
                        </div>
                    </div>
                </div>
            <div class="footer register-footer text-center">
                <h6>&copy; 2016, made with <i class="fa fa-heart heart"></i> by <a href="http://about.dheraspi.es" target="_blank">davidherasp</a></h6>
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

