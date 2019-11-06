from nvidia/cuda
#from informaticsmatters/rdkit-python3-debian
#from informaticsmatters/rdkit

#Anaconda3 Begin
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc
#Anaconda3 End

#RDKIT Begin
RUN conda create  -y  -c rdkit -n my-rdkit-env rdkit
RUN conda init bash
#RUN conda activate my-rdkit-env
##RDKIT END





USER root
#Jupyter config begin
COPY ./jupyter  /root/.jupyter
#Jupyter config end


### APP Begin ######
RUN mkdir   -p /app
WORKDIR     /app
COPY requirements.txt /app/
RUN . /opt/conda/etc/profile.d/conda.sh && \
       conda activate my-rdkit-env && \
       pip install -r /app/requirements.txt -i  https://mirrors.aliyun.com/pypi/simple/


COPY ./bin  /app/bin
COPY ./code /app/code

RUN chmod +x /app/bin/*.sh

EXPOSE 8888
CMD [ "/app/bin/batch.sh"]

#ENTRYPOINT ["jupyter", "notebook", "--allow-root"]