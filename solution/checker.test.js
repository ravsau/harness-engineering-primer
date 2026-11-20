const { test } = require("node:test");
const assert = require("node:assert/strict");
const { countX, findBanned } = require("./checker.js");

const flagged = (text) => findBanned(text).map((f) => f.word);

test("plain text counts one per character", () => {
  assert.equal(countX("hello"), 5);
});

test("a link counts as 23 characters, whatever its length", () => {
  assert.equal(countX("see https://example.com/a/very/long/path/to/a/page"), 27);
});

test("an emoji counts as 2 characters", () => {
  assert.equal(countX("ok 👍"), 5);
});

test("flags delve whatever its case", () => {
  assert.deepEqual(flagged("Let's Delve in"), ["delve"]);
});

test("flags delve each time it appears", () => {
  assert.deepEqual(flagged("delve, then delve again"), ["delve", "delve"]);
});

test("flags \"the kicker?\" as one item", () => {
  assert.deepEqual(flagged("The kicker? It worked."), ["the kicker?"]);
});

test("flags the em dash", () => {
  assert.deepEqual(flagged("fast—cheap"), ["—"]);
});

test("a clean post has no flags", () => {
  assert.deepEqual(flagged("We cut our AI bill by 40% this month."), []);
});
