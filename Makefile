dev:
	hugo server -D
build:
	rm -rf public
	hugo --minify
