---
date: {{format-date now "%d.%m.%Y %T"}}
tags: [daily, scrum]
---
# Daily: {{format-date now "long"}}

[Last working day]({{sh 'zk list meetings/daily --format="{{filename}}" --limit=1 --created-before=today'}}):

Today:
