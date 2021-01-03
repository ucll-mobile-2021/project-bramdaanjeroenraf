$(document).ready(function(){
    $('.toast').toast('show');
  });

function createToast(title, time, content){
    
    var htmlKeys = document.getElementById("toasts_area");
    var htmlKey = document.createElement('div');
    
    
    // <div class="toast" role="alert" aria-live="assertive" aria-atomic="true" data-autohide="false">'
    htmlKey.classList.add("toast");
    //htmlKey.classList.add("show");

    htmlKey.setAttribute("role", "alert");
    htmlKey.setAttribute("aria-live", "assertive");
    htmlKey.setAttribute("aria-atomic", "true");

    htmlKey.setAttribute("data-autohide", "true");
    htmlKey.setAttribute("data-delay", "15000");

    //htmlKey.outerHTML = '<div class="toast" role="alert" aria-live="assertive" aria-atomic="true" data-autohide="false"></div>'
    htmlKey.innerHTML = '<div class="toast-header">'
    +'    <strong class="me-auto">'+ title +'</strong>'
    +'    <small class="text-muted">'+ time +'</small>'
    +'    <button type="button" class="btn-close " data-bs-dismiss="toast" data-dismiss="toast" aria-label="Close"></button>'
    +'</div>'
    +'<div class="toast-body">'
    + content
    +'</div>';

    $(htmlKey).toast('show');

    htmlKeys.appendChild(htmlKey);
}

// gebruik:
createToast("New Reservation1" , "3/12/2021","content");


