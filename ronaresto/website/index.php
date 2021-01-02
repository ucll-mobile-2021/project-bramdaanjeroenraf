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
                <!-- ...nav -->
            </ul>
        </div>

    </nav>

    <main role="main" class="flex-shrink-0">
    

<div class="row align-items-start">
    <div class="col">
    <h1>Reservation</h1>
    <table class="table">
        <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">Restaurant</th>
                <th scope="col">Naam</th>
                <th scope="col">Tijd</th>
            </tr>
        </thead>
        <tbody id="reservation">
        </tbody>
    </table>
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
    </div>
  </div>

    




    </main>

    <script src="js/reservation.js"></script>
    <script src="js/alert.js"></script>







    <!-- Optional JavaScript; choose one of the two! -->

    <!-- Option 1: Bootstrap Bundle with Popper -->
    <!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
-->
    <!-- Option 2: Separate Popper and Bootstrap JS -->
    <!--
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
    -->
  </body>
</html>