// 
wemos_d1_pcb_width = 26;
wemos_d1_pcb_length = 35;
wemos_d1_pcb_thickness = 2;
wemos_d1_thin_wall = 1.2;
wemos_d1_clip = 1; // radius of the wemos_d1_clip that sticks out at the top of a pillar.
wemos_d1_tab_width = 4;

// added Yigal
spare_x = 15;
spare_y = 15;
plastic_h = 1.5;
base_x = wemos_d1_pcb_length + 2*wemos_d1_thin_wall + spare_x;
base_y = wemos_d1_pcb_width  + 2*wemos_d1_thin_wall + spare_y+10;
base_h = 39; // was 35 TBD 38
inner_x = base_x-2*plastic_h;
inner_y = base_y-2*plastic_h;
inner_h = base_h-1*plastic_h;
switch_box_x = 20;
switch_box_y = 25;
switch_madrega = 3;
switch_box_h = base_h-switch_madrega; // was 25
switch_d = 6.7;
door_x= 15;
door_y=10;
door_h=8;;
holes_x = 5;
holes_h = 10;
holes_d = 2;
cover_hole_x = 17;
cover_hole_y = 17;


// ************************************** main Code Start 

// base_box: 
//trafic_lights_main(1); // Base box. 0 for the box, 1 for the cover

//switch_box(0); // the extention for the push button

//trafic_electronic();
//translate([-20,6,20]) rotate([180,0,0]) trafic_leds(0); // 0 for leds module, 1 for box
rotate([180,0,0]) trafic_leds(1); // 0 for leds module, 1 for box
// ************************************** main Code end 


// ************************************** Modules Start 


module trafic_leds(select) { // 0 for the leds module, 1 for the box, 2 for the cylinders of holes of the module 
    pcb_height = 1.5;
    p1_x = 35;
    p1_y = 13.1;
    p2_x = 11.6;
    p2_y = 4.7;
    p3_x = 8.3;
    p3_y = 21.0;
    led1_dist = 2;
    screw_d = 4.3; // 3.8;
    hole_dist_l=1.1;
    hole_dist_left = 0.3;
    hole_dist_right = 1.3;
    
    spare = 2;
    
    //LED Dimensions 
    led_d = 8.3; //LED Diameter
    led_h=11.3; //LED Height
    led_fh=2.2; //LED FLange Thickness
    led_fd=9.2; //LED Flange Diameter
    wire_d=.5; //Wire Diameter
    wire_h=10; //Wire Height
    wire_da=2; // THe distance between the Wires
    
    pins_x = 2.3;
    pins_y = 10.4;
    
    top_box_x_int = p1_x + p2_x + p3_x + spare;
    top_box_y_int = p3_y + spare;
    top_box_h_int = 13; // TBD
    top_box_x_ext = top_box_x_int+2*plastic_h;
    top_box_y_ext = top_box_y_int+2*plastic_h;
    top_box_h_ext = 13+plastic_h;
        
    
    pole_h = top_box_x_ext ; 
    pole_d = 10 ; 
    pole_base_x = 25;
    pole_base_y = 20;
    
    
    
    if (select==0) {
        difference() {
        body();
        pcb_holes(0); // 0 for the holes (for the difference), 1 for the actual pins (lil smaller)        
        } // of difference()
        pins();
    } // of if 
    
    if (select==1) {
        // generate the pole & the holder of the led module
        leds_module_holder();
    }
    
    if (select==2) {
        pcb_holes(1); // 0 for the holes (for the difference), 1 for the actual pins (lil smaller)
    }
           
    
    
    module leds_module_holder() {
        // generate the pole & the holder of the led module
        difference() {
            color("blue") 
                cube(size = [top_box_x_ext,top_box_y_ext , top_box_h_ext], center = true);
            translate([0,0,-plastic_h]) color("red" )
                cube(size = [top_box_x_int,top_box_y_int , top_box_h_int], center = true);
            rotate([0,90,0]) translate([0,0,20]) color("green" ) 
                cylinder(d=pole_d, h = pole_h, center = true);
            translate([-p1_x+7,-p1_y/2,3]) trafic_leds(0);
        } // of difference()
       
        
        translate([-p1_x+7,-p1_y/2,2]) trafic_leds(2);
        
        rotate([0,90,0]) translate([0,0,pole_h]) pole(0);
        
        //rotate([0,90,0]) translate([0,0,pole_h]) pole(1);
        
    } // of leds_module_holder() module

    module pole(select) {
        // 0 for the holes (production) , 1 for the pins for the holes on the other side
        
        $fn=30;
        base_hole_x=3;
        base_hole_y=3;
        base_hole_z=3;
        
        pole_2nd_shift = 2;
        
        if (select==0) {
            pole_body();
        }
        else {
            pole_holes();
        }
        
        
        
        
        
        module pole_body() {

// pole_holes();            
            difference() {
                union(){
                // the pole itself
                color("green" ) cylinder(d=pole_d, h = pole_h, center = true);               
                // base for the pole, to make it touch the ground (easy to print)
                translate([-top_box_h_ext/2+pole_d/2,0,0]) color("yellow")
                    cube(size = [pole_d,pole_d/2, pole_h], center = true);  
                // base of the pole, to be connected to the base box cover
                // removed because moved to one base+pole print
                //translate([-top_box_h_ext/2+pole_base_x/2,0,pole_h/2-plastic_h]) color("red")
                 //   cube(size = [pole_base_x,pole_base_y , plastic_h], center = true);
                    
                // trying to make the base of the pole same as the the base box cover
                    // was 30
                     // x_play = -top_box_h_ext/2-pole_d + base_x/2;
                    // x_play = 0;
                    x_play = -top_box_h_ext/2+pole_d/2+base_x/2-5; 
                    // the 5 is a manual fix because the formula is not perfect
                 translate([x_play,0,pole_h/2-plastic_h]) trafic_lights_main(1); // Base box. 0 for the box, 1 for the cover
                    
                
            } // of union           
            
            // the hole in the pole
            color("red") color("green" )
                cylinder(d=pole_d-plastic_h, h = pole_h, center = true);
    
         // pole_holes(); removed because moved to one print of pole + base 
            
     
        } // of difference
        
 
        }
        
 
    
         module pole_holes() {
                   // create holes in the pole's base
            translate([-pole_d/2,2*pole_d/3,pole_h/2-plastic_h+base_hole_z]) color("green" )
                cylinder(d=2, h = 15, center = true);
            translate([-pole_d/2,-2*pole_d/3,pole_h/2-plastic_h+base_hole_z]) color("green" )
                cylinder(d=2, h = 15, center = true);
            translate([-pole_d/2+pole_base_y,2*pole_d/3,pole_h/2-plastic_h+base_hole_z]) color("green" )
                cylinder(d=2, h = 15, center = true);
            translate([-pole_d/2+pole_base_y,-2*pole_d/3,pole_h/2-plastic_h+base_hole_z]) color("green" )
                cylinder(d=2, h = 15, center = true);
         }
         
        


    } // of pole() module
    
    
    module pins(){ // the electrical pins connector
        color("black") translate([p1_x+p2_x+p3_x/2+2.5,p1_y/2,pcb_height]) cube(size = [pins_x,pins_y, 4-pcb_height], center = true);
        // color("gray") translate([]) cylinder(d=0.6,h=7.5)  TBD - pins
    } // of module pins()
  
       
    
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
    } // of module body()
    
    
    
    module pcb_holes(select) { 
        // 0 for the holes (for the difference), 1 for the actual pins (lil smaller)
        
        echo (select);
        diameter = select==0 ?  screw_d : screw_d-1;
        
        
        if (select==0) {
           
        }
        else {
           
        }
        
        
        fix = 1; // fix on x axis to allow insertion. TBD fix the real model
        
        hole1_x = p1_x+p2_x+hole_dist_l+diameter-fix;
        hole1_y = p1_y/2+p3_y/2-hole_dist_left - diameter/2;
        translate([hole1_x,hole1_y,0]) cylinder(d=diameter, h = 10,center=true,$fn=40);
        hole2_x = p1_x+p2_x+hole_dist_l+diameter-fix;
        hole2_y = p1_y/2-p3_y/2+hole_dist_right + diameter/2;
        translate([hole2_x,hole2_y,0]) cylinder(d=diameter, h = 10,center=true,$fn=40);
        

    } // of module holes()
    
    
    module led(){
        translate([0,0,led_fh])cylinder(led_h-(led_d/2)-led_fh,led_d/2,led_d/2, $fn=25);
        translate([0,0,led_h-(led_d/2)])sphere(led_d/2,  $fn=25);
        cylinder(led_fh,led_fd/2,led_fd/2, $fn=25);
        translate([0,wire_da/2,-wire_h])cylinder(wire_h,wire_d/2,wire_d/2, $fn=25);
        translate([0,wire_da/-2,-wire_h])cylinder(wire_h,wire_d/2,wire_d/2, $fn=25);
        } //of module led()
   }// of module trafic_leds()











// the model of the trafic led's module
//rotate([0,0,90]) translate([0,0,-base_h/2+plastic_h]) trafic_electronic(); // for the cover's hole design only


module trafic_lights_main(select){
    // the main base box
    if (select==0) { // box
        trafic_light_box();
        rotate([0,0,-90]) translate([-20,-12,-11]) wemos_d1_mini_demo(); // align(center=true); the wemos holder
    }
    else { // cover
        translate([0,0,0]) cover();
        }    
} // of trafic_lights_main(0 module

module trafic_electronic() {
    translate([0,0,0]) wemos_d1_mini(); // bottom level (WEMOS)
    translate([0,0,9]) wemos_d1_mini(); // 1st floor (holding leds and switch)
    rotate([180,90,-90]) translate([-66,-6,0]) trafic_leds();
    
} // of trafic_electronic()

module wemos_d1_mini() {
    color("cyan") translate([0,0,0])  cube(size = [wemos_d1_pcb_length,wemos_d1_pcb_width, wemos_d1_pcb_thickness], center = true);
} // of wemos_d1_mini() model


module cover() {
    
    difference() {
        color("red") translate([0,0,0])  cube(size = [base_x,base_y, plastic_h], center = true);
        translate([0,0,-15]) holes(1);
    //color("blue") translate([-4,0,0])  cube(size = [cover_hole_x,cover_hole_x, 10], center = true); // removed because moved to one print of pole + cover
    } // of differenve()   
    rotate([180,0,-90]) translate([-15,-17,0]) linear_extrude(1.5) text("BZ games",5);    
} // of cover() module




module trafic_light_box() {
    //translate([0,0,5]) wemos_d1_mini_demo();
    difference() {
        color("red") translate([0,0,0])  cube(size = [base_x,base_y, base_h], center = true);
        color("green") translate([0,0,plastic_h])  cube(size = [inner_x,inner_y, inner_h], center = true);
        
        color("blue") rotate([0,0,90]) translate([0,-10,plastic_h])
    switch_box(1);
        //switch_box(1);
        color("black") translate([0,-base_y/2,-base_h/2+door_y/2+plastic_h])  cube(size = [door_x,door_y, door_h], center = true);
    } // of difference()     
    
    
    
    
            //translate([0,base_y/2+switch_box_y/2-plastic_h,height_delta]) 
        rotate([0,0,90]) translate([0,base_y/2+switch_box_y/2-plastic_h,0])
    
    switch_box(0); // the small box for the switch
    holes(0); // create holes on 4 sides for acrews           
} // of trafic_light_box() module

module holes(select) { // 0 for the holes, 1 for the cyinder (for the difference)
    x_dist = base_x/2-plastic_h-holes_x/2;
    y_dist = base_y/2-plastic_h-holes_x/2;
    color("yellow") translate([x_dist,y_dist,0])  single_hole(select);
    color("yellow") translate([x_dist,-y_dist,0])  single_hole(select);
    color("yellow") translate([-x_dist,y_dist,0])  single_hole(select);
    color("yellow") translate([-x_dist,-y_dist,0])  single_hole(select);   
}
module single_hole(select) {
    hole_holder_l = base_h-plastic_h;
    if (select==0) {
        difference() {
            color("yellow") translate([0,0,0])  cube(size = [holes_x,holes_x, hole_holder_l], center = true);
            color("red") translate([0,0,hole_holder_l/2])  cylinder(d=holes_d, h=holes_h, center = true);
        } // of difference()       
    } // of if
    else{
        color("red") translate([0,0,hole_holder_l/2])  cylinder(d=holes_d, h=holes_h, center = true);           
    } // of else
} // of single_hole() module


module switch_box(select) { // 0 for the switch box itself, 1 for the difference opening
    height_delta = -base_h/2 + switch_box_h/2;
    if (select==0) {
        //translate([0,base_y/2+switch_box_y/2-plastic_h,height_delta]) 
        translate([0,0,0]) 
        difference() {
            color("red") translate([0,0,0])  cube(size = [switch_box_x,switch_box_y, switch_box_h], center = true);
            
                    
        // the x & h dimensions are smaller by 2*plastic_h
        // the y is same, to make the hole on the internal side
        translate([0,0,0]) 
        color("gray") translate([0,-plastic_h,0]) cube(size = [switch_box_x-2*plastic_h,switch_box_y, switch_box_h-2*plastic_h], center = true);
                //color("gray") translate([0,-plastic_h*2,0]) cube(size = [switch_box_x-2*plastic_h,switch_box_y-plastic_h/2, switch_box_h-plastic_h], center = true);
        // 5 mm is for safety
            color("blue") translate([0,switch_box_y/2-plastic_h-5,switch_box_h/2]) cylinder(d=switch_d, h = 10, center=true);
            
    
        } // of difference()

        
        
        
        
        
    } // of if
    else {
    
    translate([0,base_y/2+switch_box_y/2-plastic_h,height_delta]) 
            color("red") translate([0,0,0])  cube(size = [switch_box_x,switch_box_y, switch_box_h], center = true);                             
    } // of else    
} // of switch_box() module



module wemos_d1_mini_demo()
{
    offset = 5;

    wemos_d1_mini_clip( offset);
    
    // bottom to hold it all together
    
    translate([-wemos_d1_thin_wall, -wemos_d1_thin_wall,-offset]) cube([ wemos_d1_pcb_length, wemos_d1_pcb_width, 1] + 2*[wemos_d1_thin_wall, wemos_d1_thin_wall,0]);
} // of wemos_d1_mini_demo() module

module wemos_d1_mini_clip( offset = 5)
{
    // frame corners on the NW, NE side
    frame_corner( offset);
    translate([0, wemos_d1_pcb_width, 0]) mirror([0,1,0]) frame_corner(offset);
    
    //two tabs supporting the SE side
    translate([wemos_d1_pcb_length, wemos_d1_pcb_width, 0]) pillar(offset);
    
    // *****
    //;translate([wemos_d1_pcb_length-wemos_d1_tab_width - 2*wemos_d1_clip, wemos_d1_pcb_width, 0]) rotate([0,0,90]) pillar(offset);
    translate([wemos_d1_pcb_length-wemos_d1_tab_width - 2*wemos_d1_clip, 0, 0]) rotate([0,0,-90]) pillar(offset);
    
    
    // one pillar supporting the SW side (keep the west open for the reset button)
    translate([wemos_d1_pcb_length, wemos_d1_tab_width, 0]) pillar(offset);
    
    // two extra tabs holding the sides in the E and W position
    // >>>>>>>>>>
    translate([wemos_d1_pcb_length + wemos_d1_tab_width, 0, 0] * .5) rotate([0,0,-90]) pillar( offset, false);
    
    
    translate([(wemos_d1_pcb_length - wemos_d1_tab_width)/2, wemos_d1_pcb_width, 0] )rotate([0,0,90]) pillar( offset, false);
}


/**
* essentially a cube with one of the edges cut off.
*/


module edged_box()
{
    rib = 4;
    sag = .4;
    dims = [rib,rib,wemos_d1_pcb_thickness+sag];
    edge_off = 2;
    d = .001;
    d3 = [d,d,d];
    // somewhat convoluted, but it works
    mirror([0,1,0]) translate( [0, -rib, 0])
    difference()
    {
        cube( dims);
        translate([0,rib-edge_off,-d]) 
            rotate([0,0,45]) cube(dims + 2*d3);
    }
}

/**
* Pillar that holds the NE,NW corners of the PCB (the dull-edged corners)
*/
module frame_corner( height)
{
    wemos_d1_thin_wall = 1.2;
    wemos_d1_clip = 1;
    d3 = [.001, .001, .001];
    edge = wemos_d1_pcb_thickness + 2*wemos_d1_clip;
    pillar_dims = [4,4,height + edge] + [wemos_d1_thin_wall, wemos_d1_thin_wall, 0] - d3;

    difference()
    {
        translate([-wemos_d1_thin_wall,-wemos_d1_thin_wall,-height]) cube (pillar_dims);
        edged_box();
    }
}
/**
* A pillar that keeps the edge of the PCB in place. If doClip is true, 
* there will be a little tab at the top of the pillar to push the PCB down.
*/
module pillar( height, doClip=true)
{
    d = .001;
    edge = wemos_d1_pcb_thickness + 2*wemos_d1_clip;
    tab_dims = [wemos_d1_thin_wall, 4, height + edge];
    if (doClip)
    {
        translate([0,-wemos_d1_tab_width/2,edge - wemos_d1_clip]) rotate([90,0,0]) cylinder(h = wemos_d1_tab_width, r = wemos_d1_clip, center=true, $fn = 50);
    }
    translate([0,-wemos_d1_tab_width,-height]) cube( tab_dims);
    translate([-wemos_d1_thin_wall+d, -wemos_d1_tab_width, -height]) cube([wemos_d1_thin_wall, wemos_d1_tab_width, height]);
}

/** 
* clip to hold a wemos d1 mini
* This module can be used in enclosures. It generates clips that can
* hold a Wemos D1 Mini in place
**/



// *********************************************************



