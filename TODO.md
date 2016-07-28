### Plans
* Start thinking about servos ==> understand how hardware PWM works
* Add compatibility for 2 B


Idea: some sort of system to dynamically load programs that can then use useful
routines like gpio_output, st_sleep, etc.
How to access functions: store addresses of functions (labels) at a predefined
location which is then accessed by other programs.

### Notes:
 - PWM pins: GPIO12, GPIO13
