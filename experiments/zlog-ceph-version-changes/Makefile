output.png: visualize.ipynb $(shell find ./zlog-popper/experiments/basic-cls-overhead/results.* -name "*.log" -type f)
	docker run -v "`pwd`:/home/jovyan/work" \
		jupyter/scipy-notebook \
		jupyter nbconvert --stdout --execute $< > /dev/null
