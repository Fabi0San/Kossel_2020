include <configuration.scad>;

use <vertex.scad>;
use <nema17.scad>;

$fn = 280;

fin_w=5;
fin_d=4;  // 5x4 for the vertical extrusion fins
fins=1;   // Yes use fins

motor_frame_height = 75;
motor_z_offset = 1.5; // use 1.5 for 40mm height

module frame_motor() {
  difference() {
    // No idler cones.
  vertex(motor_frame_height, idler_offset=0, idler_space=100, fin_w=fin_w, fin_d=fin_d, fins=fins, fn=200);

    // KOSSEL logotype.
    translate([24, -8, 0]) rotate([90, -90, 25])
      linear_extrude(height = 2) scale(1.5)
        text("JARVIS", font = "Agency FB:style=bold", 
            halign="center", valign="bottom", $fn=200);

    translate([-24, -8, 0]) rotate([90, -90, -25])
      linear_extrude(height = 2) scale(1.5)
        text("KOSSEL", font = "Agency FB:style=bold", 
            halign="center", valign="top", $fn=200);
      
    // Motor cable paths.
    for (mirror = [-1, 1]) scale([mirror, 1, 1]) {
      translate([-35, 45, 0]) rotate([0, 0, -30])
         cube([4, 15, motor_frame_height - 2* extrusion ], center=true);
      translate([-6-3, 0, 0]) cylinder(r=3.5, h=40);
      translate([-11, 0, 0])  cube([15, 5.2, motor_frame_height - 1.5* extrusion], center=true);
    }
    
    // Motor shaft/pulley cutout.
    translate([0, motor_offset, motor_z_offset]) {
      rotate([90, 0, 0]) cylinder(r=12, h=20, center=true);
      // NEMA 17 stepper motor mounting screws.
      for (x = [-1, 1]) for (z = [-1, 1]) {
        scale([x, 1, z]) translate([31/2, -5, 31/2]) {
          rotate([90, 45, 0]) cylinder(r=1.65, h=20, center=true);
          
          // Easier tool access to motor mount bolts.
          rotate([75, -25, 0])  cylinder(r=m3_wide_radius, h=motor_frame_height*2);
        }
      }
    }
    
    // Draw motor in just for show
    %translate([0, motor_offset, motor_z_offset]) rotate([90, 0, 0]) nema17();
  }
}

// build the motor frame and move it to the platform
translate([0, 0, motor_frame_height/2]) frame_motor();

//Draw extrusions for show.
%rotate(-30)translate([vertex_x_offset+0.25,vertex_y_offset/2,0])
translate([10,0,10+30])rotate([-90,0,0])
 difference(){
    import("./mk_visual_calc2020/2020_1000mm.stl", convexity=10);
    translate([-12,-12,240])cube([24,24,(1000-240)+2]);
  }

%rotate(-30)translate([vertex_x_offset+0.25,vertex_y_offset/2,0])
translate([10,0,10])rotate([-90,0,0])
 difference(){
    import("./mk_visual_calc2020/2020_1000mm.stl", convexity=10);
    translate([-12,-12,240])cube([24,24,(1000-240)+2]);
  }

%rotate(30)translate([-vertex_x_offset-0.25,vertex_y_offset/2,0])
translate([-10,0,10+30])rotate([-90,0,0])
 difference(){
    import("./mk_visual_calc2020/2020_1000mm.stl", convexity=10);
    translate([-12,-12,240])cube([24,24,(1000-240)+2]);
  }

%rotate(30)translate([-vertex_x_offset-0.25,vertex_y_offset/2,0])
translate([-10,0,10])rotate([-90,0,0])
 difference(){
    import("./mk_visual_calc2020/2020_1000mm.stl", convexity=10);
    translate([-12,-12,240])cube([24,24,(1000-240)+2]);
  }




