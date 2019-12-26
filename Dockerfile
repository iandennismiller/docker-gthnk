FROM iandennismiller/vnc:latest

COPY files/ /home/user
RUN chown -R user:user /home/user

RUN pip install gthnk
