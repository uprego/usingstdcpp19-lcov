#!/bin/sh

SUCCESS=0
FAILURE=1

true &&
		(./example || true) &&
		(./example mierda || true) &&
		(./example a || true) &&
		(./example \. || true) &&
		./example 5 &&
		exit ${SUCCESS}

exit ${FAILURE}
