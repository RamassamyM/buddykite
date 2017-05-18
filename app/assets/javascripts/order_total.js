var start_at = $('#start').val();
var end_at = $('#end_at').val();
var price = $('#price').val();


$('#total').val(price * (( end_at - start_at ) + 1));

