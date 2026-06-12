# Input: array of Taskwarrior task objects
# Output: markdown grouped by .project

def clean(s): if s == null or s == "" then "-" else s end;

# Markdown string for each task
def line:
  "  - [" +
  (if .status == "completed" then "x" else " " end) +
  "] " +
  (.description) +
  (if has("workid") or has("repo") or has("mr") then " ||" else "" end) +
  (if .workid then " *\(.workid)*" else "" end) +
  (if .repo then " `\(.repo)`" else "" end) +
  (if .mr then " !\(.mr)" else "" end);

# Sorting within projects:
# You can pick any sort order; the example uses:
#   1. by project name
#   2. then by status (completed last)
#   3. then by description
#   (You can customize freely.)
def sort_tasks:
  sort_by(
    (.project // ""),
    (if .status == "completed" then 1 else 0 end),
    (.description // "")
  );

# MAIN OUTPUT
# ---------------------------------------
# Tasks without projects are grouped under "Other".
#
group_by(.project)
| sort_by(.[0].project // "")
| map({
    project: (.[0].project // "Other" | if . == "" then "Other" else . end),
    tasks: sort_tasks
  })
| map(
    "- \(.project):\n" +
    (.tasks | map(line) | join("\n"))
  )
| join("\n")
