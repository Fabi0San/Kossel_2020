include <configuration.scad>

$fn=360;
triangle_height = vertex_radius*3;
triangle_radius = triangle_height/1.5;
triangle_lenght = triangle_radius * cos(30) * 2;
bolt1 = 20;
bolt2 = 60;
echo(triangle_lenght);

module frame_reinforcement(cut = 0)
{
    difference(){
        union(){
            translate([0,-triangle_radius+vertex_radius*2] )
            difference(){
                rotate(-30) circle(r=triangle_radius, center=true, $fn=3);
                translate([0,vertex_radius*sqrt(2)+triangle_radius-vertex_radius*2 + vertex_radius* sin(30) ]) rotate(45)circle(r=vertex_radius*2,  center=true, $fn=4);
                }
            circle(r=vertex_radius, center=true, $fn=200);
        }
             tcut_radius = triangle_radius;
            translate([extrusion/-2,24.5-extrusion/2,0])
                square(extrusion-0.3);
        
        if(cut==1)
        {

      rotate([0, 0, 180])          
                translate([0, 36, 0]) minkowski() {
     intersection() {
      rotate([0, 0, -90]) circle(r=55, center=true, $fn=3);
      translate([0, -31, 0])  square([100, 15], center=true);
     }
     circle(r=6, center=true);
    }
        }
        //side_bolts
        translate([0,vertex_radius*2] )       
        for (side = [-1, 1]) {
            for (bolt = [bolt1, bolt2]) {
                rotate([0,0,side*30]) translate([-side * extrusion/2, -triangle_lenght+bolt ])
                    circle(r=m4_wide_radius);
            }
        }              
    }
}

//translate([0,24.5,0]) rotate([0,0,180]) linear_extrude(height=1) frame_reinforcement(cut=1);

//bottom
//frame_reinforcement(cut=0);
//top
frame_reinforcement(cut=0);


%import("frame_motor.stl"); //x-tower