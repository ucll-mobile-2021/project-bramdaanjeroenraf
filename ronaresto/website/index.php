<!doctype html>
<html lang="nl">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">


    <title>ronaresto - Reservation & Alert</title>
	  <link rel="shortcut icon" href="https://www.ucll.be/sites/default/files/favicon.ico" type="image/vnd.microsoft.icon" />
	  <link rel="apple-touch-icon-precomposed" href="https://www.ucll.be/sites/all/themes/balance_theme/apple-touch-icon-precomposed-120x120.png" sizes="120x120" />
	  <link rel="apple-touch-icon-precomposed" href="https://www.ucll.be/sites/all/themes/balance_theme/apple-touch-icon-precomposed-76x76.png" sizes="76x76" />
	  <link rel="apple-touch-icon-precomposed" href="https://www.ucll.be/sites/all/themes/balance_theme/apple-touch-icon-precomposed-152x152.png" sizes="152x152" />
	  <link rel="apple-touch-icon-precomposed" href="https://www.ucll.be/sites/all/themes/balance_theme/apple-touch-icon-precomposed-144x144.png" sizes="144x144" />
	  <link rel="apple-touch-icon-precomposed" href="https://www.ucll.be/sites/all/themes/balance_theme/apple-touch-icon-precomposed-72x72.png" sizes="72x72" />
	  <link rel="apple-touch-icon-precomposed" href="https://www.ucll.be/sites/all/themes/balance_theme/apple-touch-icon-precomposed.png" />
	  <link rel="apple-touch-icon-precomposed" href="https://www.ucll.be/sites/all/themes/balance_theme/apple-touch-icon-precomposed-114x114.png" sizes="114x114" />
	  <link rel="apple-touch-icon-precomposed" href="https://www.ucll.be/sites/all/themes/balance_theme/apple-touch-icon-precomposed-57x57.png" sizes="57x57" />
      
      <link rel="stylesheet" href="css/bootstrap.min.css">
      <link rel="stylesheet" href="css/style.css">
  </head>

  <div class="toast-container bottom-0 end-0" id="toasts_area" style="position: fixed;z-index: 1; padding: 1rem;">
  </div>

  <body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-red">
        <a class="navbar-brand" href="/">
          <img src="https://intranet.ucll.be/sites/all/themes/ucll_intranet/images/logo.svg" width="150" height="55" alt="" loading="lazy">
        </a>

        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="/">Reservation & Alert</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="http://ronaresto.raf-zegers.sb.uclllabs.be/sql/">SQL</a>
                </li>
                <!-- ...nav -->
            </ul>
        </div>

    </nav>

    <main role="main" class="container flex-shrink-0">
    

<div class="row align-items-start">
    <div class="col">
    <h1>Reservation</h1>
    <table class="table">
        <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">Restaurant</th>
                <th scope="col">Naam</th>
                <th scope="col">Personen</th>
                <th scope="col">Tijd</th>
            </tr>
        </thead>
        <tbody id="reservation">
        </tbody>
    </table>
    <button type="button" class="btn btn-link" id="clearReservations">clear reservations</button>
    </div>
    <div class="col">
    <h1>Ober Alert</h1>
    <table class="table">
        <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">Restaurant</th>
                <th scope="col">Tafel</th>
                <th scope="col">Tijd</th>
            </tr>
        </thead>
        <tbody id="alert">
        </tbody>
    </table>
    <button type="button" class="btn btn-link" id="clearAlerts">clear alerts</button>
    </div>
  </div>

    
    </main>


    

    <!-- jquery enz... -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
    <!-- js scripts -->
    <script src="js/toast.js"></script>
    <script src="js/reservation.js"></script>
    <script src="js/alert.js"></script>
  </body>
</html>