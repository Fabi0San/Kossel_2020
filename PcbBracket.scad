//pcb bracket

pcbW = 60.7; // pcb Width
pcbT = 1.65; // pcb Thickness
bS = 30; // bracket spacing
bSw = pcbW-3;
bt = 7.5; // bracket thickness
pt = 15.3; // plate thickness;
pw = 49.8;

bw = bSw + bt*2;
bh = bS+bt*2+pt+pcbT;

difference(){
translate([0,bt/2]) square([bw, bh-bt/2], center=false); // bracket body

// pcb
translate([(bw-pcbW)/2,bt]) square([pcbW, pcbT], center=false);

// plate
translate([(bw-pw)/2,bt+pcbT+bS+(bt/2)]) square([pw, pt], center=false);

// space
translate([(bw-bSw)/2,0]) square([bSw, bS+bt+pcbT], center=false);
   

}

echo(bw);
echo(bh-bt/2);