// UPDATE DATA

var visit_id = 0;
var visit_push = false;

window.onload = updateKeys;
setInterval(updateKeys, 3000);


var keysObject = new XMLHttpRequest();

function updateKeys () {
    keysObject.open("GET", "/api/visit.php?id="+visit_id, true);
    keysObject.onreadystatechange = getData;
    keysObject.send(null);
}

function getData () {

    if (keysObject.status == 200) {
        if (keysObject.readyState == 4) {
            var serverResponse = JSON.parse(keysObject.responseText);

            var htmlKeys = document.getElementById("visit");
            //htmlKeys.innerHTML = '';
            for (index = 0; index < serverResponse.length; index++) {
                var htmlKey = document.createElement('tr');

                if(visit_id < parseInt(serverResponse[index].visit_id) ){
                    visit_id = parseInt(serverResponse[index].visit_id);
                }

//SELECT v.visit_id, v.date, v.timeslot, v.name, v.telephone, v.email, r.name as restaurant
                htmlKey.innerHTML = '<th scope="row">' + serverResponse[index].visit_id + '</th>'
                    + '<td>' + serverResponse[index].restaurant + '</td>'
                    + '<td>' + serverResponse[index].date + '</td>'
                    + '<td>' + serverResponse[index].timeslot + '</td>'
                    + '<td>' + serverResponse[index].name + '</td>'
                    + '<td>' + serverResponse[index].telephone + '</td>'
                    + '<td>' + serverResponse[index].email + '</td>';

                htmlKeys.appendChild(htmlKey)

                // push notification:
                if(visit_push){
                    var pushtime = new Date();
                    createToast("Nieuwe visit" , pushtime.toLocaleTimeString() , "Nieuwe visit van " + serverResponse[index].user_name + ".");
                }

            }

            visit_push = true; // enable push meldingen na eerste keer zonder melding
        }
    }
}

// clear list:
document.getElementById("clearVisit").onclick = clearVisit;
function clearVisit () {
    var htmlKeys = document.getElementById("visit");
    htmlKeys.innerHTML = '';
}
