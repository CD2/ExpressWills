//DATA-LABEL
$('[data-label]').each(function(){
	var value = $(this).attr('data-label');
	var label = $("<label>")
	if (this.id) {
		label.attr('for', this.id)
	}
	label.text(value);
	$(this).insertBefore(label)
});


//DATA-REQUIRES
$('[data-require]').each(function(){
	var _this = this;
	var require = $(_this).attr('data-require')
	var condition = $(_this).attr('data-condition')
	var ifTrue = $(_this).attr('data-true') || '';
	var ifFalse = $(_this).attr('data-false') || '';

	var type = $(require).attr("type");

	var checkCondition = function() {
		if ($(require).is(condition)) {
			$(_this).addClass(ifTrue);
			$(_this).removeClass(ifFalse);
		} else {
			$(_this).addClass(ifFalse);
			$(_this).removeClass(ifTrue);
		}
	}
	checkCondition();
	if (type) {
		switch(type.toLowerCase()) {
			case "radio":
				$('input[type=' + type + '][name=' + $(require).attr('name') + ']').on("click", checkCondition);
				break;
			case "checkbox":
				$('input[type=' + type + ']').on("click", checkCondition);
				break;
		}
	} else {
		console.log($(require).parent())
		$(require).parent().on("click", checkCondition)
	}

});

//DATA-TOOLTIP
$('[data-tooltip]').each(function(i){
	i++;
	tooltipElement = '<span class="tooltip" data-tooltip-div="' + i + '">'
	$this = $(this)
	if (!$this.attr('data-tooltip-id')) {
		$this.attr('data-tooltip-id', i)
		$this.insertAfter(tooltipElement);
	} 

	var tooltip = $(this).attr('data-tooltip');

	function getTooltipString(elem) {
		return (typeof window[tooltip] === "function")?window[tooltip](elem) || "":tooltip;
	}

	$('.tooltip[data-tooltip-div="' + $(this).attr('data-tooltip-id') + '"]').hide()


	$this.on("focus", function(){
		$tooltip = $('.tooltip[data-tooltip-div="' + $(this).attr('data-tooltip-id') + '"]');
		$tooltip.text(getTooltipString(this));
		$tooltip.show();
	}).on("blur", function(){
		$tooltip = $('.tooltip[data-tooltip-div="' + $(this).attr('data-tooltip-id') + '"]');
		$tooltip.text(getTooltipString(this));
		$tooltip.hide();
	}).on("input change", function(){
		$('.tooltip[data-tooltip-div="' + $(this).attr('data-tooltip-id') + '"]').text(getTooltipString(this));
	});
});


//DATA-VALIDATION
$('[data-match]').each(function(){
	match = $(this).attr("data-validation");
});

//DATA-INIT
$('[data-init]').each(function(){
	callback = $(this).attr('data-init')
	if (typeof window[callback] === "function") {
		window[callback](this)
	}
});

//CLASS ADD
if ($(".field_with_errors").elements.length) {
	$(".radio-container").addClass("errors_container")
}

//MODAL
$(".modal-continue-button").on("click", function(){
	$(".modal-continue").addClass("open-modal")
	$(".cover-back").addClass("cover")
});
$(".modal-cancel").on("click", function(){
	$(".modal-continue").removeClass("open-modal")
	$(".cover-back").removeClass("cover")
});

