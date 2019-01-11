#!/bin/sh

SUCCESS=0
FAILURE=1

true &&
		./example 5 &&
		exit ${SUCCESS}

exit ${FAILURE}
