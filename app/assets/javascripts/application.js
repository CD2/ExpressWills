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
//= require ckeditor/init
//= require_tree .

jQuery("document").ready(function(){
  jQuery('html').addClass("hide_a");
  jQuery("#testator_detail_planning_marrige_true").on("change", function(){
    jQuery("#testator_detail_mirror_will_no").prop('checked',true);
    jQuery("#testator_detail_mirror_will_not_applicable, label[for=testator_detail_mirror_will_not_applicable]").css("display", "none");
  });
  jQuery("#testator_detail_planning_marrige_false").on("change", function(){
    jQuery("#testator_detail_mirror_will_not_applicable, label[for=testator_detail_mirror_will_not_applicable]").css("display", "inline");
  });
  jQuery("#clicking_this").on("click", function(){
    if(jQuery('#residuary_detail_charity_residuary_general_detail_attributes_popular_charity_true').is(':checked')) { jQuery('html').addClass("hide_a"); }
    else { jQuery('html').removeClass("hide_a") }
  })
});

