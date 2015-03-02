include <configuration.scad>;
use <vertex.scad>;

$fn = 240;

module frame_top() {
  difference() {
    vertex(extrusion+0.1, idler_offset=0, idler_space=12.7, fin_w=5.2, fin_d=4, fins=1, fn=280);
    
    // M5 bolt to support idler bearings.
    translate([0, 25+15, 0]) rotate([90, 0, 0]) cylinder(r=m5_wide_radius, h=25);

   //sink innner belt pulley screw
   translate([0,49-thickness,(extrusion/2)/2-5])rotate([90,0,0])cylinder(h=12, r=m5_head_radius+0.2, center=true);

    // nut well 
    translate([0, 19, 0]) rotate([90, 30, 0]) cylinder(r1=m5_nut_radius+0.2, r2=m5_nut_radius+0.3, h=20, $fn=6);

    // remove fin tip    
    translate([0, 7, 8]) cube([5.6, 6, 10], center=true);   
  }
}

translate([0, 0, extrusion/2]) frame_top();
