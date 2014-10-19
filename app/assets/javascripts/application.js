// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function checkForm()
  {
    var valid = true;
    $('#yolo input[type="text"]').each(function(){
        // If it's empty, or not a number.
        if (this.value == "" || this.value == null || isNaN(this.value)) // regular expression for numbers only.
        {
          $(this).css("border", "1px solid red");
          $(this).attr("placeholder", "Please enter a number");
          valid = false;
        }
    });
    return valid;
  }

$(document).ready(function(){
  var click_count = 2;
  var distance_field = '<label for="distance">Race distance:</label>  <input class="form-control" id="distance" name="run['+click_count+'][distance]" type="text">';
  var hours_field = '<label for="hours">Hours:</label>  <input class="form-control" id="hours" name="run['+click_count+'][hours]" type="text">';
  var minutes_field = '<label for="minutes">Minutes:</label>  <input class="form-control" id="minutes" name="run['+click_count+'][minutes]" type="text">';
  var seconds_field = '<label for="seconds">Seconds:</label>  <input class="form-control" id="seconds" name="run['+click_count+'][seconds]" type="text">';


  // Adding additional runs to the form.
  $("#addrun").click(function(){
    distance_field = '<label for="distance">Race distance:</label>  <input class="form-control" id="distance" name="run['+click_count+'][distance]" type="text">';
    hours_field = '<label for="hours">Hours:</label>  <input class="form-control" id="hours" name="run['+click_count+'][hours]" type="text">';
    minutes_field = '<label for="minutes">Minutes:</label>  <input class="form-control" id="minutes" name="run['+click_count+'][minutes]" type="text">';
    seconds_field = '<label for="seconds">Seconds:</label>  <input class="form-control" id="seconds" name="run['+click_count+'][seconds]" type="text">';

    $("#inner_form").append('<h3>Run '+(click_count+1)+': </h3>');
    $("#inner_form").append(distance_field);
    $("#inner_form").append(hours_field);
    $("#inner_form").append(minutes_field);
    $("#inner_form").append(seconds_field);
    click_count++;
  });

  // Form validation.
  $("#querybtn").click(function(e){
    e.preventDefault();
    if(checkForm() == true) { $("#yolo").submit(); }
  });

  // Form buttons.
  $("#gender-btn-male").click(function(){
    $("#gender-btn-male").attr('class', 'btn btn-info')
    $("#gender-btn-female").attr('class', 'btn btn-default')
    $("#gender_Male").prop("checked", true)
    $("#gender_Female").prop("checked", false)
  });
  $("#gender-btn-female").click(function(){
    $("#gender-btn-female").attr('class', 'btn btn-info')
    $("#gender-btn-male").attr('class', 'btn btn-default')
    $("#gender_Female").prop("checked", true)
    $("#gender_Male").prop("checked", false)
  });
  $("#fitness-btn-0").click(function(){
    $("#fitness-btn-0").attr('class', 'btn btn-info')
    $("#fitness-btn-1").attr('class', 'btn btn-default')
    $("#fitness-btn-2").attr('class', 'btn btn-default')
    $("#fitness_0").prop("checked", true);
    $("#fitness_1").prop("checked", false)
    $("#fitness_2").prop("checked", false)
  });
  $("#fitness-btn-1").click(function(){
    $("#fitness-btn-1").attr('class', 'btn btn-info')
    $("#fitness-btn-0").attr('class', 'btn btn-default')
    $("#fitness-btn-2").attr('class', 'btn btn-default')
    $("#fitness_1").prop("checked", true);
    $("#fitness_0").prop("checked", false)
    $("#fitness_2").prop("checked", false)
  });
  $("#fitness-btn-2").click(function(){
    $("#fitness-btn-2").attr('class', 'btn btn-info')
    $("#fitness-btn-0").attr('class', 'btn btn-default')
    $("#fitness-btn-1").attr('class', 'btn btn-default')
    $("#fitness_2").prop("checked", true);
    $("#fitness_0").prop("checked", false)
    $("#fitness_1").prop("checked", false)
  });

});
