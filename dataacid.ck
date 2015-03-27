/*
Data on Acid hack

Iain Emsley

SSI hack March 2015

*/

//SawOsc s => dac;
Flute flute => PoleZero f => JCRev r => dac;
.95 => r.gain;
.05 => r.mix;
.99 => f.blockZero;

.2 => float timeSt;
// print out all arguments

// print out all arguments
me.arg(0) => string fname;

int drama[5000];
readInts(fname) @=> drama;

for (0 => int i; i<drama.cap();i++) {
      play(flute,drama[i],.5);
}

// play the note
fun void play(Flute flute, int note, float velocity) {
    // start the note
    Std.mtof( note ) => flute.freq;
    velocity => flute.noteOn;
    .6      => flute.gain;
    100::ms => now;
    velocity => flute.noteOff;
    //10::ms => now;
}

// read the ints into an array
// http://wiki.cs.princeton.edu/index.php/ChucK/Dev/IO/FileIO
fun int[] readInts(string path) {
    
    // open the file
    FileIO file;
    if (!file.open(path, FileIO.READ)) {
        <<< "file read failed" >>>;
        <<< path >>>;
        int ret[0]; // error opening the specified file
        return ret;
    }
    
    // read the size of the array
    //4096 => int size;
    file => int size;
    // now read in the contents
    int ret[size];
    for (0 => int i; i < size; i++) 
        file => ret[i];

    file.close();   
    return ret;    
}
