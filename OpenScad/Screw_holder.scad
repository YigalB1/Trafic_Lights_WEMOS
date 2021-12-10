//$fn=60;
// the cylinder that holds the screw
//size 2: for M2 screw holder
//size 3: for M3 screw holder

//translate ([0,0,0]) color("red") pin();
//pin_negative(size=2);

module pin_negative(size=2,hole_h=9.2) {
    // negative of pin so it could be removed to create a hole
    if (size==2) {    
        hole_d = 3.2;
        //hole_h = 3.8+0.4+5;
        color("blue") cylinder(d=hole_d,h=hole_h,$fn=60);;
   } // 2mm  
   else if(size==3) {
        hole_d = 4.5;
        //hole_h = 5.6+0.4;
        color("cyan") cylinder(d=hole_d,h=hole_h,$fn=60);;
   } // 3mm
    
} // of pin_negative()


module pin() {
        //cylinder(d=base_d,h=base_h);
        //cylinder(d=pin_d,h=pin_h);
        threads_holes(size=2);
} // of pin() module
    
    
module threads_holes(size=2) {
    
   if (size==2) {
    wide_d = 5;
    hole_d = 3.2;
    hole_h = 3.8+0.4;
    color("blue") thread(wide_d,hole_d,hole_h);
   } // 2mm  
   else if(size==3) {
    wide_d = 7;
    hole_d = 4.5;
    hole_h = 5.6+0.4;
    color("cyan") thread(wide_d,hole_d,hole_h);
   } // 3mm
    
} // of threads_holes()


module thread(wide_d = 5,hole_d = 2,hole_h = 5) {
    base_d = 7;
    base_h = 7;      
 
      difference() {
        cylinder(d=base_d,h=base_h);
        translate([0,0,base_h-hole_h])color("red") cylinder(d=hole_d,h=hole_h);
      } // of difference
 
} // create the thread hole