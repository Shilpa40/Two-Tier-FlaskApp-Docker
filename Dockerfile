# Step1: Use Python 3.8 as the base image
FROM python:3.8

# Step2: Set the working directory in the container
WORKDIR /app

# Step3: Install required system packages
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Step4: Copy the requirements file into the container
COPY requirements.txt .

#Step5: Install MySQL client and other Python dependencies
RUN pip install mysqlclient \
    && pip install --no-cache-dir -r requirements.txt

# Step6: Copy the application code into the container
COPY . .

# Step7: Expose the port the app runs on
EXPOSE 5000

# Step8: Define the command to run the application
CMD ["python", "app.py"]

