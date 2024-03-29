heroku-login:
	HEROKU_API_KEY=${HEROKU_API_KEY} heroku container:login

build-ml-api-heroku: heroku-login
	docker build --build-arg PIP_EXTRA_INDEX_URL=${PIP_EXTRA_INDEX_URL} -t registry.heroku.com/${HEROKU_APP_NAME}/web .

push-ml-api-heroku: heroku-login
	docker push registry.heroku.com/${HEROKU_APP_NAME}/web

release-heroku: heroku-login
	heroku container:release web --app ${HEROKU_APP_NAME}

build-ml-api-aws:
	docker build --build-arg PIP_EXTRA_INDEX_URL=${PIP_EXTRA_INDEX_URL} -t $(NAME):$(COMMIT_ID) .

push-ml-api-aws:
	docker push ${AWS_ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com/$(NAME):$(COMMIT_ID)

tag-ml-api:
	docker tag $(NAME):$(COMMIT_ID) ${AWS_ACCOUNT_ID}.dkr.ecr.us-east-1.amazonaws.com/$(NAME):$(COMMIT_ID)
