FROM sequenceiq/hadoop-ubuntu:2.6.0
MAINTAINER anant.asty@gmail.com

RUN apt-get update && apt-get install -y python-pip \
            python-lxml \
            python-dev


RUN curl -s http://d3kbcqa49mib13.cloudfront.net/spark-1.5.1-bin-hadoop2.6.tgz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s spark-1.5.1-bin-hadoop2.6 spark
ENV SPARK_HOME /usr/local/spark
RUN mkdir $SPARK_HOME/yarn-remote-client
ADD yarn-remote-client $SPARK_HOME/yarn-remote-client

RUN $BOOTSTRAP && $HADOOP_PREFIX/bin/hadoop dfsadmin -safemode leave && $HADOOP_PREFIX/bin/hdfs dfs -put $SPARK_HOME-1.5.1-bin-hadoop2.6/lib /spark

ENV YARN_CONF_DIR $HADOOP_PREFIX/etc/hadoop
ENV PATH $PATH:$SPARK_HOME/bin:$HADOOP_PREFIX/bin

RUN apt-get install -y libncurses-dev

RUN pip install "ipython[all]"
RUN pip install supervisor
RUN apt-get install -y openssh-server
ADD supervisord.conf supervisord.conf
COPY bootstrap.sh /etc/bootstrap.sh
RUN chown root.root /etc/bootstrap.sh
RUN chmod 700 /etc/bootstrap.sh
RUN mkdir -p /home/root
ADD start_ipython.sh /home/root/start_ipython.sh
ADD requirements.pip requirements.pip
RUN pip install -r requirements.pip
ENTRYPOINT ["/etc/bootstrap.sh"]


