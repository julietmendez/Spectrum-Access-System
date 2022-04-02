FROM continuumio/miniconda3:4.10.3p1

ARG PYTHON_VER=3.7

WORKDIR /opt/app

ADD . .

RUN conda create --name "winnf3" python=${PYTHON_VER}

# We can't activate a conda env non-interactively
# or in a CI env, so let's use env targetting
# by passing the `-n` option to conda commands

RUN conda install -n "winnf3" -y numpy \
        shapely \
        gdal \
        lxml \
        jsonschema \
        matplotlib \
        cartopy \
        cryptography \
        pyopenssl \
        pycurl

RUN conda run -n "winnf3" pip3 install pygc \
        pykml \
        xlsxwriter \
        jwt \
        portpicker \
        psutil \
        ftputil

RUN chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"] 

# Default python script pass to the entrypoint
CMD ["src/harness/test_main.py"]
