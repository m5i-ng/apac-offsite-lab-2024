# Unless explicitly stated otherwise all files in this repository are dual-licensed
# under the Apache 2.0 or BSD3 Licenses.
#
# This product includes software developed at Datadog (https://www.datadoghq.com/)
# Copyright 2022 Datadog, Inc.
import logging
import time
import random

class NotesHelper:

    def long_running_process(self):
        # Generate a random sleep time between 0.5 and 1 sec
        sleep_time = random.uniform(0.5, 1)
        time.sleep(sleep_time)
        logging.info("Hello from the long running process")
        self.__private_method_1()

    def another_process(self):
        time.sleep(.05)
        logging.info("Hello from the another process")

    def __private_method_1(self):
        time.sleep(.03)
        logging.info("Hello from the private method")
