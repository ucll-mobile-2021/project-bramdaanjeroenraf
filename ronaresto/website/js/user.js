// UPDATE DATA

var user_id = 0;
var user_push = false;

window.onload = updateKeys;
setInterval(updateKeys, 3000);


var keysObject = new XMLHttpRequest();

function updateKeys () {
    keysObject.open("GET", "/api/user.php?id="+user_id, true);
    keysObject.onreadystatechange = getData;
    keysObject.send(null);
}

function getData () {

    if (keysObject.status == 200) {
        if (keysObject.readyState == 4) {
            var serverResponse = JSON.parse(keysObject.responseText);

            var htmlKeys = document.getElementById("user");
            //htmlKeys.innerHTML = '';
            for (index = 0; index < serverResponse.length; index++) {
                var htmlKey = document.createElement('tr');

                if(user_id < parseInt(serverResponse[index].user_id) ){
                    user_id = parseInt(serverResponse[index].user_id);
                }


                htmlKey.innerHTML = '<th scope="row">' + serverResponse[index].user_id + '</th>'
                    + '<td>' + serverResponse[index].name + '</td>'
                    + '<td>' + serverResponse[index].email + '</td>'
                    + '<td>' + serverResponse[index].telephonenumber + '</td>';

                htmlKeys.appendChild(htmlKey)

                // push notification:
                if(user_push){
                    var pushtime = new Date();
                    createToast("Nieuwe User" , pushtime.toLocaleTimeString() , serverResponse[index].user_name + " heeft een account gemaakt.");
                }

            }

            user_push = true; // enable push meldingen na eerste keer zonder melding
        }
    }
}

// clear list:
document.getElementById("clearUser").onclick = clearUser;
function clearUser () {
    var htmlKeys = document.getElementById("user");
    htmlKeys.innerHTML = '';
}
