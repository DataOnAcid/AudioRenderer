/*
Data on Acid hack

Iain Emsley

SSI hack March 2015

*/

Flute flute => PoleZero f => JCRev r => dac;
.8 => r.gain;
.05 => r.mix;
.99 => f.blockZero;

.2 => float timeSt;
//recording
dac => Gain g => WvOut w => blackhole;

// print out all arguments
me.arg(0) => string original;
me.arg(1) => string outname;

int texta[5000];

int size;
//create the array and push into a variable
readInts(original) @=> texta;

outname => w.wavFilename;

// any gain you want for the output
.5 => g.gain;

//start recording
1 => w.record;

for (0 => int i; i<size;i++) {
      play(flute,texta[i],.5);
}

//stop recording
0 => w.record;

// temporary workaround to automatically close file on remove-shred
null @=> w;

// play the note
// play the note
fun void play(Flute flute, int note, float velocity) {
    // start the note
    Std.mtof( note ) => flute.freq;
    velocity => flute.noteOn;
    .6      => flute.gain;
    100::ms => now;
    velocity => flute.noteOff;
  
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
    file => size;
    // now read in the contents
    int ret[size];
    for (0 => int i; i < size; i++) 
        file => ret[i];

    file.close();   
    return ret;    
}
