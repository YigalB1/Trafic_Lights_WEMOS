



translate([0,-30,20]) trafic_leds(); // the body of the leds

box_base(0);

module box_base(select) { // 0 for box, 1 for cover
    base_x = 40;
    base_y = 33;
    base_h=30;
    plastic_h = 1.5;
    door_x = 10;
    door_y=10;
    door_h=10;

    if (select==0) {            
        difference() {
            cube(size = [base_x,base_y, base_h], center = true);
            color("red") translate([0,0,plastic_h])  cube(size = [base_x-2*plastic_h,base_y-2*plastic_h, base_h-plastic_h], center = true);
            color("cyan") translate([10,0,door_h/2])  cube(size = [3*door_x,door_y, door_h], center = true); // the hole (aka door)
        } // of difference

    }
    else {
    }
    
    
} // of box_base() module


module trafic_leds() {
    pcb_height = 1.5;
    p1_x = 35;
    p1_y = 13.1;
    p2_x = 11.6;
    p2_y = 4.7;
    p3_x = 8.6;
    p3_y = 21.0;
    led1_dist = 2;
    screw_d = 3.8;
    hole_dist_l=1.1;
    hole_dist_left = 0.3;
    hole_dist_right = 1.3;
    
    //LED Dimensions 
    led_d = 7.9; //LED Diameter
    led_h=11.3; //LED Height
    led_fh=2.2; //LED FLange Thickness
    led_fd=9.2; //LED Flange Diameter
    wire_d=.5; //Wire Diameter
    wire_h=10; //Wire Height
    wire_da=2; // THe distance between the Wires

    
    difference() {
        body();
        holes();
    }
    pins();
    
    module pins(){
        color("black") translate([p1_x+p2_x+p3_x/2+2.5,p1_y/2,pcb_height]) cube(size = [2.3,10.4 , 4-pcb_height], center = true);
        // color("gray") translate([]) cylinder(d=0.6,h=7.5)  TBD - pins
    }
    
    
    
    
    module body() {
          cube(size = [p1_x,p1_y , pcb_height], center = false);
    translate([p1_x,(p1_y-p2_y)/2,0]) cube(size = [p2_x, p2_y, pcb_height], center = false);
    translate([p1_x+p2_x,(p1_y-p3_y)/2,0]) cube(size = [p3_x, p3_y, pcb_height], center = false);
    // the leds
    led1_x = led1_dist+led_fd/2;
    led2_x = led1_x + led1_dist+led_fd;
    led3_x = led2_x + led1_dist+led_fd;
    color("red") translate([led1_x,p1_y/2,0]) led();
    color("yellow") translate([led2_x,p1_y/2,0]) led();
    color("green") translate([led3_x,p1_y/2,0]) led();
    }
    
    
    
    module holes() { 
        hole1_x = p1_x+p2_x+hole_dist_l+screw_d;
        hole1_y = p1_y/2+p3_y/2-hole_dist_left - screw_d/2;
        translate([hole1_x,hole1_y,0]) cylinder(d=screw_d, h = 10,center=true,$fn=40);
        hole2_x = p1_x+p2_x+hole_dist_l+screw_d;
        hole2_y = p1_y/2-p3_y/2+hole_dist_right + screw_d/2;
        translate([hole2_x,hole2_y,0]) cylinder(d=screw_d, h = 10,center=true,$fn=40);
    }
    
    
    module led(){
        translate([0,0,led_fh])cylinder(led_h-(led_d/2)-led_fh,led_d/2,led_d/2, $fn=25);
        translate([0,0,led_h-(led_d/2)])sphere(led_d/2,  $fn=25);
        cylinder(led_fh,led_fd/2,led_fd/2, $fn=25);
        translate([0,wire_da/2,-wire_h])cylinder(wire_h,wire_d/2,wire_d/2, $fn=25);
        translate([0,wire_da/-2,-wire_h])cylinder(wire_h,wire_d/2,wire_d/2, $fn=25);
        }
   }// of module trafic_leds()




// cube(size = [1, 1, 1], center = false);









