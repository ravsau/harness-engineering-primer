// Post Checker — quick weekend version
// TODO: tests

// Same list as voice.md. Change both together.
var BANNED = ["—", "the kicker?", "the real issue?", "it wasn't just", "game-changer", "delve", "revolutionary", "groundbreaking"];
var LIMIT = 280;

function countX(text) {
  // voice.md: every link counts as 23, every emoji counts as 2
  var count = 0;
  var rest = text.replace(/https?:\/\/\S+/g, function () { count += 23; return ""; });
  var graphemes = new Intl.Segmenter().segment(rest);
  for (var g of graphemes) {
    count += /\p{Extended_Pictographic}/u.test(g.segment) ? 2 : [...g.segment].length;
  }
  return count;
}

function findBanned(text) {
  var found = [];
  var lower = text.toLowerCase();
  for (var i = 0; i < BANNED.length; i++) {
    var idx = lower.indexOf(BANNED[i]);
    while (idx != -1) {
      found.push({ word: BANNED[i], index: idx });
      idx = lower.indexOf(BANNED[i], idx + BANNED[i].length);
    }
  }
  found.sort(function (a, b) { return a.index - b.index; });
  return found;
}

// so I can try it in node
if (typeof module !== "undefined") module.exports = { BANNED: BANNED, LIMIT: LIMIT, countX: countX, findBanned: findBanned };
