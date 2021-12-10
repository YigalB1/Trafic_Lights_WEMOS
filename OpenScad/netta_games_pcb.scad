netta_games_pcb(dummy_pins="false");

module netta_games_pcb(dummy_pins="false") {
    pcb_x = 43.5;
    pcb_y = 40.0;
    pcb_h = 1.6;
    pins_h_offset = -1;
    m2_insert_d=3.3;
    
    
    x_shift = pcb_x/2 - 17;
    y_shift = pcb_y/2 - 2.79;
    y_dist = 34;
    
    
    pins_h = 22; // to allow space for the wemos from the box floor
    pins_holder_d = 6;
        
      
    
    
    
    if (dummy_pins=="false") {
        color("green") cube([pcb_x,pcb_y,pcb_h],center=true);
        // the cube that holds the pins, for better layout
        // print the actual pins that will hold the PCB on it
        // wider cylinders to hold the m2 insert
        color("red")    translate([x_shift,y_shift,pins_h_offset])
            m2_holder();
            
        color("yellow") translate([x_shift,y_shift-y_dist,pins_h_offset])
            m2_holder();                   
    } // of if()
    
    if (dummy_pins=="true") {
        color("green") cube([pcb_x,pcb_y,pcb_h],center=true);
    // the cube that holds the pins, for better layout
        // print the pins that will be used to create holes for screws
        color("red")    translate([x_shift,y_shift,pins_h_offset])
            
            cylinder(d=m2_insert_d,h=pins_h,$fn=60);
        color("yellow") translate([x_shift,y_shift-y_dist,pins_h_offset])
            cylinder(d=m2_insert_d,h=pins_h,$fn=60);
        // set box for hole for USB
        rotate([0,0,-90])translate([0,-25,12]) cube([20,40,12],center=true);
        
    } // of if()   
    
    if (dummy_pins=="usb_hole") {
        rotate([0,0,-90])translate([0,-25,8]) cube([20,40,10],center=true);
    } // of if()
    
    
    
    
    module m2_holder() {
        difference(){
            cylinder(d=pins_holder_d,h=pins_h,$fn=60);
            translate([0,0,5]) cylinder(d=m2_insert_d,h=pins_h,$fn=60);
        } // of difference()
        

    } // of m2_holder()
} // of netta_games_pcb()

