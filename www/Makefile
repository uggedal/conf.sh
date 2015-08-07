.PHONY: deploy

www := /srv/http/conf.sh

deploy:
	@rsync -a --info=NAME --force --delete --exclude=Makefile -e ssh ./ $(HOST):$(www)
