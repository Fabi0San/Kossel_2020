$fn=180;
supportRad=25;
supportHgt=20;
fsrDia=18.5;
fsrWellDpt = 5.6;
fsrTck = 1.2;
fsrWdt = 10;
wallTck = 2;

module bolt()
{
    rotate([-90,0,0])
    union()
    {
        hull()
        {
            translate([0,-3,0]) cylinder(d=4,h=10);
            translate([0,3,0]) cylinder(d=4,h=10);
        }

        hull()
        {
            translate([0,-3,10]) cylinder(d=7.2,h=25);
            translate([0,3,10]) cylinder(d=7.2,h=25);
        }
    }
}

module tunnel()
{      
    rotate([180,-90,0]) 
    {        
        translate([0,-(supportRad-fsrDia-wallTck),-fsrWdt/2])
        difference()   
        {
            union(){
            translate([-.01,0,0])
            cube([(supportHgt-fsrWellDpt+fsrTck+.01),(supportRad-fsrDia-wallTck+.01),fsrWdt]);
                translate([(supportHgt-fsrWellDpt),-fsrDia/2,0]) cube([fsrTck,fsrDia/2,fsrWdt]);
            }
            resize([(supportHgt-fsrWellDpt)*2,(supportRad-fsrDia-wallTck-fsrTck)*2,fsrWdt])
                cylinder(r=supportHgt, h=fsrWdt);
        }
    }
}



//render(1)
difference()
{
    cylinder(r=supportRad, h=supportHgt);    
    translate([-supportRad, -supportRad,0]) 
        cube([supportRad*2, supportRad, supportHgt]);
    
    translate([0,supportRad-fsrDia/2-wallTck, supportHgt-fsrWellDpt]) 
        cylinder(d=fsrDia+0.5, h=fsrWellDpt);

    translate([supportRad/1.75,-5,supportHgt/2]) 
        bolt();
    translate([-supportRad/1.75,-5,supportHgt/2]) 
        bolt();     
    //#translate([0,-1,0]) 
        tunnel();       
}

//!tunnel();


