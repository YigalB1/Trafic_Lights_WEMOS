cyl_d = 12;
cyl_h = 20;
cyl_w = 1.5;


cube_w = cyl_w*2.0;

rotate([0,0,90]) lights_tube();

module lights_tube() {
    difference() {
        cylinder(d=cyl_d,h=cyl_h,center=true,$fn=60);
        cylinder(d=cyl_d-2*cyl_w,h=cyl_h+1,center=true,$fn=60);
    }// of difference;
    translate([-cyl_d/2+cyl_w*1,0,0]) rotate([0,90,0])
        cube([cyl_h,cyl_d/2,cube_w],center=true);
} // of lights_tube()

