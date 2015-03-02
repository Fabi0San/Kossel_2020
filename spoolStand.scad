bd = 120; // bearing distance
bh = 32; //bearing height
bod = 16; // bearing outside diameter
wod = 25; // wheel outside diameter
bid = 5.2; // bearing inside diameter

gd = 6;        // groove depth
gw = 6;         // groove width
pt = 5.95; //pane thickness

$fn=180;
*difference()
{
    union()
    {
    
    //main body
    intersection()
    {
    difference()
    {
    translate([bd/2,bh+bod])
    circle(d=bd+bod);
    //translate([bd/2,bd+bod*1.4])    circle(r=bd);
    }
        translate([-bod/4,0,0])
        square([bd+bod/2,bh+bod/2-1]);
    }
    
    
    
        translate([0,bh])
        circle(d=bod);
        translate([bd,bh])
        circle(d=bod);
    }
    
    translate([0,bh])
    circle(d=bid);
    translate([bd,bh])
    circle(d=bid);
    
    translate([20,0,0])
    square([pt,gd]);

    translate([bd-pt-20,0,0])
    square([pt,gd]);
}

echo(bd+bod);
echo(bh+bod/2);

sw = 73; // spool width
ph = 12; //printer height
ps = 10; //printer spacing

difference(){
square([10+gw/2+ps+pt+sw+pt+ps,ph+gd]);
translate([gw,0]) square([10-gw/2+3,gd]);
translate([10+gw/2+ps,0]) #square([pt,ph]);
translate([10+gw/2+ps+pt+sw,0]) #square([pt,ph]);
}

echo(10+gw/2+ps+pt+sw+ps);
echo(ph+gd);


