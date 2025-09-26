.PHONY: push
.PHONY: list
.PHONY: bind
.PHONY: rebind

LOCAL ?=
REPO ?=

push:
	@git add . && \
	git commit -m "init" && \
	git push origin main

list:
	@git remote -v

bind:
	@git remote add $(LOCAL) git@github.com:InkRoad/$(REPO).git 

rebind:
	@git remote set-url ${LOCAL} git@github.com:InkRoad/${REPO}.git
