include <configuration.scad>;
use <./threadsNew.scad>

separation = 40;  // Distance between ball joint mounting faces.
offset = 20;  // Same as DELTA_EFFECTOR_OFFSET in Marlin.
mount_radius = 12.5;  // Hotend mounting screws, standard would be 25mm.
hotend_radius = 8.2;  // Hole for the hotend (J-Head diameter is 16mm).
push_fit_height = 4;  // Length of brass threaded into printed plastic.
height = 5.5;
cone_r1 = 2.5;
cone_r2 = 14;

module effector() {
  difference() {
    union() {
//difference(){
//      cylinder(r=hotend_radius+1.5,h=height+7+9,$fn=96);
//      cylinder(r=hotend_radius,h=height+7,$fn=96);
//translate([0,0,height+7+9-2])
//difference(){
//cylinder(r=hotend_radius+1.5,h=2,$fn=96);
//cylinder(r=hotend_radius-0.5,h=2,$fn=96);
//rotate_extrude($fn=96)translate([hotend_radius-0.5,0,0])circle(r=2,$fn=60);
//}
//
////translate([0,0,height+7])cylinder(r1=hotend_radius,r2=6.7/2,h=6.15/2+0.3,$fn=96);
////translate([0,0,height+7+9-1])cylinder(r=5.5,h=height+7+9,$fn=96);
////translate([0,0,height+7+9-1])rotate_extrude($fn=96)translate([4.5,0,0]) circle(r=1,$fn=20);
////translate([0, 0,height+7+0.2]) english_thread(0.383*(8.85/8.35), 28, 8.5/25.4, internal=true);
//}

      cylinder(r=offset-3, h=height, center=true, $fn=128);
      for (a = [0,120,240]) rotate([0, 0, a]) {
	rotate([0, 0, 30]) translate([offset-2, 0, 0]) cube([10, 13, height], center=true);
	for (s = [-1, 1]) scale([s, 1, 1]) {


	  translate([0, offset, 0]) difference() {
intersection() {
	      cube([separation, 40, height], center=true);
	      translate([0, -4, 0]) rotate([0, 90, 0])
		cylinder(r=10, h=separation, center=true, $fn=96);
	      translate([separation/2-7, 0, 0]) rotate([0, 90, 0])
		cylinder(r1=cone_r2, r2=cone_r1, h=14, center=true, $fn=48);
	    }//}
	    rotate([0, 90, 0]) cylinder(r=m3_radius, h=separation+1, center=true, $fn=48);
	    rotate([90, 0, 90]) cylinder(r=m3_nut_radius, h=separation-24, center=true, $fn=6);
	  }
        }
      }
    }
		translate([0, 0, -height/2]) cylinder(r=hotend_radius, h=height, $fn=96);

    for (a = [60,180,300]) rotate([0, 0, a]) {
		translate([0, mount_radius, 0])
			cylinder(r=m3_wide_radius, h=2*height, center=true, $fn=36);
        	rotate([0, 0, 60]) translate([0, mount_radius, 0])
			cylinder(r=m3_wide_radius, h=2*height, center=true, $fn=36);
//		rotate([0, 0, 60])translate([0, 7, 0]) rotate([90, 0, 0])
//			cylinder(r=m3_radius, h=20, center=true, $fn=48);
//		rotate([0, 0, 60])translate([0, mount_radius-1.3, height/4])
//			cube([m3_nut_radius*2,3,height/2], center=true);
//		rotate([0, 0, 60])translate([0, mount_radius-1.3, 0])rotate([90, 0, 0])
//			cylinder(r=m3_nut_radius, h=3, center=true, $fn=6);
//		rotate([0, 0, 60])translate([0, 18.2, 0])
//			cube([m3_nut_radius*2,3,height], center=true);
    }
  }
}

translate([0, 0, height/2]) effector();
