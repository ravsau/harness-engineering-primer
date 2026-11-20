// Stop hook: runs the unit tests every time the agent tries to finish.
// Exit code 2 blocks the finish and sends the message below back to the agent.
const { execSync } = require("node:child_process");
const fs = require("node:fs");
const path = require("node:path");
let input = "";
process.stdin.on("data", (d) => (input += d));
process.stdin.on("end", () => {
  const event = JSON.parse(input || "{}");
  const cwd = process.env.CLAUDE_PROJECT_DIR || event.cwd || process.cwd();
  const checks = ["node --test"];
  if (fs.existsSync(path.join(cwd, "check-voice.cjs"))) checks.push("node check-voice.cjs");
  try {
    for (const c of checks) execSync(c, { cwd, stdio: "pipe" });
    process.exit(0); // every check passes: the agent may finish
  } catch (err) {
    const out = String(err.stdout || "") + String(err.stderr || "");
    console.error(
      "A check fails, so the task is not done.\n" +
      "Fix the code until `node --test` passes, then finish. Do not change or delete the tests.\n\n" + out
    );
    process.exit(2);
  }
});
