mw = 42;        // motor width
ms = 6;         // motor shank
gd = 6.3;        // groove depth
sw = 10;        // structure width(minimum)
q = 25.6/4;     // quarter inch
rs = 0;        // rail space
co = 20;       // clamp overlap
bh = 31;        // bottom hang
th = 0;        //top hang
$fn=180;


//bracket
difference(){
polygon([
[0,0],
[gd,0],
[gd,co],
[gd+rs,co],
[gd+rs+sw+mw+sw,co+bh],
[gd+rs+sw+mw+sw,co+bh+sw+mw],
[gd+rs+sw+mw,co+bh+sw+mw],
[gd+rs+sw+mw,co+bh+sw+ms],
[gd+rs+sw+mw-ms,co+bh+sw],
[gd+rs+sw+ms,co+bh+sw],
[gd+rs+sw,co+bh+sw+ms],
[gd+rs+sw,co+bh+sw+mw],
[gd+rs,co+bh+sw+mw+sw+th],
[gd,co+bh+sw+mw+sw+th],
[gd,co+bh+sw+mw+sw+th+co],
[0,co+bh+sw+mw+sw+th+co]
]);

translate([gd+rs+sw+mw+sw/2,co+bh+sw+mw-ms])
circle(d=2.2, center = true);

translate([gd+rs+sw/2,co+bh+sw+mw-ms])
circle(d=2.2, center = true);

echo(gd+rs+sw+mw+sw);
echo(co+bh+sw+mw+sw+th+co);
}

//Motor clamp
*difference(){
polygon([
[0,0],
[sw+mw+sw,0],
[sw+mw+sw,sw+mw/2],
[sw+mw,sw+mw/2],
[sw+mw,sw+ms],
[sw+mw-ms,sw],
[sw+ms,sw],
[sw,sw+ms],
[sw,sw+mw/2],
[0,sw+mw/2]
]);

translate([sw+mw+sw/2,sw+ms])
circle(d=3.2, center = true);

translate([sw/2,sw+ms])
circle(d=3.2, center = true);
echo(sw+mw+sw);
echo(sw+mw/2);

}

//clamp
*difference()
{
square([20,50]);
translate([10,45]) square([q-0.2,20],center=true);
translate([10,5]) circle(d=5);
}