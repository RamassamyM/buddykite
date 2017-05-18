var start_at = $('#start').val();
var end_at = $('#end_at').val();
var price = $('#price').val();
var total = price * (( end_at - start_at ) + 1);

$('#total').val(total);

$( document ).ready(function() {


$( "#start" ).change(function() {


var start_at = $('#start').val();
var end_at = $('#end_at').val();
var price = $('#price').val();


 alert( start_at );

});
$( "#start" ).change(function() {
  alert( "Handler for .change() called." );
});
});

