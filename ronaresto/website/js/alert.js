// UPDATE DATA


var alert_id = 0;
window.onload = updateAlert;
setInterval(updateAlert, 3000);


var alertsObject = new XMLHttpRequest();

function updateAlert () {
    alertsObject.open("GET", "/api/alert.php?id="+alert_id, true);
    alertsObject.onreadystatechange = getDataAlert;
    alertsObject.send(null);
}

function getDataAlert () {
    if (alertsObject.status == 200) {
        if (alertsObject.readyState == 4) {
            var serverResponse = JSON.parse(alertsObject.responseText);

            var htmlKeys = document.getElementById("alert");
            //htmlKeys.innerHTML = '';
            for (index = 0; index < serverResponse.length; index++) {
                var htmlKey = document.createElement('tr');

                if(alert_id < serverResponse[index].alert_id ){
                    alert_id = serverResponse[index].alert_id;
                }

                htmlKey.innerHTML = '<th scope="row">' + serverResponse[index].alert_id + '</th>'
                    + '<td>' + serverResponse[index].restaurant_name + '</td>'
                    + '<td>' + serverResponse[index].table_number + '</td>'
                    + '<td>' + serverResponse[index].time_created + '</td>';

                htmlKeys.appendChild(htmlKey)

            }
        }
    }
}

