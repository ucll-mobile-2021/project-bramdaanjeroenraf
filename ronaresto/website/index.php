<?php
$titel = "Reservation & Alert";
include "include/header.php";
?>

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