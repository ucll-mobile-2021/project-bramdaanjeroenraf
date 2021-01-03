// UPDATE DATA

var review_id = 0;
var review_push = false;

window.onload = updateKeys;
setInterval(updateKeys, 3000);


var keysObject = new XMLHttpRequest();

function updateKeys () {
    keysObject.open("GET", "/api/review.php?id="+review_id, true);
    keysObject.onreadystatechange = getData;
    keysObject.send(null);
}

function getData () {

    if (keysObject.status == 200) {
        if (keysObject.readyState == 4) {
            var serverResponse = JSON.parse(keysObject.responseText);

            var htmlKeys = document.getElementById("review");
            //htmlKeys.innerHTML = '';
            for (index = 0; index < serverResponse.length; index++) {
                var htmlKey = document.createElement('tr');

                if(review_id < parseInt(serverResponse[index].review_id) ){
                    review_id = parseInt(serverResponse[index].review_id);
                }

                //SELECT rev.review_id, rev.stars, rev.text, r.name as restaurant_name, u.name as user_name
                htmlKey.innerHTML = '<th scope="row">' + serverResponse[index].review_id + '</th>'
                    + '<td>' + serverResponse[index].restaurant_name + '</td>'
                    + '<td>' + serverResponse[index].user_name + '</td>'
                    + '<td>' + serverResponse[index].stars + '</td>'
                    + '<td>' + serverResponse[index].text + '</td>';

                htmlKeys.appendChild(htmlKey)

                // push notification:
                if(review_push){
                    var pushtime = new Date();
                    createToast("Nieuwe Review" , pushtime.toLocaleTimeString() , serverResponse[index].user_name + " heeft een review geschreven.");
                }

            }

            review_push = true; // enable push meldingen na eerste keer zonder melding
        }
    }
}

// clear list:
document.getElementById("clearReview").onclick = clearReviews;
function clearReviews () {
    var htmlKeys = document.getElementById("review");
    htmlKeys.innerHTML = '';
}
