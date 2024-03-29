FROM python:3.9.4

# Create the user that will run the app
RUN adduser --disabled-password --gecos '' ml-api-user

WORKDIR /opt/house-price-api

ARG PIP_EXTRA_INDEX_URL

# Install requirements, including from Gemfury
ADD ./house-price-api /opt/house-price-api/
RUN pip install --upgrade pip
RUN pip install -r /opt/house-price-api/requirements.txt

RUN chmod +x /opt/house-price-api/run.sh
RUN chown -R ml-api-user:ml-api-user ./

USER ml-api-user

EXPOSE 8000
# 8001

CMD ["bash", "./run.sh"]
