
let c = el("output");
c.width = 512;
c.height = 480;
let ctx = c.getContext("2d");
let imgData = ctx.getImageData(0, 0, 512, 480);

let loopId = 0;
let loaded = false;
let paused = false;
let pausedInBg = false;

let romArr = new Uint8Array([]);

let snes = new Snes();

let audioHandler = new AudioHandler();

let logging = false;
let noPpu = false;

zip.workerScriptsPath = "lib/";
zip.useWebWorkers = false;

let controlsP1 = {
  z: 0, // B
  a: 1, // Y
  shift: 2, // select
  enter: 3, // start
  arrowup: 4, // up
  arrowdown: 5, // down
  arrowleft: 6, // left
  arrowright: 7, // right
  x: 8, // A
  s: 9, // X
  d: 10, // L
  c: 11 // R
}

// button rom change, we disable this....
// el("rom").onchange = function(e) {
//   console.log(e.target.files[0])
//   let freader = new FileReader();
//   freader.onload = function() {
//     console.log("loaded")
//     let buf = freader.result;
//     if(e.target.files[0].name.slice(-4) === ".zip") {
//       // use zip.js to read the zip
//       let blob = new Blob([buf]);
//       zip.createReader(new zip.BlobReader(blob), function(reader) {
//         reader.getEntries(function(entries) {
//           if(entries.length) {
//             let found = false;
//             for(let i = 0; i < entries.length; i++) {
//               let name = entries[i].filename;
//               if(name.slice(-4) !== ".smc" && name.slice(-4) !== ".sfc") {
//                 continue;
//               }
//               found = true;
//               log("Loaded \"" + name + "\" from zip");
//               entries[i].getData(new zip.BlobWriter(), function(blob) {
//                 let breader = new FileReader();
//                 breader.onload = function() {
//                   let rbuf = breader.result;
//                   romArr = new Uint8Array(rbuf);
//                   loadRom(romArr);
//                   reader.close(function() {});
//                 }
//                 breader.readAsArrayBuffer(blob);
//               }, function(curr, total) {});
//               break;
//             }
//             if(!found) {
//               log("No .smc or .sfc file found in zip");
//             }
//           } else {
//             log("Zip file was empty");
//           }
//         });
//       }, function(err) {
//         log("Failed to read zip: " + err);
//       });
//     } else {
//       // load rom normally
//       romArr = new Uint8Array(buf);
//       loadRom(romArr);
//     }
//   }
//   console.log("read buffer")
  
//   freader.readAsArrayBuffer(e.target.files[0]);
// }

test = async function() {
  var rawFile = await fetch('https://nielsezeka.github.io/data/Super_Mario_World.smc');
  var file = new File([await rawFile.blob()], 'Super_Mario_World.smc');
  let freader = new FileReader();
  freader.onload = function() {
    console.log("loaded")
    let buf = freader.result;
    if(file.name.slice(-4) === ".zip") {
      // use zip.js to read the zip
      let blob = new Blob([buf]);
      zip.createReader(new zip.BlobReader(blob), function(reader) {
        reader.getEntries(function(entries) {
          if(entries.length) {
            let found = false;
            for(let i = 0; i < entries.length; i++) {
              let name = entries[i].filename;
              if(name.slice(-4) !== ".smc" && name.slice(-4) !== ".sfc") {
                continue;
              }
              found = true;
              log("Loaded \"" + name + "\" from zip");
              entries[i].getData(new zip.BlobWriter(), function(blob) {
                let breader = new FileReader();
                breader.onload = function() {
                  let rbuf = breader.result;
                  romArr = new Uint8Array(rbuf);
                  loadRom(romArr);
                  reader.close(function() {});
                }
                breader.readAsArrayBuffer(blob);
              }, function(curr, total) {});
              break;
            }
            if(!found) {
              log("No .smc or .sfc file found in zip");
            }
          } else {
            log("Zip file was empty");
          }
        });
      }, function(err) {
        log("Failed to read zip: " + err);
      });
    } else {
      // load rom normally
      romArr = new Uint8Array(buf);
      loadRom(romArr);
    }
  }
  console.log("read buffer")
  
  freader.readAsArrayBuffer(file);
}
test()

// change the button click to a function for later use
//el("pause").onclick = function() {
pauseGame = function() {
  if(paused && loaded) {
    loopId = requestAnimationFrame(update);
    audioHandler.start();
    paused = false;
    el("pause").textContent = "Pause";
  } else {
    cancelAnimationFrame(loopId);
    audioHandler.stop();
    paused = true;
    el("pause").textContent = "Continue";
  }
}
// change the button click to a function for later use
// el("reset").onclick = function(e) {
resetGame = function() {
  snes.reset(false);
}
// change the button click to a function for later use
// el("hardreset").onclick = function(e) {
hardResetGame = function() {
  snes.reset(true);
}

// el("runframe").onclick = function(e) {
//   if(loaded) {
//     runFrame();
//   }
// }

// el("ishirom").onchange = function(e) {
//   if(loaded) {
//     // reload when switching from LoROM to HiROM
//     loadRom(romArr);
//   }
// }

document.onvisibilitychange = function(e) {
  if(document.hidden) {
    pausedInBg = false;
    if(!paused && loaded) {
      el("pause").click();
      pausedInBg = true;
    }
  } else {
    if(pausedInBg && loaded) {
      el("pause").click();
      pausedInBg = false;
    }
  }
}

function loadRom(rom) {
  let hiRom = false ;//el("ishirom").checked; hard codeing to always use hi rom
  if(snes.loadRom(rom, hiRom)) {
    snes.reset(true);
    if(!loaded && !paused) {
      loopId = requestAnimationFrame(update);
      audioHandler.start();
    }
    loaded = true;
  }
}

function runFrame() {

  if(logging) {
    do {
      snes.cycle();
      // TODO: some way of tracing the spc again

      // if((snes.xPos % 20) === 0 && snes.apu.spc.cyclesLeft === 0) {
      //   log(getSpcTrace(
      //     snes.apu.spc, snes.apu.cycles
      //   ));
      // }
    } while(
      snes.cpuCyclesLeft > 0 ||
      (snes.xPos >= 536 && snes.xPos < 576) ||
      snes.hdmaTimer > 0
    );
    log(getTrace(
      snes.cpu, snes.frames * 1364 * 262 + snes.yPos * 1364 + snes.xPos
    ));
  } else {
    snes.runFrame(noPpu);
  }

  snes.setPixels(imgData.data);
  ctx.putImageData(imgData, 0, 0);
  snes.setSamples(audioHandler.sampleBufferL, audioHandler.sampleBufferR);
  audioHandler.nextBuffer();
}

function update() {
  runFrame();
  loopId = requestAnimationFrame(update);
}

window.onkeydown = function(e) {
  switch(e.key) {
    case "l":
    case "L": {
      logging = !logging;
      break;
    }
    case "p":
    case "P": {
      noPpu = !noPpu;
      break;
    }
  }
  if(controlsP1[e.key.toLowerCase()] !== undefined) {
    e.preventDefault();
    snes.setPad1ButtonPressed(controlsP1[e.key.toLowerCase()]);
  }
}

window.onkeyup = function(e) {
  if(controlsP1[e.key.toLowerCase()] !== undefined) {
    e.preventDefault();
    snes.setPad1ButtonReleased(controlsP1[e.key.toLowerCase()]);
  }
}

function log(text) {
  // el("log").innerHTML += text + "\n";
  // el("log").scrollTop = el("log").scrollHeight;
}

function getByteRep(val) {
  return ("0" + val.toString(16)).slice(-2).toUpperCase();
}

function getWordRep(val) {
  return ("000" + val.toString(16)).slice(-4).toUpperCase();
}

function getLongRep(val) {
  return ("00000" + val.toString(16)).slice(-6).toUpperCase();
}

function clearArray(arr) {
  for(let i = 0; i < arr.length; i++) {
    arr[i] = 0;
  }
}

function el(id) {
  return document.getElementById(id);
}
