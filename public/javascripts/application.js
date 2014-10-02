// shows the image description
//  http://localhost:3000/image_shells/30/images/new?request_id=29#
function showImageDescription(target)
{
	$("#metadata").css("display", "block");
}
/*
* signup page.  Copies 
*/
$("#same_as_billing_na").click(function (e){
	if(e.target.checked)
	{
		$("#user_billing_address").attr("value", 	$("#user_contact_address").attr("value") );
		$("#user_billing_state").attr("value", 		$("#user_contact_state").attr("value") );
		$("#user_billing_zip").attr("value", 			$("#user_contact_zip").attr("value") );
		$("#user_billing_city").attr("value", 		$("#user_contact_city").attr("value") );	
	}
});

$("#delete_stock").click(function (e) { 
	if(e.target.checked)
	{
    $("#thumb_stock").css("display", "none");
    $("#upload_stock").css("display", "block");
	} 
	else
	{
    $("#thumb_stock").css("display", "block");
    $("#upload_stock").css("display", "none");
	}
});

if (typeof SHRELP == "undefined" || !SHRELP) {
    var SHRELP = {};
}
SHRELP.namespace = function() {
    var A = arguments,
    E = null,
    C,
    B,
    D;
    for (C = 0; C < A.length; C = C + 1) {
        D = ("" + A[C]).split(".");
        E = SHRELP;
        for (B = (D[0] == "SHRELP") ? 1: 0; B < D.length; B = B + 1) {
            E[D[B]] = E[D[B]] || {};
            E = E[D[B]];
        }
    }
    return E;
};
SHRELP.updateCart = function	() {
	// console.log("updateCart")
}

