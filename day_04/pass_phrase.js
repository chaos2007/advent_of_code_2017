const assert = require('assert');

function unique_phrases(phrase) {
    var before = phrase.length;
    var after = new Set(phrase).size
    return before == after;
}

function contains_anagrarms(phrase) {
    var words = {};
    for (let word of phrase) {
        var characters = word.split('').sort().join();
        words[characters] = true;
    }
    return Object.keys(words).length != phrase.length;
}

function valid_passphrase(phrase) {
    var phrases = phrase.split(' ');
    return unique_phrases(phrases);
}

function valid_strict_passphrase(phrase) {
    var phrases = phrase.split(' ');
    return unique_phrases(phrases) && !contains_anagrarms(phrases);
}

assert.ok(valid_passphrase("aa bb cc dd ee"));
assert.ok(!valid_passphrase("aa bb cc dd aa"));
assert.ok(valid_passphrase("aa bb cc dd aaa"));
assert.ok(valid_strict_passphrase("abcde fghij"));
assert.ok(!valid_strict_passphrase("abcde xyz ecdab"));
assert.ok(valid_strict_passphrase("a ab abc abd abf abj"));
assert.ok(valid_strict_passphrase("iiii oiii ooii oooi oooo"));
assert.ok(!valid_strict_passphrase("oiii ioii iioi iiio"));


fs = require('fs')
var os = require('os');

fs.readFile('puzzle_input.txt', 'utf8', function (err,data) {
  if (err) {
    return console.log(err);
  }
  var num_phrases = 0;
  for (let item of data.split(os.EOL)) {
      if( valid_passphrase( item) ) {
          num_phrases+=1;
      }
  }
  assert.equal(num_phrases, 477);

  var num_phrases = 0;
  for (let item of data.split(os.EOL)) {
      if( valid_strict_passphrase( item) ) {
          num_phrases+=1;
      }
  }
  assert.equal(num_phrases, 167);
  
});