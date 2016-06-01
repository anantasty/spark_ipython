#!/usr/bin/env bash

SPARK_CLASSPATH="/usr/local/spark/lib/*.jar" PYSPARK_DRIVER_PYTHON=jupyter PYSPARK_DRIVER_PYTHON_OPTS="notebook --port=8888 --ip=0.0.0.0 --no-browser" /usr/local/spark/bin/pyspark --jars /usr/local/spark/lib/kafka_assembly.jar,/usr/local/spark/lib/pyspark-elastic-0.4.2.jar  --packages com.stratio.datasource:spark-mongodb_2.10:0.11.2,TargetHolding:pyspark-elastic:0.4.2 --py-files=/usr/local/spark/lib/pyspark_elastic-0.2.0-py2.7.egg --conf spark.es.nodes=elasticsearch
#SPARK_CLASSPATH="/usr/local/spark-1.5.1-bin-hadoop2.6/lib/kafka_assembly.jar" IPYTHON_OPTS="notebook --no-browser --ip=* --port=8888" /usr/local/spark/bin/pyspark --jars /usr/local/spark-1.5.1-bin-hadoop2.6/lib/kafka_assembly.jar
