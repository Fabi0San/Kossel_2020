include <configuration.scad>;

$fn = 80;
roundness = 4.5;

body1_cylinder_offset = 22;  //22
body2_cylinder_offset = -30; //-37

module extrusion_cutout(h, extra, cut_w=2, cut_d=2, corner_r=0.5) {
  render(2)
  difference() {
    union(){
      cube([extrusion+extra, extrusion+extra, h], center=true);
      for(x = [-1,])for(y = [-1,1])
        translate([x*(extrusion-corner_r)/2,y*(extrusion-corner_r)/2,0]) cylinder(h=h, r=corner_r,center=true);
    }
    for (a = [0:90:359]) rotate([0, 0, a]) {
      translate([(extrusion-cut_d)/2+0.5, 0, 0]) cube([cut_d, cut_w, h+1], center=true);
    }  
  }
}

module screw_socket() {
 cylinder(r=m5_wide_radius, h=20, center=true);
 translate([0, 0, 3.8]) cylinder(r=m5_head_radius, h=8);
}

module screw_socket_cone() {
 union() {
  screw_socket();
  scale([1, 1.8, -1]) rotate(45)cylinder(r1=11/2*sqrt(2), r2=extrusion/2, h=5.5, $fn=4);
 }
}

module fin(fin_l=50, fin_w=2, fin_d=2){
    render(2)
  rotate([0,90,0])cylinder(h=fin_l, r=fin_d/2, center=true);
}

module vertex(height, idler_offset, idler_space, fin_w=5, fin_d, fins=0, fn=180) {
 translate([0,2.5,0])union() {
 // Pads to improve print bed adhesion for slim ends.
  translate([-37.5, 52.2, -height/2]) cylinder(r=8, h=0.4);
  translate([37.5, 52.2, -height/2]) cylinder(r=8, h=0.4);

  difference() {
   union() {
    //fins
    if(fins > 0)
      for(x = [-1,1])for(z = [-1,1])
        translate([x*29.5,35,z*(height-extrusion)/2]) rotate([0,0,x*60])  
          fin(50,fin_d,fin_w+1);
    
    //main body
    intersection() {
     translate([0, body1_cylinder_offset, 0]) cylinder(r=vertex_radius, h=height, center=true, $fn=fn*2);
     translate([0, body2_cylinder_offset, 0]) rotate([0, 0, 30]) cylinder(r=50, h=height+1, center=true, $fn=6);
    }
    
    translate([0, 38, 0]) intersection() {
     rotate([0, 0, -90]) cylinder(r=55, h=height, center=true, $fn=3);
     translate([0, 10, 0]) cube([100, 100, 2*height], center=true);
     translate([0, -10, 0]) rotate([0, 0, 30]) cylinder(r=55, h=height+1, center=true, $fn=6);
    }
   }
   
   difference() {   
    translate([0, 58, 0]) minkowski() {
     intersection() {
      rotate([0, 0, -90]) cylinder(r=55, h=height, center=true, $fn=3);
      translate([0, -31, 0])  cube([100, 15, 2*height], center=true);
     }
     cylinder(r=roundness, h=1, center=true);
    }
  
    // Idler support cones.
    for(i=[-1,1]) render(2) translate([0, 26+idler_offset+30*i, 0]) rotate([i*90, 0, 0]) cylinder(r1=30, r2=2, h=30-idler_space/2, $fn=fn);
   }
   //render(2)
  translate([0, 58, 0]) minkowski() {
    intersection() {
     rotate([0, 0, -90]) cylinder(r=55, h=height, center=true, $fn=3);
     translate([0, 7, 0]) cube([100, 30, 2*height], center=true);
    }
    cylinder(r=roundness, h=1, center=true);
   }
   
   translate([0,-2.5,0])extrusion_cutout(height+10, 0.15, fin_w, fin_d,corner_r=1);

   for (z = [-height/2 + extrusion/2 , height/2 - extrusion/2] ) {
    translate([0, -extrusion/2-extra_radius+extrusion_fin_d-5, z]) rotate([90, 0, 0]) screw_socket_cone();
    for (a = [-1, 1]) {
     rotate([0, 0, 30*a]) translate([-(vertex_radius-body1_cylinder_offset)*a, 111, z]) {
      // Screw sockets.
      for (y = [-81, -48]) {
       translate([a*(extrusion/2+1.4), y, 0]) rotate([0, a*90, 0]) screw_socket();
      }
     //render(2)
      // Nut tunnels.
      for (z = [-1, 1]) {
        scale([1, 1, z]) 
          translate([0, -99, 3]) 
            minkowski() {
	      rotate([0, 0, -a*30]) cylinder(r=5, h=16);
		cube([0.1, 8, 0.1], center=true);
	    }
      }
     }
    }
   }
   // ease the inside coners
   //vertex_y_offset =0;
   //vertex_x_offset=0;
   translate([1,-2.5,0])
   rotate(-30)
   translate([vertex_x_offset,vertex_y_offset/2,0])cylinder(h=height+1, r=1, center=true);
   translate([-1,-2.5,0])
   rotate(30)
   translate([-vertex_x_offset,vertex_y_offset/2,0])cylinder(h=height+1, r=1, center=true);
       }
 }
}



translate([0, 0, extrusion*2.5/2]) 
vertex(extrusion*2.5, idler_offset=0, idler_space=10, fin_w=5, fin_d=4, fins=1, fn=200 );
//rotate([0,0,30])translate([-4.5,72,0])#cube(5.5, center=true);


