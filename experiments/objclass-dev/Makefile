timestamp: visualize.ipynb data.csv
	docker run -v "`pwd`:/home/jovyan/work" \
		jupyter/scipy-notebook \
		jupyter nbconvert --stdout --execute $< > /dev/null
	touch timestamp
