## Use the python 3.9 image
FROM python:3.9

## Set the working directory to /code
WORKDIR /code

## Copy the current directory contents in the container at /code
COPY ./requirements.txt /code/requirements.txt

## Install Python dependencies
RUN pip install --no-cache-dir --upgrade -r requirements.txt

## Create a user named 'user' with appropriate permissions
RUN useradd user

## Create /home/user directory and set ownership to 'user'
RUN mkdir -p /home/user && chown -R user:user /home/user

## Switch to the 'user' user
USER user

## Set environment variables
ENV Home=/home/user \
    PATH=/home/user/.local/bin:$PATH

## Set the working directory to the user's home directory
WORKDIR $Home/app

## Copy the current directory contents into the container at $HOME/app setting the owner to user
COPY --chown=user . $Home/app

## Start the FAST API on port number 7860
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "7860"]
