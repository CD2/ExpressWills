function isElement(obj) {
  try {
    return obj instanceof HTMLElement;
  }
  catch(e){
    return (typeof obj==="object") &&  (obj.nodeType===1) && (typeof obj.style === "object") && (typeof obj.ownerDocument ==="object");
  }
}
function isStringElement(str) {
	isString = typeof(str) === "string"
	minLength = str.length>=3
	htmlSurround = str.charAt(0) === "<" && str.charAt(str.length-1) === ">"
	return (isString && minLength && htmlSurround)
}

function $(selector) {
	if (isElement(selector)) {
		elems = [selector]
	} else if(isStringElement(selector)) {
		selectorWrapper = document.createElement("div")
		selectorWrapper.innerHTML = selector;
		elems = selectorWrapper.children
	} else {
		selector = selector.replace(/\[([^\[\]]*?(\[[^\]]*\])?[^\[\]]*?)\]/g, function(match, contents, offset, s){
			return '[' + contents.replace(/([\[\]])/g, '\\$1') + ']';
		});
		elems = document.querySelectorAll(selector);
	}

	return {
		//used to identify these objects
		$:true,

		//Stores the HTML entitys
		elements:elems, 

		//loops through entitys exectuing callback eachtime
		each:function(callback){
			if (!callback) {return this;}
			for (var i=0; i<this.elements.length; i++) {
				callback.call(this.elements[i], i);
			}
			return this;
		},
		//returns parent items
		parent:function(){
			return $(this.elements[0].parentElement)
		},
		//gets or sets entitys attributes
		attr:function(name, value) {
			if (value) {
				if (name === "class") {
					return this.addClass(value)
				} else {
					this.each(function(){
						this.setAttribute(name, value)
					});
					return this;
				}
			} else {
				return this.elements[0].getAttribute(name);
			}
		},

		//returns a $ object of the entity at position i
		eq:function(i) {
			return $(this.elements[i]);
		},

		//checks if matches selector
		is:function(cond) {
			match = false
			this.each(function(){
				target = this;
				tagName = target.tagName
				tagId = (target.id)? '#' + target.id : '';
				tagClass = (target.className)? '.' + target.className.split(' ').join('.') : '';

				matches = $(tagName+tagId+tagClass+cond)
	
				matches.each(function(){
					if (this === target) {
						match = true;
						return;
					}
				});
			});
			return match;
		},

		//return if any entity has given class
		hasClass:function(classes){
			var found = false;
			this.each(function(){
				if (this.className.indexOf(classes)>-1) {
					found = true;
				}
			});
			return found;
		},

		//adds class to all entitys unless class is present
		addClass:function(classes) {
			if (!classes) return this;
			classes = classes.split(" ");
			this.each(function(){
				for (var i=0; i<classes.length; i++) {
					 this.classList.add(classes[i])
				};
			});
			return this;
		},

		//removes class from all entitys unless not present
		removeClass:function(classes) {
			if (!classes) return this;
			classes = classes.split(" ");
			this.each(function(){
				for (var i=0; i<classes.length; i++) {
					 this.classList.remove(classes[i])
				};
			});
			return this;
		},

		//toggles class on all entitys
		toggleClass:function(classes) {
			if (!classes) return this;
			classes = classes.split(" ");
			this.each(function(){
				for (var i=0; i<classes.length; i++) {
					 this.classList.toggle(classes[i])
				};
			});
			return this;
		},

		//append element as entity
		append:function(entity) {
			if (!entity.$) {
				str = entity;
				entity = $(entity);
			}
			if (entity.elements.length === 0) {
				this.each(function(){
					this.innerText+=str;
				});
			} else {
				this.each(function(){
					element = this;
					entity.each(function(i){
						element.insertBefore(this);
					});
				});
			}
			return this;
		},

		//inserts as next sibling
		insertAfter:function(entity) {
			if (!entity.$) {
				str = entity;
				entity = $(entity);
			}
			if (entity.elements.length > 0) {
				this.each(function(){
					element = this;
					entity.each(function(i){
						element.parentElement.insertBefore(this, element.nextSibling)
					});
				});
			}
			return this;
		},

		//prepend an element to an entity
		prepend:function(entity) {
			if (!entity.$) {
				str = entity;
				entity = $(entity);
			}
			if (entity.elements.length === 0) {
				this.each(function(){
					this.innerText =str + this.innerText;
				});
			} else {
				this.each(function(){
					element = this;
					entity.each(function(i){
						element.insertBefore(this, element.firstChild)
					});
				});
			}
			return this;
		},

		//inserts as previous sibling
		insertBefore:function(entity) {
			if (!entity.$) {
				str = entity;
				entity = $(entity);
			}
			if (entity.elements.length > 0) {
				this.each(function(){
					element = this;
					entity.each(function(i){
						element.parentElement.insertBefore(this, element)
					});
				});
			}
			return this;
		},

		wrap:function(entity) {
			if (!entity.$) {
				entity = document.createElement(entity);
			} else {
				entity = entity.elements[0];
			}
			this.each(function(){
				$(this).insertBefore(entity.cloneNode())
				$(this.previousSibling).append(this)
			});
		},

		//gets or sets text
		text:function(str) {
			if (!str) {
				return this.elements[0].innerText || this.elements[0].value
			} else {
				this.each(function(){
					try{
						this.innerText = str.toString();
					} catch(e){
						this.value = str.toString();
					}
				});
			}
			return this;
		},

		on:function(events, callback) {
			events = events.split(" ")
			this.each(function(){
				for (index in events) {
					this.addEventListener(events[index], callback);
				}
			});
			return this;
		},

		hide:function() {
			this.each(function(){
				if (this.style.display!=="none") {
					$(this)._storeOriginalStyle(this, "display");
					this.style.display = "none";
				}
			});
			return this;
		},

		show:function() {
			this.each(function(){
				this.style.display=$(this)._getOriginalStyle(this, "display", "block");
			});
			return this;
		},

		_storeOriginalStyle: function(element, style) {
			if (!element.originalStyle) {
				element.originalStyle = {};
			}
			element.originalStyle[style] = element.style[style];
		},

		_getOriginalStyle: function(element, style, defaultReturn) {
			if (!element.originalStyle || element.originalStyle[style]===null) {
				return defaultReturn || "";
			}
			return element.originalStyle[style];
		},
	}
}