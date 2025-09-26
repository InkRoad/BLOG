.PHONY: push
.PHONY: list
push:
	@git add . && \
	git commit -m "init" && \
	git push origin main
list:
	git remote -v

