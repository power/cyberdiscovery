
                  // Remind users of the number of degrees to use to unlock
                  console.log("Set new degrees to unlock all circles between -81 and -4");
                  // Identify our 3 circles
                  var aa = ["one", "two", "three"];
                  // Function to turn specified circle by number of degrees
                  var turnCircle = function(num, deg) {
                    // Set rotation of the circle specified in num param
                    setTimeout(function() {
                      var ring = get('ring_'+num);
                      if (ring === null) return;
                      ring.style.transform = 'rotate('+deg+'deg)';
                    },0);
                    // For each of the circles
                    for (var i=0 ; i<circles.length; i++) {
                      // If not paused yet, slow circle down to a stop
                      if (get('ring_'+circles[i]).style.animationPlayState !== "paused") {
                        get('ring_'+circles[i]).style.animation = 'none';
                        get('ring_'+circles[i]).style.animationPlayState = 'paused';
                        get('ring_'+circles[i]).style.animationDuration = '0';
                        // Set other couple of circles rotation as well as one specified in num param
                        if (num !== circles[i]) {
                          setTimeout(function(x) {
                            get('ring_'+circles[x]).style.transition = 'all 0.5s ease-in-out';
                            get('ring_'+circles[x]).style.transform = 'rotate('+((x+1)*50)+'deg)';
                          },0,i);
                        }
                      }
                    }
                  }
                
