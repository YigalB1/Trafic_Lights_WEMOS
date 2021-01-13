// Copyright (C) Danny Havenith 2020
// This design is licensed under the Creative Commons - Attribution license
// See https://creativecommons.org/licenses/by/4.0/
//
// usage: in your project file add:
//    use <wemos_d1_mini_clip.scad>
// Then call:
//    wemos_d1_mini_clip( some_offset);
// This will add the necessary clips to hold the pcb in place.
// offset is the height of the bottom of the pcb from the bottom of the clips, 
// or in other words: the height of the clips.
// The clips are placed to have the bottom side of one of the corners of the PCB at [0,0,0]
//
// The clips are placed "in mid air", you still need to have some ground plate
// to attach the clips to. This is demonstrated in the module demo().
// 
wemos_d1_pcb_width = 26;
wemos_d1_pcb_length = 35;
wemos_d1_pcb_thickness = 2;
wemos_d1_thin_wall = 1.2;
wemos_d1_clip = 1; // radius of the wemos_d1_clip that sticks out at the top of a pillar.
wemos_d1_tab_width = 4;


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
module wemos_d1_mini_clip( offset = 5)
{

    // frame corners on the NW, NE side
    frame_corner( offset);
    translate([0, wemos_d1_pcb_width, 0]) mirror([0,1,0]) frame_corner(offset);
    
    //two tabs supporting the SE side
    translate([wemos_d1_pcb_length, wemos_d1_pcb_width, 0]) pillar(offset);
    translate([wemos_d1_pcb_length-wemos_d1_tab_width - 2*wemos_d1_clip, wemos_d1_pcb_width, 0]) rotate([0,0,90]) pillar(offset);
    
    // one pillar supporting the SW side (keep the west open for the reset button)
    translate([wemos_d1_pcb_length, wemos_d1_tab_width, 0]) pillar(offset);
    
    // two extra tabs holding the sides in the E and W position
    translate([wemos_d1_pcb_length + wemos_d1_tab_width, 0, 0] * .5) rotate([0,0,-90]) pillar( offset, false);
    translate([(wemos_d1_pcb_length - wemos_d1_tab_width)/2, wemos_d1_pcb_width, 0] )rotate([0,0,90]) pillar( offset, false);
}

module wemos_d1_mini_demo()
{
    offset = 5;

    wemos_d1_mini_clip( offset);
    
    // bottom to hold it all together
    translate([-wemos_d1_thin_wall, -wemos_d1_thin_wall,-offset]) cube([ wemos_d1_pcb_length, wemos_d1_pcb_width, 1] + 2*[wemos_d1_thin_wall, wemos_d1_thin_wall,0]);
}

wemos_d1_mini_demo();

