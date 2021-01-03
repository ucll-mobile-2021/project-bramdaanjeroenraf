// UPDATE DATA

var reservation_id = 0;
var reservation_push = false;

window.onload = updateKeys;
setInterval(updateKeys, 3000);


var keysObject = new XMLHttpRequest();

function updateKeys () {
    keysObject.open("GET", "/api/reservation.php?id="+reservation_id, true);
    keysObject.onreadystatechange = getData;
    keysObject.send(null);
}

function getData () {

    if (keysObject.status == 200) {
        if (keysObject.readyState == 4) {
            var serverResponse = JSON.parse(keysObject.responseText);

            var htmlKeys = document.getElementById("reservation");
            //htmlKeys.innerHTML = '';
            for (index = 0; index < serverResponse.length; index++) {
                var htmlKey = document.createElement('tr');

                if(reservation_id < parseInt(serverResponse[index].reservation_id) ){
                    reservation_id = parseInt(serverResponse[index].reservation_id);
                }

                htmlKey.innerHTML = '<th scope="row">' + serverResponse[index].reservation_id + '</th>'
                    + '<td>' + serverResponse[index].restaurant_name + '</td>'
                    + '<td>' + serverResponse[index].user_name + '</td>'
                    + '<td>' + serverResponse[index].number + '</td>'
                    + '<td>' + serverResponse[index].date + ' ' + serverResponse[index].timeslot.substring(0,5) + '</td>';

                htmlKeys.appendChild(htmlKey)

                // push notification:
                if(reservation_push){
                    var pushtime = new Date();
                    createToast("Nieuwe Reservatie" , pushtime.toLocaleTimeString() , serverResponse[index].user_name + " heeft een reservatie gemaakt.");
                }

            }

            reservation_push = true; // enable push meldingen na eerste keer zonder melding
        }
    }
}

// clear list:
document.getElementById("clearReservations").onclick = clearReservations;
function clearReservations () {
    var htmlKeys = document.getElementById("reservation");
    htmlKeys.innerHTML = '';
}
