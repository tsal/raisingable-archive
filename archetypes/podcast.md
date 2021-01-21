---
title: "{{ replace .Name "-" " " | title }}"
episode:
- "{{ .Name }}"
date: {{ .Date }}
draft: true
---
