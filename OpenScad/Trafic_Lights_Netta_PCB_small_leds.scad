use <yig_box_Diagonal_1.scad>
use <netta_games_pcb.scad>

box_l = 60;
box_w = 70;
front_h = 40;
back_h  = 40;

l_holder_x = 35;
l_holder_y = 60;
l_holder_h = 25;


//trafic_box();
//translate([0,0,0]) trafic_cover();
translate([0,0,0]) lights_holder(side="front",dummy_pins="false");
//translate([0,0,0]) lights_holder(side="back");

//lights_pcb();




module lights_holder(side="front",dummy_pins="false") {
    // when dummy_pins=true, the cylinders used to create
    // the holes will be added, to allow same holes in the
    // cover of the box
    
    
    lights_l = 18.3;
    lights_w = 4.8;
    
    holes_t_vec=[l_holder_x/2,-2,11];
    holes_r_vec=[90,0,0];
    
    if(side=="front") {
        difference() {
            print_box(length=l_holder_x,wide=l_holder_y,
                front_height=l_holder_h,back_height=l_holder_h);
            translate([l_holder_x/2-4,15,5]) rotate([180,0,90]) lights_pcb();
            translate(holes_t_vec) rotate(holes_r_vec)
                wires_holes();
            
        } // of difference()
        if(dummy_pins=="true"){
            translate(holes_t_vec) rotate(holes_r_vec)
                wires_holes();
        } // of if()
        
        
    } // of if()
    else { // side is back
        print_cover(length=l_holder_x,wide=l_holder_y,front_height=l_holder_h,
            back_height=l_holder_h);
        
    } // of else()
       
    
    module wires_holes() {        
        cube_x=20;
        d_2mm=2.2;
        x=(cube_x/2)-d_2mm-1;
        l = 20;
        
        
        cube([cube_x,cube_x,1],center=true);
        cylinder(d=12,h=l,center=true,$fn=60);
        translate([ x, x,0]) color("red")
            cylinder(d=d_2mm,h=l,center=true,$fn=60);
        translate([ x,-x,0]) color("red")
            cylinder(d=d_2mm,h=l,center=true,$fn=60);
        translate([-x, x,0]) color("red")
            cylinder(d=d_2mm,h=l,center=true,$fn=60);
        translate([-x,-x,0]) color("red")
            cylinder(d=d_2mm,h=l,center=true,$fn=60);
    } // of wires_holes()
    
} // of lights_holder()




module trafic_cover() {
    difference() {
        print_cover(length=box_l,wide=box_w,front_height=front_h,back_height=back_h);
        translate([0,box_w/2-l_holder_x/2,5]) rotate([90,0,90])
            lights_holder(side="front",dummy_pins="true");
        translate([box_l-10,box_w/2,0]) rotate([0,0,90])
            cylinder(d=6.9,h=20,$fn=60,center=true); // for the push button
    } // of difference()
    
} // of trafic_cover()

module trafic_box() {

    pcb_vec = [25,35,0];
    usb_vec = pcb_vec+[0,0,-2];
    
    difference(){
        box_with_pcb();
        translate(usb_vec) 
            netta_games_pcb(dummy_pins="usb_hole");  // create hole for USB
    } // of difference()
    
    module box_with_pcb() {
        print_box(length=box_l,wide=box_w,front_height=front_h,back_height=back_h);
        translate(pcb_vec) 
            netta_games_pcb(dummy_pins="false");

        
    } // of module_with_pcb()
} // of trafic_box()



module lights_pcb(dummy_pins="false") {
    pin_x1_shift=1.5;
    pin_y1_shift=1.5;
    pin_x2_shift=39;
    pin_y2_shift=12;
    led1_x = 19.5;
    led1_y = 4.7;
    led2_x = 26.2;
    led2_y = 4.7;
    led3_x = 32.7;
    led3_y = 4.7;
    
    linear_extrude(height = 2) import("PCB_TraficLights_2.dxf");
    translate([pin_x1_shift,pin_y1_shift,-10]) pin();
    translate([pin_x2_shift,pin_y1_shift,-10]) pin();
    translate([pin_x1_shift,pin_y2_shift,-10]) pin();
    translate([pin_x2_shift,pin_y2_shift,-10]) pin();
    
    translate([led1_x,led1_y,0]) led5mm();
    translate([led2_x,led2_y,0]) led5mm();
    translate([led3_x,led3_y,0]) led5mm();
    
    module led5mm() {
        d_led = 5+0.5;
        color("green") cylinder(d=d_led,h=8,$fn=60);
    } // of led_5mm()
    module pin() {
        d_hole = 2;
        color("red") cylinder(d=d_hole,h=20,$fn=60);
    } // of pin() module
} // of lights_pcb()

