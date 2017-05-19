$(document).ready(function(){
  $('.input-daterange').datepicker({
      weekStart: 1,
      maxViewMode: 2,
      todayBtn: "linked",
      daysOfWeekHighlighted: "0,6",
      autoclose: true,
      todayHighlight: true,
      toggleActive: true
  });
});
